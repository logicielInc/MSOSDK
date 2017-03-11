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

+ (void)setMSONetserverIpAddress:(NSString *)msoNetserverIPAddress
                   msoDeviceName:(NSString *)msoDeviceName
              msoDeviceIpAddress:(NSString *)msoDeviceIpAddress
                      msoEventId:(NSString *)msoEventId {
    
    netserverIpAddress = msoNetserverIPAddress;
    deviceName = msoDeviceName;
    deviceIPAddress = msoDeviceIpAddress;
    eventId = msoEventId;
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
    NSAssert(netserverIpAddress, @"There must be a netserver IP Address set. Use + (void)setMSONetserverIPAddress:(NSString *)msoNetserverIPAddress");
    NSString *urlString = [NSString stringWithFormat:@"http://%@:8178/LogicielNetServer", netserverIpAddress];
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

#pragma mark Helpers
+ (NSURL *)logicielCustomerURL {
    static NSURL *url = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        url = [NSURL URLWithString:mso_endpoint_logicielIncUrl];
        url = [url URLByAppendingPathComponent:[mso_endpoint_logicielUpdateEndpoint stringByAppendingPathComponent:mso_endpoint_logicielCustomerASMX]];
    });
    return url;
}

+ (NSURL *)logicielFTPServiceURL {
    static NSURL *url = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        url = [NSURL URLWithString:mso_endpoint_logicielIncUrl];
        url = [url URLByAppendingPathComponent:[mso_endpoint_logicielFTPWSEndpoint stringByAppendingPathComponent:mso_endpoint_logicielFTPServiceASMX]];
    });
    return url;
}

+ (NSDateFormatter *)longDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        //    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        //    [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    });
    return dateFormatter;
}

+ (NSDateFormatter *)mediumDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        //    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        //    [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    return dateFormatter;
}

+ (NSString *)stringFromDate:(NSDate *)date {
    NSString *string = [[MSOSDK longDateFormatter] stringFromDate:date];
    return string;
}

+ (NSDate *)dateFromString:(NSString *)date {    
    NSDate *string = [[MSOSDK mediumDateFormatter] dateFromString:date];
    return string;
}

+ (BOOL)validate:(NSString *)data command:(NSString *)command status:(NSString *)status error:(NSError *__autoreleasing *)error {
    
    BOOL validity = NO;

    if (!data) {
        return validity;
    }
    
    validity = [MSOSDK validateResults:data command:command status:status error:error];
    if (!validity) {
        return validity;
    }
    
    validity = [MSOSDK validateCredentials:data command:command status:status error:error];
    if (!validity) {
        return validity;
    }

    return validity;
}

+ (BOOL)validateCredentials:(NSString *)data command:(NSString *)command status:(NSString *)status error:(NSError **)error {
    if ([data hasPrefix:@"Invalid Login:"]) {
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
    
    if ([status isEqualToString:@"NO"]) {
        *error = [NSError mso_netserver_method_request_error:command];
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
    
    if ([status isEqualToString:@"NO"]) {
        *error = [NSError mso_netserver_method_request_error:command];
        return NO;
    }
    
    return YES;
}

+ (NSString *)kMSOProductSearchType:(kMSOProductSearchType)type {
    if (type < 0 || type > 5) return @"1";
    return [NSString stringWithFormat:@"%li", (long)type];
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

+ (NSURLRequest *)urlRequestWithParameters:(NSDictionary *)parameters
                                      keys:(NSArray *)keys
                                      type:(NSString *)type
                                       url:(NSURL *)url
                                 netserver:(BOOL)netserver
                                   timeout:(NSTimeInterval)timeout
                                     error:(NSError **)error {
    
    NSString *format = @" must be set. Use + (void)setMSONetserverIPAddress:(NSString *)msoNetserverIPAddress\
    msoDeviceName:(NSString *)msoDeviceName\
    msoDeviceIpAddress:(NSString *)msoDeviceIpAddress\
    msoEventId:(NSString *)msoEventId";
    
    NSAssert(deviceName, [NSStringFromSelector(@selector(_msoDeviceName)) stringByAppendingString:format]);
    NSAssert(deviceIPAddress, [NSStringFromSelector(@selector(_msoDeviceIpAddress)) stringByAppendingString:format]);
    NSAssert(eventId, [NSStringFromSelector(@selector(_msoEventId)) stringByAppendingString:format]);

    NSString *client = [NSString stringWithFormat:@"%@ [%@]{SQL05^%@}#iPad#", deviceName, deviceIPAddress, eventId];
    client = [client mso_build_command:nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:client forKey:@"client"];
    [dict addEntriesFromDictionary:parameters];
    
    NSDictionary *d = netserver ? dict : parameters;
    NSArray *sorted = keys;
    if (netserver) {
        sorted = [NSArray arrayWithObject:@"client"];
        sorted = [sorted arrayByAddingObjectsFromArray:keys];
    }

    NSString *action = netserver ? mso_endpoint_logicielIncUrl : mso_endpoint_logicielUrl;
    NSURL *actionURL = [NSURL URLWithString:action];
    actionURL = [actionURL URLByAppendingPathComponent:type];
    
    NSString *soapMessage = [MSOSDK buildRequestFromDictionary:d sortedKeys:sorted type:type netserverRequest:netserver];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setTimeoutInterval:timeout];
    [requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]] forHTTPHeaderField:@"Content-Length"];
    [requestSerializer setValue:[actionURL absoluteString] forHTTPHeaderField:@"SOAPAction"];
    
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"POST" URLString:[url absoluteString] parameters:nil error:error];
    
    [request setHTTPBody:[soapMessage dataUsingEncoding:stringEncoding]];
  
    [request printRequestWithBenchmark:[NSDate date] headerMessage:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    return request;
}

- (void)errorHandler:(NSError *)error response:(NSURLResponse *)response failure:(MSOFailureBlock)failure {
    NSLog(@"Error: %@", [error description]);
    if (failure) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(response, error);
        });
    }
}

+ (NSString *)buildRequestFromDictionary:(NSDictionary *)dict sortedKeys:(NSArray *)sortedKeys type:(NSString *)type netserverRequest:(BOOL)netserverRequest {
    
    NSMutableString *hcSoap = [NSMutableString string];
    [hcSoap appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"];
    [hcSoap appendFormat:@"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"%@\">\n", netserverRequest ? @"http://logicielinc.com" : @"http://logiciel.com/"];
    [hcSoap appendString:@"<soap:Body>\n"];
    [hcSoap appendFormat:@"<%@>\n", [[type componentsSeparatedByString:@"/"] lastObject]];
    
    for (NSString *key in sortedKeys) {
        [hcSoap appendFormat:@"<%@>%@</%@>\n", key, [dict objectForKey:key], key];
    }
        
    [hcSoap appendFormat:@"</%@>\n", [[type componentsSeparatedByString:@"/"] lastObject]];
    [hcSoap appendString:@"</soap:Body>\n"];
    [hcSoap appendString:@"</soap:Envelope>\n"];
    
    return hcSoap;
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request progress:(MSOProgressBlock)progress completion:(void (^)(NSURLResponse *, id, NSError *))completion {
    return [self.operation dataTaskWithRequest:request uploadProgress:nil downloadProgress:progress completionHandler:completion];
}

@end

