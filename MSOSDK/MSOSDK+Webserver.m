
//
//  MSOSDK+Webserver.m
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDK+Webserver.h"

@implementation MSOSDK (Webserver)

#pragma mark - Web Service Credentials
#pragma mark Login
- (NSURLSessionDataTask *)_msoWebserverValidity:(NSString *)username
                                      accesskey:(NSString *)accesskey
                                           udid:(NSString *)udid
                                            pin:(NSString *)pin
                                    companyname:(NSString *)companyname
                                     appversion:(NSString *)appversion
                                           user:(BOOL)user
                                        success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverCredentials * _Nonnull responseObject))success
                                        failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterAccessKey   = [MSOSoapParameter parameterWithObject:accesskey                forKey:@"accessKey"];
    MSOSoapParameter *parameterUDID        = [MSOSoapParameter parameterWithObject:udid                     forKey:@"deviceID"];
    MSOSoapParameter *parameterCompanyName = [MSOSoapParameter parameterWithObject:companyname              forKey:@"companyName"];
    MSOSoapParameter *parameterPin         = [MSOSoapParameter parameterWithObject:pin                      forKey:@"pin"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:username                 forKey:@"userAccount"];
    MSOSoapParameter *parameterPassword    = [MSOSoapParameter parameterWithObject:@""                      forKey:@"userPassword"];
    MSOSoapParameter *parameterAppVersion  = [MSOSoapParameter parameterWithObject:appversion               forKey:@"appVersion"];
    MSOSoapParameter *parameterIType       = [MSOSoapParameter parameterWithObject:@"0"                     forKey:@"iType"];
    MSOSoapParameter *parameterMSOPassword = [MSOSoapParameter parameterWithObject:[MSOSDK _msoPassword]    forKey:@"password"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterAccessKey,
                                parameterUDID,
                                parameterCompanyName,
                                parameterPin,
                                parameterUsername,
                                parameterPassword,
                                parameterAppVersion,
                                parameterIType,
                                parameterMSOPassword]
     type:user ? mso_soap_function_iCheckMobileUser : mso_soap_function_iCheckMobileDevice
     url:[NSURL logicielCustomerURL]
     netserver:NO
     timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverCredentials *mso_response =
         [MSOSDKResponseWebserverCredentials
          msosdk_commandWithResponse:responseObject
          command:user ? mso_soap_function_iCheckMobileUser : mso_soap_function_iCheckMobileDevice
          error:&error];

         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
    
}


#pragma mark Forgot Password
- (NSURLSessionDataTask *)_msoWebserverForgotPassword:(NSString *)username
                                             password:(NSString *)password
                                            accesskey:(NSString *)accesskey
                                                 udid:(NSString *)udid
                                                  pin:(NSString *)pin
                                           appversion:(NSString *)appversion
                                          companyname:(NSString *)companyname
                                              success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverCredentials * _Nonnull responseObject))success
                                              failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterAccessKey   = [MSOSoapParameter parameterWithObject:accesskey                forKey:@"accessKey"];
    MSOSoapParameter *parameterUDID        = [MSOSoapParameter parameterWithObject:udid                     forKey:@"deviceID"];
    MSOSoapParameter *parameterCompanyName = [MSOSoapParameter parameterWithObject:companyname              forKey:@"companyName"];
    MSOSoapParameter *parameterPin         = [MSOSoapParameter parameterWithObject:pin                      forKey:@"pin"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:username                 forKey:@"userAccount"];
    MSOSoapParameter *parameterPassword    = [MSOSoapParameter parameterWithObject:password                 forKey:@"userPassword"];
    MSOSoapParameter *parameterAppVersion  = [MSOSoapParameter parameterWithObject:appversion               forKey:@"appVersion"];
    MSOSoapParameter *parameterIType       = [MSOSoapParameter parameterWithObject:@"1"                     forKey:@"iType"];
    MSOSoapParameter *parameterMSOPassword = [MSOSoapParameter parameterWithObject:[MSOSDK _msoPassword]    forKey:@"password"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterAccessKey,
                                parameterUDID,
                                parameterCompanyName,
                                parameterPin,
                                parameterUsername,
                                parameterPassword,
                                parameterAppVersion,
                                parameterIType,
                                parameterMSOPassword]
     type:mso_soap_function_iCheckMobileDevice
     url:[NSURL logicielCustomerURL]
     netserver:NO
     timeout:kMSOTimeoutForgotPassword];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverCredentials *mso_response =
         [MSOSDKResponseWebserverCredentials
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_iCheckMobileDevice
          error:&error];

         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }

         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
          
     } failure:failure];
    
    return task;
}

#pragma mark Registration
- (NSURLSessionDataTask *)_msoWebserverRegisterRep:(NSString *)username
                                         accesskey:(NSString *)accesskey
                                             email:(NSString *)email
                                              udid:(NSString *)udid
                                        appversion:(NSString *)appversion
                                           success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverRegister * _Nonnull responseObject))success
                                           failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterAccessKey   = [MSOSoapParameter parameterWithObject:accesskey                forKey:@"accessKey"];
    MSOSoapParameter *parameterUDID        = [MSOSoapParameter parameterWithObject:udid                     forKey:@"deviceID"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:username                 forKey:@"userName"];
    MSOSoapParameter *parameterEmail       = [MSOSoapParameter parameterWithObject:email                    forKey:@"userEmail"];
    MSOSoapParameter *parameterAppVersion  = [MSOSoapParameter parameterWithObject:appversion               forKey:@"appVersion"];
    MSOSoapParameter *parameterMSOPassword = [MSOSoapParameter parameterWithObject:[MSOSDK _msoPassword]    forKey:@"password"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterAccessKey,
                                parameterUDID,
                                parameterUsername,
                                parameterEmail,
                                parameterAppVersion,
                                parameterMSOPassword]
     type:mso_soap_function_iRegisterShortKey
     url:[NSURL logicielCustomerURL]
     netserver:NO
     timeout:kMSOTimeoutRegistrationKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverRegister *mso_response =
         [MSOSDKResponseWebserverRegister
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_iRegisterShortKey
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if ([mso_response.pin isEqualToString:@"?"]) {
             
             NSURLSessionDataTask *task =
             
             [self
              _msoWebserverRegisterCode:mso_response.rep
              cds:mso_response.cds
              accesskey:mso_response.key
              code:mso_response.code
              type:mso_response.type
              company:mso_response.company
              email:email
              udid:udid
              appversion:appversion
              reregister:YES
              success:success
              failure:failure];
             
             [task resume];
             
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebserverRegisterCode:(NSString *)username
                                                cds:(NSString *)cds
                                          accesskey:(NSString *)accesskey
                                               code:(NSString *)code
                                               type:(NSString *)type
                                            company:(NSString *)company
                                              email:(NSString *)email
                                               udid:(NSString *)udid
                                         appversion:(NSString *)appversion
                                         reregister:(BOOL)reregister
                                            success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverRegister * _Nonnull responseObject))success
                                            failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterAccessKey   = [MSOSoapParameter parameterWithObject:accesskey                forKey:@"accessKey"];
    MSOSoapParameter *parameterUDID        = [MSOSoapParameter parameterWithObject:udid                     forKey:@"deviceID"];
    MSOSoapParameter *parameterCDs         = [MSOSoapParameter parameterWithObject:cds                      forKey:@"full_CDS"];
    MSOSoapParameter *parameterAppVersion  = [MSOSoapParameter parameterWithObject:appversion               forKey:@"appVersion"];
    MSOSoapParameter *parameterMSOPassword = [MSOSoapParameter parameterWithObject:[MSOSDK _msoPassword]    forKey:@"password"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterAccessKey,
                                parameterUDID,
                                parameterCDs,
                                parameterAppVersion,
                                parameterMSOPassword]
     type:mso_soap_function_iRegisterCode
     url:[NSURL logicielCustomerURL]
     netserver:NO
     timeout:kMSOTimeoutRegistrationKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverRegisterCode *mso_code =
         [MSOSDKResponseWebserverRegisterCode
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_iRegisterCode
          error:&error];
         
         if (!mso_code) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *pin = mso_code.pin;
         
         if (pin) {
             
             MSOSDKResponseWebserverRegister *mso_response = [MSOSDKResponseWebserverRegister new];
             mso_response.command = mso_soap_function_iRegisterShortKey;
             mso_response.pin = pin;
             mso_response.key = accesskey;
             mso_response.rep = username;
             mso_response.company = company;
             mso_response.code = code;
             mso_response.type = type;
             
             if (success) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, mso_response);
                 });
             }
             return;
         }
         
         if (reregister) {
             
             NSURLSessionDataTask *task =
             [self
              _msoWebserverRegisterRep:username
              accesskey:accesskey
              email:email
              udid:udid
              appversion:appversion
              success:success
              failure:failure];
             
             [task resume];
             
             return;
         }
         
     } failure:failure];
    
    return task;
    
}

#pragma mark - Images

static MSOSuccessBlock gr_success_block;
static MSOProgressBlock gr_progress_block;
static MSOFailureBlock gr_failure_block;

- (void)_msoWebserverFetchAllPhotoReferences:(NSString *)pin
                                     success:(void (^)(NSURLResponse * _Nonnull response, NSArray <NSString *> * _Nonnull responseObject))success
                                    progress:(MSOProgressBlock)progress
                                     failure:(MSOFailureBlock)failure {
    
    NSString *hostname = @"ftp://ftp.logicielinc.com";
    NSString *username = @"manager";
    NSString *password = @"Log-8910";
    NSString *photosPath = [NSString stringWithFormat:@"/PUBLIC/Customer_Auto_FTP/%@/Photos/", pin];
    
    self.requestsManager =
    [[GRRequestsManager alloc]
     initWithHostname:hostname
     user:username
     password:password];

    self.requestsManager.delegate = self;
    id <GRRequestProtocol> request = [self.requestsManager addRequestForListDirectoryAtPath:photosPath];
    [request start];
    gr_success_block = [success copy];
    gr_progress_block = [progress copy];
    gr_failure_block = [failure copy];
}

- (NSURLSessionDataTask *)_msoWebserverFetchPhotoFileStatus:(NSString *)itemNo
                                                        pin:(NSString *)pin
                                                    success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverPhotoResponse * _Nonnull responseObject))success
                                                   progress:(MSOProgressBlock)progress
                                                    failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterItemNo  = [MSOSoapParameter parameterWithObject:itemNo forKey:@"sItemNo"];
    MSOSoapParameter *parameterPin     = [MSOSoapParameter parameterWithObject:pin    forKey:@"sPIN"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterItemNo,
                                parameterPin]
     type:mso_soap_function_checkPhotoFileStatus
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
     
         MSOSDKResponseWebserverPhotoResponse *mso_response =
         [MSOSDKResponseWebserverPhotoResponse
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_checkPhotoFileStatus
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *string = [NSString stringWithFormat:@"^%@(-[0-9]+)?\\.(jpg|jpeg|png)$", itemNo];
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES [cd] %@", string];
         NSMutableArray *filtered = [NSMutableArray arrayWithCapacity:[mso_response.responseData count]];
         for (MSOSDKResponseWebserverPhotoDetails *details in mso_response.responseData) {
             
             if (![predicate evaluateWithObject:details.filename]) {
                 continue;
             }
             
             [filtered addObject:details];
             
         }
         
         mso_response.responseData = [filtered copy];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoWebserverDownloadPhoto:(NSString *)filename
                                                 pin:(NSString *)pin
                                             success:(void (^)(NSURLResponse * _Nonnull response, UIImage * _Nonnull responseObject))success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure {
    
    NSURL *url = [NSURL URLWithString:kMSOLogicielHTTPURLKey];
    url = [url URLByAppendingPathComponent:pin];
    url = [url URLByAppendingPathComponent:@"Photos"];
    url = [url URLByAppendingPathComponent:filename];
    
    NSError *error = nil;
    NSURLRequest *request =
    [MSOSDK
     urlRequestImage:url
     timeout:kMSOTimeoutImageSyncKey
     error:&error];
    
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
        
         UIImage *image = [UIImage imageWithData:responseObject];
         
         if (!image) {
             error = [NSError mso_internet_image_download_error:response.URL.lastPathComponent];
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, image);
             });
         }

     }];
    
    return task;
}

#pragma mark - Event
- (void)_msoWebserverDownloadEventList:(NSString *)pin
                               success:(void (^)(NSURLResponse * _Nonnull response, NSArray <NSString *> * _Nonnull responseObject))success
                              progress:(MSOProgressBlock)progress
                               failure:(MSOFailureBlock)failure {
    
    
    NSString *hostname = @"ftp://ftp.logicielinc.com";
    NSString *username = @"manager";
    NSString *password = @"Log-8910";
    NSString *eventListPath = [NSString stringWithFormat:@"/PUBLIC/Customer_Auto_FTP/%@/Events/", pin];
    
    self.requestsManager = [[GRRequestsManager alloc] initWithHostname:hostname
                                                                  user:username
                                                              password:password];
    self.requestsManager.delegate = self;
    id <GRRequestProtocol> request = [self.requestsManager addRequestForListDirectoryAtPath:eventListPath];
    [request setUuid:[NSString stringWithFormat:@"eventRequest"]];
    [request start];
    gr_success_block = [success copy];
    gr_progress_block = [progress copy];
    gr_failure_block = [failure copy];
    
    
    /*
    MSOSoapParameter *parameterPin         = [MSOSoapParameter parameterWithObject:pin                      forKey:@"PIN"];
    MSOSoapParameter *parameterMSOPassword = [MSOSoapParameter parameterWithObject:[MSOSDK _msoPassword]    forKey:@"password"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterPin,
                                parameterMSOPassword]
     type:mso_soap_function_getEventList
     url:[NSURL logicielCustomerURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *parent = [element firstObject];
         SMXMLElement *eventObjects = [parent descendantWithPath:@"GetEventListResponse.GetEventListResult"];
         NSArray <SMXMLElement *> *events = [eventObjects children];
         
         NSMutableArray *eventsFormatted = [NSMutableArray array];
         for (SMXMLElement *event in events) {
             [eventsFormatted addObject:event.value];
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, eventsFormatted);
             });
         }
         
     } failure:failure];
    
    [task resume];
    
    return task;
    */
}

#pragma mark Check For Files
- (NSURLSessionDataTask *)_msoWebserverCheckForNumberOfFilesToDownload:(NSString *)userId
                                                                   pin:(NSString *)pin
                                                                  date:(NSDate *)date
                                                               success:(void (^)(NSURLResponse * _Nonnull response, NSNumber * _Nonnull responseObject))success
                                                              progress:(MSOProgressBlock)progress
                                                               failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterPIN         = [MSOSoapParameter parameterWithObject:pin    forKey:@"sPIN"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:userId forKey:@"sUserID"];
    MSOSoapParameter *parameterCheckType   = [MSOSoapParameter parameterWithObject:@"1"   forKey:@"iCheckType"];
    MSOSoapParameter *parameterViewDate    = [MSOSoapParameter parameterWithObject:date   forKey:@"sLastViewDate"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterPIN,
                                parameterUsername,
                                parameterCheckType,
                                parameterViewDate]
     type:mso_soap_function_iCheckMobileMessage
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         responseObject = [responseObject mso_stringBetweenString:@"<_iCheckMobileMessageResult>" andString:@"</_iCheckMobileMessageResult>"];
         if (!responseObject || [responseObject length] == 0) {
             responseObject = @"0";
         }
         
         NSNumber *numberOfFile = @([responseObject integerValue]);
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, numberOfFile);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebserverCheckForFilesToDownload:(NSString *)userId
                                                           pin:(NSString *)pin
                                                          date:(NSDate *)date
                                                       success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverFilesToDownload * _Nonnull responseObject))success
                                                      progress:(MSOProgressBlock)progress
                                                       failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterPIN         = [MSOSoapParameter parameterWithObject:pin    forKey:@"sPIN"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:userId forKey:@"sUserID"];
    MSOSoapParameter *parameterCheckType   = [MSOSoapParameter parameterWithObject:@"1"   forKey:@"iCheckType"];
    MSOSoapParameter *parameterViewDate    = [MSOSoapParameter parameterWithObject:date   forKey:@"sLastViewDate"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterPIN,
                                parameterUsername,
                                parameterCheckType,
                                parameterViewDate]
     type:mso_soap_function_iCheckMobileFileForDownloading
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverFilesToDownload *mso_response =
         [MSOSDKResponseWebserverFilesToDownload
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_iCheckMobileFileForDownloading
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }

         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebserverCheckForFiles:(NSString *)userId
                                                 pin:(NSString *)pin
                                                date:(NSDate *)date
                                             success:(void (^)(NSURLResponse * _Nonnull response, NSString * _Nonnull responseObject))success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure {
    
    
    MSOSoapParameter *parameterPIN         = [MSOSoapParameter parameterWithObject:pin    forKey:@"sPIN"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:userId forKey:@"sUserID"];
    MSOSoapParameter *parameterCheckType   = [MSOSoapParameter parameterWithObject:@"1"   forKey:@"iCheckType"];
    MSOSoapParameter *parameterViewDate    = [MSOSoapParameter parameterWithObject:date   forKey:@"sLastViewDate"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterPIN,
                                parameterUsername,
                                parameterCheckType,
                                parameterViewDate]
     type:mso_soap_function_iCheckPDAMessage
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, responseObject);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebserverUpdateDownloadInfo:(NSString *)username
                                              companyname:(NSString *)companyname
                                                     udid:(NSString *)udid
                                                      pin:(NSString *)pin
                                                 fileName:(NSString *)fileName
                                             downloadDate:(NSDate *)downloadDate
                                                 filesize:(unsigned long long)filesize
                                                  success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverRequestData * _Nonnull responseObject))success
                                                 progress:(MSOProgressBlock)progress
                                                  failure:(MSOFailureBlock)failure {
    
    NSMutableArray *allInfo = [NSMutableArray array];
    [allInfo addObject:@""];
    [allInfo addObject:pin];
    [allInfo addObject:@"PDA"];
    [allInfo addObject:@"100"];
    [allInfo addObject:[fileName lastPathComponent]];
    [allInfo addObject:@""];
    [allInfo addObject:[downloadDate mso_stringFromDate]];
    [allInfo addObject:companyname];
    [allInfo addObject:@""];
    [allInfo addObject:username];
    [allInfo addObject:@"Rep"];
    [allInfo addObject:@""];
    [allInfo addObject:udid];
    [allInfo addObject:@""];
    [allInfo addObject:[NSString stringWithFormat:@"%llu", filesize]];
    [allInfo addObject:@"00:00:01"];
    [allInfo addObject:@""];
    [allInfo addObject:@""];
    
    NSMutableString *command = [NSMutableString string];
    for (NSString *str in allInfo) {
        [command appendFormat:@"<string>%@</string>", str];
    }
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:command forKey:@"allInfo"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_updateDownloadInfo
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverRequestData *mso_response =
         [MSOSDKResponseWebserverRequestData
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_updateDownloadInfo
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoWebserverCheckPDAHistoryForDownloading:(NSString *)username
                                                                 pin:(NSString *)pin
                                                             success:(void (^)(NSURLResponse * _Nonnull response, NSString * _Nonnull responseObject))success
                                                            progress:(MSOProgressBlock)progress
                                                             failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterPin         = [MSOSoapParameter parameterWithObject:pin        forKey:@"sPIN"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:username   forKey:@"sUserID"];
    MSOSoapParameter *parameterCheckType   = [MSOSoapParameter parameterWithObject:@"0"       forKey:@"iCheckType"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterPin,
                                parameterUsername,
                                parameterCheckType]
     type:mso_soap_function_iCheckPDAHistoryForDownloading
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, responseObject);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

#pragma mark - FTP Interaction
#pragma mark Upload
- (NSURLSessionDataTask *)_msoWebserverUploadToFTP:(NSDictionary <NSString *, NSData *> *)data
                                               pin:(NSString *)pin
                                           newfile:(BOOL)newfile
                                           success:(void (^)(NSURLResponse * _Nonnull response, BOOL responseObject))success
                                          progress:(MSOProgressBlock)progress
                                           failure:(MSOFailureBlock)failure {
    
    
    NSMutableDictionary *dDict = [data mutableCopy];
    NSString *filename = [[dDict allKeys] lastObject];
    
    NSURLSessionDataTask *task =
    [self
     msoUploadToFTPHandler:filename
     data:[dDict objectForKey:filename]
     pin:pin
     newfile:newfile
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverRequestData * _Nonnull responseObject) {
         
         [dDict removeObjectForKey:filename];
         
         if ([[dDict allKeys] count] == 0) {
             if (success) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, YES);
                 });
             }
             return;
         }
         
         NSURLSessionDataTask *innerTask =
         [self
          _msoWebserverUploadToFTP:dDict
          pin:pin
          newfile:newfile
          success:success
          progress:progress
          failure:failure];
         
         [innerTask resume];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         [NSError errorHandler:error response:response failure:failure];
         
     }];
    
    return task;
}

- (NSURLSessionDataTask *)msoUploadToFTPHandler:(NSString *)filename
                                           data:(NSData *)data
                                            pin:(NSString *)pin
                                        newfile:(BOOL)newfile
                                        success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverRequestData * _Nonnull responseObject))success
                                       progress:(MSOProgressBlock)progress
                                        failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterPin         = [MSOSoapParameter parameterWithObject:pin                            forKey:@"sPIN"];
    MSOSoapParameter *parameterFilename    = [MSOSoapParameter parameterWithObject:[filename lastPathComponent]   forKey:@"sFileName"];
    MSOSoapParameter *parameterBytes       = [MSOSoapParameter parameterWithObject:data                           forKey:@"bytesBuff"];
    MSOSoapParameter *parameterLength      = [MSOSoapParameter parameterWithObject:@((int)[data length])          forKey:@"contentLenth"];
    MSOSoapParameter *parameterNewFile     = [MSOSoapParameter parameterWithObject:@(newfile)                     forKey:@"newFile"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterPin,
                                parameterFilename,
                                parameterBytes,
                                parameterLength,
                                parameterNewFile]
     type:mso_soap_function_uploadFile
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutSalesOrderKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverRequestData *mso_response =
         [MSOSDKResponseWebserverRequestData
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_uploadFile
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebserverUploadToFTPUpdate:(NSString *)pin
                                                username:(NSString *)username
                                             companyname:(NSString *)companyname
                                                filename:(NSString *)filename
                                                filesize:(unsigned long long)filesize
                                                    udid:(NSString *)udid
                                              updateDate:(NSDate *)updateDate
                                                 success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverRequestData * _Nonnull responseObject))success
                                                progress:(MSOProgressBlock)progress
                                                 failure:(MSOFailureBlock)failure {
    
    NSMutableArray *allInfo = [NSMutableArray arrayWithCapacity:23];
    [allInfo addObject:@""];
    [allInfo addObject:pin];
    [allInfo addObject:@"PDA"];
    [allInfo addObject:@"1"];
    [allInfo addObject:@"Rep-PDA"];
    [allInfo addObject:[filename lastPathComponent]];
    [allInfo addObject:@""];
    [allInfo addObject:[updateDate mso_stringFromDate]];
    [allInfo addObject:companyname];
    [allInfo addObject:@""];
    [allInfo addObject:username];
    [allInfo addObject:@"Rep"];
    [allInfo addObject:@""];
    [allInfo addObject:udid];
    [allInfo addObject:@""];
    [allInfo addObject:@"0"];
    [allInfo addObject:@"Office"];
    [allInfo addObject:@""];
    [allInfo addObject:[NSString stringWithFormat:@"%llu", filesize]];
    [allInfo addObject:@"00:00:01"];
    [allInfo addObject:@""];
    [allInfo addObject:@""];
    [allInfo addObject:@"1"];
    
    NSMutableString *info = [NSMutableString string];
    for (NSString *str in allInfo) {
        [info appendFormat:@"<string>%@</string>", str];
    }
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:info forKey:@"allInfo"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_updateUploadInfo
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         
         MSOSDKResponseWebserverRequestData *mso_response =
         [MSOSDKResponseWebserverRequestData
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_updateUploadInfo
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoWebserverSendDataRequest:(NSString *)username
                                                   pin:(NSString *)pin
                                                  udid:(NSString *)udid
                                           companyname:(NSString *)companyname
                                              criteria:(NSString *)criteria
                                               success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverRequestData * _Nonnull responseObject))success
                                              progress:(MSOProgressBlock)progress
                                               failure:(MSOFailureBlock)failure {
    
    //if select tradeshow event we send "99" instead of criteria combination.
    NSMutableArray *allInfo = [NSMutableArray arrayWithCapacity:23];
    [allInfo addObject:@""];
    [allInfo addObject:pin];
    [allInfo addObject:@"PDA"];
    [allInfo addObject:@"2"];
    [allInfo addObject:@"Data Request"];
    [allInfo addObject:@".FrPDA"];
    [allInfo addObject:@""];
    [allInfo addObject:[[NSDate date] mso_stringFromDate]];
    [allInfo addObject:companyname];
    [allInfo addObject:@""];
    [allInfo addObject:username];
    [allInfo addObject:@"Rep"];
    [allInfo addObject:@""];
    [allInfo addObject:udid];
    [allInfo addObject:@""];
    [allInfo addObject:@"0"];
    [allInfo addObject:@"Office"];
    [allInfo addObject:@""];
    [allInfo addObject:criteria];
    [allInfo addObject:@""];
    [allInfo addObject:@""];
    [allInfo addObject:@"Request an updated PDA file from office by default criteria"];
    [allInfo addObject:@"1"];
    
    NSMutableString *command = [NSMutableString string];
    for (NSString *str in allInfo) {
        [command appendFormat:@"<string>%@</string>", str];
    }
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:command forKey:@"allInfo"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_updateUploadInfo
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutDataRequestKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverRequestData *mso_response =
         [MSOSDKResponseWebserverRequestData
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_updateUploadInfo
          error:&error];

         if (!mso_response) {
             [NSError errorHandler:[NSError mso_internet_request_data_error] response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
}

#pragma mark - Catalogs
- (NSURLSessionDataTask *)_msoWebserverFetchCatalog:(NSString *)catalogName
                                                pin:(NSString *)pin
                                            success:(void (^)(NSURLResponse * _Nonnull response, MSOSDKResponseWebserverCatalogResponse * _Nonnull responseObject))success
                                           progress:(MSOProgressBlock)progress
                                            failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterPin         = [MSOSoapParameter parameterWithObject:pin            forKey:@"sPIN"];
    MSOSoapParameter *parameterCatalogName = [MSOSoapParameter parameterWithObject:catalogName    forKey:@"sCatalogNo"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterPin,
                                parameterCatalogName]
     type:mso_soap_function_checkCatalogFileStatus
     url:[NSURL logicielFTPServiceURL]
     netserver:NO
     timeout:kMSOTimeoutCatalogKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverCatalogResponse *mso_response =
         [MSOSDKResponseWebserverCatalogResponse
          msosdk_commandWithResponse:responseObject
          command:mso_soap_function_checkCatalogFileStatus
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebserverFetchCustomersByCompanyName:(NSString *)companyName
                                                               pin:(NSString *)pin
                                                           success:(MSOSuccessBlock)success
                                                          progress:(MSOProgressBlock)progress
                                                           failure:(MSOFailureBlock)failure
{
    
    MSOSoapParameter *parameterCompanyName         = [MSOSoapParameter parameterWithObject:companyName              forKey:@"companyName"];
    MSOSoapParameter *parameterPin                 = [MSOSoapParameter parameterWithObject:pin                      forKey:@"pin"];
    MSOSoapParameter *parameterMSOPassword         = [MSOSoapParameter parameterWithObject:[MSOSDK _msoPassword]    forKey:@"password"];
    MSOSoapParameter *parameterLogicielApplication = [MSOSoapParameter parameterWithObject:@"1"                     forKey:@"logicielApplication"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameterCompanyName,
                                parameterPin,
                                parameterMSOPassword,
                                parameterLogicielApplication]
     type:mso_soap_function_getCustomersByCompany
     url:[NSURL logicielCustomerURL]
     netserver:NO
     timeout:kMSOTimeoutCustomerSearchKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForWebserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
         
         
     } failure:failure];
    
    return task;
    
}

#pragma mark <GRRequestsManagerProtocol>
- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompletePercent:(float)percent forRequest:(id<GRRequestProtocol>)request {
    
    if (gr_progress_block) {
        NSProgress *progress = [NSProgress progressWithTotalUnitCount:100];
        [progress setCompletedUnitCount:percent * 100];
        gr_progress_block(progress);
    }
    
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didFailRequest:(id<GRRequestProtocol>)request withError:(NSError *)error {
    
    if (gr_failure_block) {
        dispatch_async(dispatch_get_main_queue(), ^{
            gr_failure_block([[NSURLResponse alloc] init], error);
        });
    }
    
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteListingRequest:(id<GRRequestProtocol>)request listing:(NSArray *)listing {
    
    if (gr_success_block) {
        
        if ([[request uuid] isEqualToString:@"eventRequest"]) {
            
            NSArray *newListing = [NSArray array];
            for (NSString *item in listing) {
                if (![item containsString:@"_Photos"] && [[item pathExtension] isEqualToString:@"zip"]) {
                    newListing = [newListing arrayByAddingObject:item];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                gr_success_block([[NSURLResponse alloc] init], newListing);
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                gr_success_block([[NSURLResponse alloc] init], listing);
            });
        }
        
    }
    
}

@end
