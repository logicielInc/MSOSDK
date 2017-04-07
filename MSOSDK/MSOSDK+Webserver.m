
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
                                        success:(MSOSuccessBlock)success
                                        failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameterAccessKey   = [MSOSoapParameter parameterWithObject:accesskey                forKey:@"accessKey"];
    MSOSoapParameter *parameterUDID        = [MSOSoapParameter parameterWithObject:udid                     forKey:@"deviceID"];
    MSOSoapParameter *parameterCompanyName = [MSOSoapParameter parameterWithObject:companyname              forKey:@"companyName"];
    MSOSoapParameter *parameterPin         = [MSOSoapParameter parameterWithObject:pin                      forKey:@"pin"];
    MSOSoapParameter *parameterUsername    = [MSOSoapParameter parameterWithObject:username                 forKey:@"userAccount"];
    MSOSoapParameter *parameterPassword    = [MSOSoapParameter parameterWithObject:@"football33"                      forKey:@"userPassword"];
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         /*
         NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         responseObject = nil;
         
         if (user) {
             data = [data mso_stringBetweenString:@"<iCheckMobileUserResult>" andString:@"</iCheckMobileUserResult>"];
         } else {
             data = [data mso_stringBetweenString:@"<iCheckMobileDeviceResult>" andString:@"</iCheckMobileDeviceResult>"];
         }
         
         NSArray *components = [data componentsSeparatedByString:@","];
         data = nil;
         MSOSDKResponseWebserverCredentials *mso_response = [MSOSDKResponseWebserverCredentials msosdk_commandWithResponse:components];
         components = nil;
         mso_response.command = user ? mso_soap_function_iCheckMobileUser : mso_soap_function_iCheckMobileDevice;
         
         error = [MSOSDKResponseWebserver errorFromStatus:mso_response.status];
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         */
         
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
                                              success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseWebserverCredentials *mso_response =
         [MSOSDKResponseWebserverCredentials
          msosdk_commandWithResponseObject:responseObject
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
                                           success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         /*
         NSString *data = [MSOSDK sanatizeData:responseObject];
         responseObject = nil;
         data = [data mso_stringBetweenString:@"<iRegisterShortKeyResult>" andString:@"</iRegisterShortKeyResult>"];
         if (!data) {
             error = [NSError mso_internet_registration_key_invalid];
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *components = [data componentsSeparatedByString:@","];
         NSString *type = @"";
         if ([components count] >= 1) {
             type = [components objectAtIndex:0];
         }
         
         // Account Not Found
         if ([type isEqualToString:@""]) {
             error = [NSError mso_internet_registration_key_not_found];
         }
         
         // Account In Use
         if ([type isEqualToString:@"1"]) {
             error = [NSError mso_internet_registration_key_in_use];
         }
         
         // Account Already Registered with Same Company
         if ([type isEqualToString:@"2"]) {
             error = [NSError mso_internet_registration_key_same_company_use];
         }
         
         // Account Not Ready For Use
         if ([type isEqualToString:@"3"]) {
             error = [NSError mso_internet_registration_key_not_ready];
         }
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         MSOSDKResponseWebserverRegister *mso_response = [MSOSDKResponseWebserverRegister msosdk_commandWithResponse:data];
         data = nil;
         
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
         */
         
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
                                            success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         responseObject = nil;
         data = [data mso_stringBetweenString:@"<iRegisterCodeResult>" andString:@"</iRegisterCodeResult>"];
         NSString *pin = nil;
         
         if ([data isEqualToString:@""] || !data) {
             error = [NSError mso_internet_registration_key_unlock_code_error];
         } else if ([data isEqualToString:@"1"]) {
             error = [NSError mso_internet_registration_key_disabled_or_inuse];
         } else {
             //will return fullCDS instead if ([returnFromService isEqualToString:@"2"]) {
             pin = [[data componentsSeparatedByString:@"-"] objectAtIndex:2];
         }
         
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (pin) {
             
             MSOSDKResponseWebserverRegister *mso_response = [[MSOSDKResponseWebserverRegister alloc] init];
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
                                     success:(MSOSuccessBlock)success
                                    progress:(MSOProgressBlock)progress
                                     failure:(MSOFailureBlock)failure {
    
    NSString *hostname = @"ftp://ftp.logicielinc.com";
    NSString *username = @"manager";
    NSString *password = @"Log-8910";
    NSString *photosPath = [NSString stringWithFormat:@"/PUBLIC/Customer_Auto_FTP/%@/Photos/", pin];
    
    self.requestsManager = [[GRRequestsManager alloc] initWithHostname:hostname
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
                                                    success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
     
         /*
          NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
          responseObject = nil;
          data = [data mso_stringBetweenString:@"<_CheckPhotoFileStatusResult>" andString:@"</_CheckPhotoFileStatusResult>"];
          */
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *parentPhotos = [element firstObject];
         SMXMLElement *potentialPhotos = [parentPhotos descendantWithPath:@"_CheckPhotoFileStatusResponse._CheckPhotoFileStatusResult"];
         NSArray <NSString *> *photos = [[potentialPhotos children] valueForKey:@"value"];
         
         NSMutableArray <MSOSDKResponseWebserverPhotoDetails *> * photoDetails = [NSMutableArray array];
         
         NSString *string = [NSString stringWithFormat:@"^%@(-[0-9]+)?\\.(jpg|jpeg|png)$", itemNo];
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES [cd] %@", string];
         
         if (photos) {
             
             for (NSString *photo in photos) {
                 
                 MSOSDKResponseWebserverPhotoDetails *photoDetail = [MSOSDKResponseWebserverPhotoDetails detailsWithValue:photo];
                 
                 if (![predicate evaluateWithObject:photoDetail.filename]) {
                     photoDetail = nil;
                     continue;
                 }
                 
                 [photoDetails addObject:photoDetail];
                 
             }
             
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, photoDetails);
             });
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoWebserverDownloadPhoto:(NSString *)filename
                                                 pin:(NSString *)pin
                                             success:(MSOSuccessBlock)success
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
    [self
     dataTaskForWebserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
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
     } failure:failure];
    
    return task;
}

#pragma mark - Event
- (void)_msoWebserverDownloadEventList:(NSString *)pin
                               success:(MSOSuccessBlock)success
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
     
     NSURLRequest *request = [MSOSDK
     urlRequestWithParameters:@[parameterPin,
     parameterMSOPassword]
     type:mso_soap_function_getEventList
     url:[NSURL logicielCustomerURL]
     netserver:NO
     timeout:kMSOTimeoutDefaultKey];
     
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
     */
    
    //return task;
}

#pragma mark Check For Files
- (NSURLSessionDataTask *)_msoWebserverCheckForNumberOfFilesToDownload:(NSString *)userId
                                                                   pin:(NSString *)pin
                                                                  date:(NSDate *)date
                                                               success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         responseObject = nil;
         data = [data mso_stringBetweenString:@"<_iCheckMobileMessageResult>" andString:@"</_iCheckMobileMessageResult>"];
         
         NSNumber *numberOfFile = @([data integerValue]);
         
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
                                                       success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         MSOSDKResponseWebserverFilesToDownload *mso_response = [MSOSDKResponseWebserverFilesToDownload new];
         mso_response.command = mso_soap_function_iCheckMobileFileForDownloading;
         
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *parent = [element firstObject];
         SMXMLElement *child = [parent descendantWithPath:@"_iCheckMobileFileForDownloadingResponse"];
         SMXMLElement *filesToDownload = [child descendantWithPath:@"_iCheckMobileFileForDownloadingResult"];
         NSArray <SMXMLElement *> *files = [filesToDownload children];
         SMXMLElement *updatedDate = [child descendantWithPath:@"sLastUpdateDate"];
         NSString *updatedDateFormatted = updatedDate.value;
         mso_response.files = [NSArray array];
         
         for (SMXMLElement *file in files) {
             NSString *value = file.value;
             mso_response.files = [mso_response.files arrayByAddingObject:value];
         }
         
         NSDate *dateFormatted = [updatedDateFormatted mso_dateFromString];
         mso_response.dateUpdated = dateFormatted;
         
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
                                             success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         //NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, nil);
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
                                                  success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *statusResponse = [element firstObject];
         SMXMLElement *statusResponseFormatted = [statusResponse descendantWithPath:@"_UpdateDownloadInfoResponse._UpdateDownloadInfoResult"];
         NSString *formattedStatus = statusResponseFormatted.value;
         
         MSOSDKResponseWebserverRequestData *mso_response = [MSOSDKResponseWebserverRequestData new];
         mso_response.status = @([formattedStatus integerValue]);
         mso_response.command = mso_soap_function_updateDownloadInfo;
         
         if (![mso_response.status isEqualToNumber:@2]) {
             error = [NSError mso_internet_request_data_error];
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
                                                             success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, document);
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
                                           success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         [dDict removeObjectForKey:filename];
         
         if ([[dDict allKeys] count] == 0) {
             if (success) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, nil);
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
                                        success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *statusResponse = [element firstObject];
         SMXMLElement *statusResponseFormatted = [statusResponse descendantWithPath:@"_UploadFileResponse._UploadFileResult"];
         NSString *formattedStatus = statusResponseFormatted.value;
         
         if (![formattedStatus boolValue]) {
             
             if (failure) {
                 error = [NSError mso_internet_upload_processing_error];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     failure(response, error);
                 });
             }
             return;
             
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, @1);
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
                                                 success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *statusResponse = [element firstObject];
         SMXMLElement *statusResponseFormatted = [statusResponse descendantWithPath:@"_UpdateUploadInfoResponse._UpdateUploadInfoResult"];
         NSString *formattedStatus = statusResponseFormatted.value;
         
         if ([formattedStatus isEqualToString:@"2"]) {
             
             if (success) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, @1);
                 });
             }
             return;
             
         }
         
         error = [NSError mso_internet_upload_processing_error];
         [NSError errorHandler:error response:response failure:failure];
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoWebserverSendDataRequest:(NSString *)username
                                                   pin:(NSString *)pin
                                                  udid:(NSString *)udid
                                           companyname:(NSString *)companyname
                                              criteria:(NSString *)criteria
                                               success:(MSOSuccessBlock)success
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
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:command
                                                                 forKey:@"allInfo"];
    
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         /*
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *statusResponse = [element firstObject];
         SMXMLElement *statusResponseFormatted = [statusResponse descendantWithPath:@"_UpdateUploadInfoResponse._UpdateUploadInfoResult"];
         NSString *formattedStatus = statusResponseFormatted.value;
         
         MSOSDKResponseWebserverRequestData *mso_response = [MSOSDKResponseWebserverRequestData msosdk_commandWithResponse:nil];
         mso_response.status = @([formattedStatus integerValue]);
         mso_response.command = mso_soap_function_updateUploadInfo;
         
         if (![mso_response.status isEqualToNumber:@2]) {
             error = [NSError mso_internet_request_data_error];
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         */
         
     } failure:failure];
    
    return task;
}

#pragma mark - Catalogs
- (NSURLSessionDataTask *)_msoWebserverFetchCatalog:(NSString *)catalogName
                                                pin:(NSString *)pin
                                            success:(MSOSuccessBlock)success
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         /*
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLElement *element = [document descendantWithPath:@"Body._CheckCatalogFileStatusResponse._CheckCatalogFileStatusResult"];
         NSArray <SMXMLElement *> *catalogs = [element children];
         
         if (!catalogs || [catalogs count] == 0) {
             // No data in FTP, return error
             error = [NSError mso_internet_catalog_no_content];
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSMutableArray *catalogObjects = [NSMutableArray array];
         
         for (SMXMLElement *catalog in catalogs) {
             
             NSString *value = catalog.value;
             NSArray* components = [value componentsSeparatedByString:@"]["];
             if ([components count] > 2) {
                 MSOSDKResponseWebserverCatalog *catalogObject = [MSOSDKResponseWebserverCatalog msosdk_commandWithResponse:components];
                 [catalogObjects addObject:catalogObject];
             }
             
         }
         
         if ([catalogObjects count] == 0) {
             error = [NSError mso_internet_catalog_no_content];
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, catalogObjects);
             });
         }
         */
         
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
     success:^(NSURLResponse * _Nonnull response, NSString * _Nullable responseObject, NSError * _Nullable error) {
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         //         SMXMLElement *element = [document descendantWithPath:@"Body.GetCustomersByCompanyResponse.GetCustomersByCompanyResult"];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, nil);
             });
         }
         
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