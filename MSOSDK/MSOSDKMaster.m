//
//  MSOSDKMaster.m
//  iMobileRep
//
//  Created by John Setting on 6/27/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import "MSOSDKMaster.h"

static NSString * netserverIpAddress;
static NSString * deviceName;
static NSString * deviceIPAddress;
static NSString * eventId;
static NSString * msoPassword;
static NSString * authUsername;
static NSString * authPassword;

@interface MSOSDK ()
@property (strong, nonatomic, nullable, readwrite) AFHTTPSessionManager *operation;

@end

@implementation MSOSDK

+ (NSString *)_msoNetserverIpAddress {
    return netserverIpAddress;
}

+ (NSString *)_msoDeviceName {
    return deviceName;
}

+ (NSString *)_msoDeviceIpAddress {
    return deviceIPAddress;
}

+ (NSString *)_msoEventId {
    return eventId;
}

+ (NSString *)_msoPassword {
    return msoPassword;
}

+ (NSString *)_authUsername {
    return authUsername;
}

+ (NSString *)_authPassword {
    return authPassword;
}

+ (void)setMSONetserverIpAddress:(NSString *)msoNetserverIPAddress
                   msoDeviceName:(NSString *)msoDeviceName
              msoDeviceIpAddress:(NSString *)msoDeviceIpAddress
                      msoEventId:(NSString *)msoEventId
                     msoPassword:(NSString *)ftpPassword {

    [MSOSDK
     setMSONetserverIpAddress:msoNetserverIPAddress
     msoDeviceName:msoDeviceName
     msoDeviceIpAddress:msoDeviceIpAddress
     msoEventId:msoEventId
     msoPassword:ftpPassword
     authUsername:nil
     authPassword:nil];
}

+ (void)setMSONetserverIpAddress:(NSString *)msoNetserverIPAddress
                   msoDeviceName:(NSString *)msoDeviceName
              msoDeviceIpAddress:(NSString *)msoDeviceIpAddress
                      msoEventId:(NSString *)msoEventId
                     msoPassword:(NSString *)ftpPassword
                    authUsername:(NSString *)username
                    authPassword:(NSString *)password {

    netserverIpAddress = msoNetserverIPAddress;
    deviceName = msoDeviceName;
    deviceIPAddress = msoDeviceIpAddress;
    eventId = msoEventId;
    msoPassword = ftpPassword;
    authUsername = username;
    authPassword = password;
}

+ (instancetype)sharedSession {
    static MSOSDK *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {

        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _operation = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        [_operation setTaskDidReceiveAuthenticationChallengeBlock:
         ^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session,
                                               NSURLSessionTask * _Nonnull task,
                                               NSURLAuthenticationChallenge * _Nonnull challenge,
                                               NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
            
             NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
             
             id<NSURLAuthenticationChallengeSender> sender = [challenge sender];
             
             if ([challenge previousFailureCount] == 0) {
                 NSURLCredential *newCredential = [NSURLCredential
                                                   credentialWithUser:authUsername
                                                   password:authPassword
                                                   persistence:NSURLCredentialPersistenceNone];
                 [sender
                  useCredential:newCredential
                  forAuthenticationChallenge:challenge];
                 return NSURLSessionAuthChallengeUseCredential;
             } else {
                 [sender cancelAuthenticationChallenge:challenge];
                 return NSURLSessionAuthChallengeCancelAuthenticationChallenge;
             }
            
        }];
        
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        _operation.responseSerializer = responseSerializer;
        
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [policy setValidatesDomainName:NO];
        [policy setAllowInvalidCertificates:YES];
        _operation.securityPolicy = policy;
        
    }
    return self;
}

- (NSURL *)serviceUrl {
    NSString *ip = [MSOSDK _msoNetserverIpAddress];
    NSAssert(ip, @"There must be a netserver IP Address set. Use + (void)setMSONetserverIPAddress:(NSString *)msoNetserverIPAddress");
    NSString *urlString = [NSString stringWithFormat:@"http://%@:8178/LogicielNetServer", ip];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

+ (NSString *)sanatizeData:(NSData *)responseObject {
    NSString *unsanitizedData = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
    NSString *escapedData = [unsanitizedData mso_stringBetweenString:_msoNetserverBeginEscapedCommand andString:_msoNetserverEndEscapedCommand];
    unsanitizedData = nil;
    responseObject = nil;
    NSString *command = [escapedData mso_unescape];
    escapedData = nil;
    return command;
}

+ (NSString *)sanatizeImageData:(NSData *)responseObject {
    NSString *unsanitizedData = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
    NSString *escapedData = [unsanitizedData mso_stringBetweenString:@"<DoWorkResult>" andString:@"</DoWorkResult>"];
    unsanitizedData = nil;
    return escapedData;
}

+ (NSString *)stringFromDate:(NSDate *)date {
    NSString *string = [[NSDateFormatter mso_longDateFormatter] stringFromDate:date];
    return string;
}

+ (NSDate *)dateFromString:(NSString *)date {    
    NSDate *string = [[NSDateFormatter mso_mediumDateFormatter] dateFromString:date];
    return string;
}

+ (BOOL)validate:(NSString *)data command:(NSString *)command status:(NSString *)status error:(NSError *__autoreleasing *)error {
    
    BOOL validity = NO;

    if (!data) {
        return validity;
    }
    
    validity = [MSOSDK validateCredentials:data command:command status:status error:error];
    if (!validity) {
        return validity;
    }

    validity = [MSOSDK validateResults:data command:command status:status error:error];
    if (!validity) {
        return validity;
    }

    return validity;
}

+ (BOOL)validateCredentials:(NSString *)data command:(NSString *)command status:(NSString *)status error:(NSError **)error {
   
    if ([data hasPrefix:@"Invalid Login:"] ||
        [data hasSuffix:@"Invalid ID/Password or Access Level."]) {
        
        *error = [NSError mso_internet_login_credientials_invalid];
        return NO;
    }
    
    if ([data hasPrefix:@"Invalid Event:"]) {
        *error = [NSError mso_netserver_event_invalid];
        return NO;
    }
    
    if ([data hasPrefix:@"Invalid Event."]) {
        *error = [NSError mso_netserver_event_invalid_with_eventName:command eventId:status];
        return NO;
    }
    
    return YES;
}

+ (BOOL)validateResults:(NSString *)data command:(NSString *)command status:(NSString *)status error:(NSError **)error {
    if ([data hasPrefix:@"Unknown Format:"]) {
        
        if ([command isEqualToString:@"_O002"]) {
            if ([data hasSuffix:@"*****Error Message: Value was either too large or too small for a Decimal."]) {
                *error = [NSError mso_netserver_sales_order_total_error];
                return NO;
            }
        }
        
        if ([data containsString:@"OutOfMemoryException"]) {
            *error = [NSError mso_netserver_out_of_memory_exception_error];
        } else {
            *error = [NSError mso_netserver_unknown_format_error:data];
        }
        
        return NO;
    }
    
    if ([data isEqualToString:@"Item Not Found."]) {
        *error = [NSError mso_netserver_product_fetch_empty_result];
        return NO;
    }
    
    if ([data isEqualToString:@"Photo Not Found"]) {
        *error = [NSError mso_netserver_image_not_found_error];
        return NO;
    }
    
    if ([data hasPrefix:@"Exceeded Limit"]) {
        *error = [NSError mso_netserver_customer_query_exceeded_limit_error];
        return NO;
    }
    
    if ([data isEqualToString:@"No Customer Found."]) {
        *error = [NSError mso_netserver_customer_query_not_found_error];
        return NO;
    }

    if ([data hasSuffix:@"No Customer Updated."]) {
        *error = [NSError mso_netserver_customer_query_not_found_error];
        return NO;
    }
    
    if ([command isEqualToString:@"_E004"]) {
        if ([data isEqualToString:@"No Sales Order Found."]) {
            *error = [NSError mso_netserver_order_retrieval_no_orders];
            return NO;
        }
    }
    
    if ([command isEqualToString:@"_O001"]) {
        if ([data isEqualToString:@"No Sales Order Found."]) {
            *error = [NSError mso_netserver_order_retrieval_order_not_found];
            return NO;
        }
    }
    
    if ([command isEqualToString:@"_P011"]) {
        if ([data isEqualToString:@"Item Not Found"]) {
            *error = [NSError mso_netserver_image_upload_error];
            return NO;
        }
    }
    
    if ([command isEqualToString:@"_C006"]) {
        if ([data hasSuffix:@"No Auto-Mapping Created."]) {
            *error = [NSError mso_netserver_auto_mapping_not_created_error];
            return NO;
        }
    }
    
    if ([command isEqualToString:@"_C007"]) {
        if ([data hasSuffix:@"Index was outside the bounds of the array."]) {
            *error = [NSError mso_netserver_auto_mapping_not_created_error];
            return NO;            
        }
    }
    
    if ([status isEqualToString:@"NO"]) {
        *error = [NSError mso_netserver_method_request_error:command];
        return NO;
    }
    
    return YES;
}

+ (NSURLRequest *)urlRequestImage:(NSURL *)url
                          timeout:(NSTimeInterval)timeout
                            error:(NSError **)error {
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setTimeoutInterval:timeout];
    
    NSMutableURLRequest *request =
    [requestSerializer
     requestWithMethod:@"GET"
     URLString:[url absoluteString]
     parameters:nil
     error:error];
    
    [request printRequestWithBenchmark:[NSDate date] headerMessage:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    return request;
}

+ (NSURLRequest *)urlRequestWithParameters:(NSArray <MSOSoapParameter *> *)parameters
                                      type:(NSString *)type
                                       url:(NSURL *)url
                                 netserver:(BOOL)netserver
                                   timeout:(NSTimeInterval)timeout {

    
    
    NSMutableArray *parameterArray = [NSMutableArray arrayWithCapacity:[parameters count] + 1];

    NSString *namespace;

    if (netserver) {

        NSString *_deviceName = [MSOSDK _msoDeviceName];
        NSString *_deviceIPAddress = [MSOSDK _msoDeviceIpAddress];
        NSString *_eventId = [MSOSDK _msoEventId];
        
        NSString *format = @" must be set. Use + (void)setMSONetserverIPAddress:(NSString *)msoNetserverIPAddress \
        msoDeviceName:(NSString *)msoDeviceName \
        msoDeviceIpAddress:(NSString *)msoDeviceIpAddress \
        msoEventId:(NSString *)msoEventId";
        
        NSAssert(_deviceName, [NSStringFromSelector(@selector(_msoDeviceName)) stringByAppendingString:format]);
        NSAssert(_deviceIPAddress, [NSStringFromSelector(@selector(_msoDeviceIpAddress)) stringByAppendingString:format]);
        NSAssert(_eventId, [NSStringFromSelector(@selector(_msoEventId)) stringByAppendingString:format]);
        
        NSString *client = [NSString stringWithFormat:@"%@ [%@]{SQL05^%@}#iPad#",
                            _deviceName,
                            _deviceIPAddress,
                            _eventId];
        
        client = [client mso_build_command:nil];
        
        MSOSoapParameter *parameterClient = [MSOSoapParameter parameterWithObject:client forKey:@"client"];
        [parameterArray addObject:parameterClient.xml];
        
        namespace = mso_endpoint_logicielIncUrl;
    } else {
        namespace = mso_endpoint_logicielUrl;
    }
    
    NSURL *actionURL = [NSURL URLWithString:namespace];
    actionURL = [actionURL URLByAppendingPathComponent:type];
    
    for (MSOSoapParameter *soapParameter in parameters) {
        [parameterArray addObject:soapParameter.xml];
    }
    
    NSString *parametersString = [parameterArray componentsJoinedByString:@"\n"];
    
    NSString *soapMessage = [MSOSDK createEnvelope:[type lastPathComponent] forNamespace:namespace forParameters:parametersString];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setTimeoutInterval:timeout];
    [requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
    [requestSerializer setValue:[actionURL absoluteString] forHTTPHeaderField:@"SOAPAction"];
    
    NSError *error = nil;
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"POST" URLString:[url absoluteString] parameters:nil error:&error];
       
    if (!request) {
        NSLog(@"%@", [error description]);
        return nil;
    }
    
    [request setHTTPBody:[soapMessage dataUsingEncoding:stringEncoding]];
  
    [request printRequestWithBenchmark:[NSDate date] headerMessage:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    return request;
}

+ (NSString *)createEnvelope:(NSString *)method forNamespace:(NSString *)namespace forParameters:(NSString *)parameters {
    NSMutableString *hcSoap = [NSMutableString string];
    [hcSoap appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"];
    [hcSoap appendString:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"];
    [hcSoap appendString:@"<soap:Body>\n"];
    [hcSoap appendFormat:@"<%@ xmlns=\"%@\">\n",  method, namespace];
    [hcSoap appendFormat:@"%@\n", [parameters stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    [hcSoap appendFormat:@"</%@>\n", method];
    [hcSoap appendString:@"</soap:Body>\n"];
    [hcSoap appendString:@"</soap:Envelope>\n"];
    return hcSoap;

}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                                     progress:(MSOProgressBlock)progress
                                      success:(void (^)(NSURLResponse *, id, NSError *))success
                                      failure:(void (^)(NSURLResponse *, NSError *))failure {
    
    NSURLSessionDataTask *task =
    [self.operation
     dataTaskWithRequest:request
     uploadProgress:nil
     downloadProgress:progress
     completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             success(response, responseObject, nil);
         }
         
     }];;
    return task;
}

@end


@interface MSOSoapParameter ()
@property (strong, nonatomic, nullable, readwrite) id object;
@property (strong, nonatomic, nullable, readwrite) NSString *key;
@end

@implementation MSOSoapParameter

+ (instancetype)parameterWithObject:(id)object forKey:(NSString *)key {
    return [[MSOSoapParameter alloc] initWithObject:object forKey:key];
}

- (instancetype)initWithObject:(id)object forKey:(NSString *)key {
    
    self = [super init];
    
    if (self) {
        _object = object;
        _key = key;
    }
    
    return self;
}

- (NSString *)xml {
    
    if (!self.object) {
        
        return [NSString stringWithFormat:@"<%@ xsi:nil=\"true\"/>", self.key];
        
    } else {
        
        return [MSOSoapParameter serialize:self.object withKey:self.key];
        
    }
}

+ (NSString *)serialize:(id)object withKey:(NSString *)key {
    
    return [NSString stringWithFormat:@"<%@>%@</%@>", key, [MSOSoapParameter serialize:object], key];
    
}

+ (NSString *)serialize:(id)object {
    
    if ([object isKindOfClass:[NSDate class]]) {
        return [[NSDateFormatter mso_longDateFormatter] stringFromDate:object];
    } else if ([object isKindOfClass:[NSData class]]) {
        return [object base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn | NSDataBase64EncodingEndLineWithLineFeed];
    } else if ([object isKindOfClass:[UIImage class]]) {
        NSData *data = UIImagePNGRepresentation(object);
        NSString *dataFormatted = [data base64EncodedStringWithOptions:kNilOptions];
        return dataFormatted;
    } else {
        return object;
    }
    
}

@end

