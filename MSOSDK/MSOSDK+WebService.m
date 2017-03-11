
//
//  MSOSDK+WebService.m
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDKResponseWebService.h"

#import "MSOSDK+WebService.h"

#import <SMXMLDocument/SMXMLDocument.h>

#import "GRRequestProtocol.h"

@implementation MSOSDK (WebService)

#pragma mark - Web Service Credentials
#pragma mark Login
- (NSURLSessionDataTask *)_msoWebServiceValidity:(NSString *)username
                                       accesskey:(NSString *)accesskey
                                            udid:(NSString *)udid
                                             pin:(NSString *)pin
                                     companyname:(NSString *)companyname
                                      appversion:(NSString *)appversion
                                            user:(BOOL)user
                                         success:(MSOSuccessBlock)success
                                         failure:(MSOFailureBlock)failure {
    
    username = username ?: @"";
    accesskey = accesskey ?: @"";
    udid = udid ?: @"";
    companyname = companyname ?: @"";
    pin = pin ?: @"";
    appversion = appversion ?: @"";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:accesskey     forKey:@"accessKey"];
    [parameters setObject:udid          forKey:@"deviceID"];
    [parameters setObject:companyname   forKey:@"companyName"];
    [parameters setObject:pin           forKey:@"pin"];
    [parameters setObject:username      forKey:@"userAccount"];
    [parameters setObject:@""           forKey:@"userPassword"];
    [parameters setObject:appversion    forKey:@"appVersion"];
    [parameters setObject:@"0"          forKey:@"iType"];
    [parameters setObject:mso_password forKey:@"password"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:parameters
                             keys:@[@"accessKey", @"deviceID", @"companyName", @"pin", @"userAccount", @"userPassword", @"appVersion", @"iType", @"password"]
                             type:user ? mso_soap_function_iCheckMobileUser : mso_soap_function_iCheckMobileDevice
                             url:[MSOSDK logicielCustomerURL]
                             netserver:NO
                             timeout:kMSOTimeoutLoginKey
                             error:&error];
    
    parameters = nil;
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         responseObject = nil;
         
         if (user) {
             data = [data mso_stringBetweenString:@"<iCheckMobileUserResult>" andString:@"</iCheckMobileUserResult>"];
         } else {
             data = [data mso_stringBetweenString:@"<iCheckMobileDeviceResult>" andString:@"</iCheckMobileDeviceResult>"];
         }
         
         NSArray *components = [data componentsSeparatedByString:@","];
         data = nil;
         MSOSDKResponseWebServiceCredentials *mso_response = [MSOSDKResponseWebServiceCredentials msosdk_commandWithResponse:components];
         components = nil;
         mso_response.command = user ? mso_soap_function_iCheckMobileUser : mso_soap_function_iCheckMobileDevice;
         
         error = [MSOSDKResponseWebService errorFromStatus:mso_response.status];
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     }];
    
    return task;
    
}


#pragma mark Forgot Password
- (NSURLSessionDataTask *)_msoWebServiceForgotPassword:(NSString *)username
                                              password:(NSString *)password
                                             accesskey:(NSString *)accesskey
                                                  udid:(NSString *)udid
                                                   pin:(NSString *)pin
                                            appversion:(NSString *)appversion
                                           companyname:(NSString *)companyname
                                               success:(MSOSuccessBlock)success
                                               failure:(MSOFailureBlock)failure {
    
    username = username ?: @"";
    accesskey = accesskey ?: @"";
    udid = udid ?: @"";
    companyname = companyname ?: @"";
    pin = pin ?: @"";
    password = password ?: @"";
    appversion = appversion ?: @"";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:accesskey       forKey:@"accessKey"];
    [parameters setObject:udid            forKey:@"deviceID"];
    [parameters setObject:companyname     forKey:@"companyName"];
    [parameters setObject:pin             forKey:@"pin"];
    [parameters setObject:username        forKey:@"userAccount"];
    [parameters setObject:password        forKey:@"userPassword"];
    [parameters setObject:appversion      forKey:@"appVersion"];
    [parameters setObject:@"1"            forKey:@"iType"];
    [parameters setObject:mso_password   forKey:@"password"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:parameters
                             keys:@[@"accessKey", @"deviceID", @"companyName", @"pin", @"userAccount", @"userPassword", @"appVersion", @"iType", @"password"]
                             type:mso_soap_function_iCheckMobileDevice
                             url:[MSOSDK logicielCustomerURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    parameters = nil;
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         responseObject = nil;
         data = [data mso_stringBetweenString:@"<iCheckMobileDeviceResult>" andString:@"</iCheckMobileDeviceResult>"];
         NSArray *components = [data componentsSeparatedByString:@","];
         data = nil;
         MSOSDKResponseWebServiceCredentials *mso_response = [MSOSDKResponseWebServiceCredentials msosdk_commandWithResponse:components];
         components = nil;
         mso_response.command = mso_soap_function_iCheckMobileDevice;
         
         error = [MSOSDKResponseWebService errorFromStatus:mso_response.status];
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
     }];
    
    return task;
}

#pragma mark Registration
- (NSURLSessionDataTask *)_msoWebServiceRegisterRep:(NSString *)username
                                          accesskey:(NSString *)accesskey
                                              email:(NSString *)email
                                               udid:(NSString *)udid
                                         appversion:(NSString *)appversion
                                            success:(MSOSuccessBlock)success
                                            failure:(MSOFailureBlock)failure {
    
    username = username ?: @"";
    accesskey = accesskey ?: @"";
    udid = udid ?: @"";
    appversion = appversion ?: @"";
    email = email ?: @"";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:accesskey     forKey:@"accessKey"];
    [parameters setObject:udid          forKey:@"deviceID"];
    [parameters setObject:username      forKey:@"userName"];
    [parameters setObject:email         forKey:@"userEmail"];
    [parameters setObject:appversion    forKey:@"appVersion"];
    [parameters setObject:mso_password forKey:@"password"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:parameters
                             keys:@[@"accessKey", @"deviceID", @"userName", @"userEmail", @"appVersion", @"password"]
                             type:mso_soap_function_iRegisterShortKey
                             url:[MSOSDK logicielCustomerURL]
                             netserver:NO
                             timeout:kMSOTimeoutRegistrationKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         responseObject = nil;
         data = [data mso_stringBetweenString:@"<iRegisterShortKeyResult>" andString:@"</iRegisterShortKeyResult>"];
         
         if (!data) {
             error = [NSError mso_internet_registration_key_invalid];
             [self errorHandler:error response:response failure:failure];
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
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         MSOSDKResponseWebServiceRegister *mso_response = [MSOSDKResponseWebServiceRegister msosdk_commandWithResponse:data];
         data = nil;
         
         if ([mso_response.pin isEqualToString:@"?"]) {
             
             NSURLSessionDataTask *task =
             
             [self
              _msoWebServiceRegisterCode:mso_response.rep
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
         
     }];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebServiceRegisterCode:(NSString *)username
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
    
    accesskey = accesskey ?: @"";
    cds = cds ?: @"";
    udid = udid ?: @"";
    appversion = appversion ?: @"";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:accesskey     forKey:@"accessKey"];
    [parameters setObject:udid          forKey:@"deviceID"];
    [parameters setObject:cds           forKey:@"full_CDS"];
    [parameters setObject:appversion    forKey:@"appVersion"];
    [parameters setObject:mso_password forKey:@"password"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:parameters
                             keys:@[@"accessKey", @"deviceID", @"full_CDS", @"appVersion", @"password"]
                             type:mso_soap_function_iRegisterCode
                             url:[MSOSDK logicielCustomerURL]
                             netserver:NO
                             timeout:kMSOTimeoutRegistrationKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
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
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         if (pin) {
             
             MSOSDKResponseWebServiceRegister *mso_response = [[MSOSDKResponseWebServiceRegister alloc] init];
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
              _msoWebServiceRegisterRep:username
              accesskey:accesskey
              email:email
              udid:udid
              appversion:appversion
              success:success
              failure:failure];
             
             [task resume];
             
             return;
         }
         
     }];
    
    return task;
    
}

#pragma mark - Images

static MSOSuccessBlock gr_success_block;
static MSOProgressBlock gr_progress_block;
static MSOFailureBlock gr_failure_block;

- (void)_msoWebServiceFetchAllPhotoReferences:(NSString *)pin
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
        dispatch_async(dispatch_get_main_queue(), ^{
            gr_success_block([[NSURLResponse alloc] init], listing);
        });
    }

}



- (NSURLSessionDataTask *)_msoWebServiceFetchPhotoFileStatus:(NSString *)itemNo
                                                         pin:(NSString *)pin
                                                     success:(MSOSuccessBlock)success
                                                    progress:(MSOProgressBlock)progress
                                                     failure:(MSOFailureBlock)failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:itemNo    forKey:@"sItemNo"];
    [parameters setObject:pin       forKey:@"sPIN"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:parameters
                             keys:@[@"sPIN", @"sItemNo"]
                             type:@"_CheckPhotoFileStatus"
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    parameters = nil;
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *parentPhotos = [element firstObject];
         SMXMLElement *potentialPhotos = [parentPhotos descendantWithPath:@"_CheckPhotoFileStatusResponse._CheckPhotoFileStatusResult"];
         NSArray <SMXMLElement *> *photos = [potentialPhotos children];
         
         NSMutableArray <MSOSDKResponseWebServicePhotoDetails *> * photoDetails = [NSMutableArray array];
         
         NSString *string = [NSString stringWithFormat:@"^%@(-[0-9]+)?\\.(jpg|jpeg|png)$", itemNo];
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES [cd] %@", string];
         
         if (photos) {
             for (SMXMLElement *photo in photos) {
                 
                 NSString *value = photo.value;
                 MSOSDKResponseWebServicePhotoDetails *photoDetail = [MSOSDKResponseWebServicePhotoDetails detailsWithValue:value];
                 
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
         
     }];
    
    return task;
}

- (NSURLSessionDataTask *)_msoWebServiceDownloadPhoto:(NSString *)filename
                                                  pin:(NSString *)pin
                                              success:(MSOSuccessBlock)success
                                             progress:(MSOProgressBlock)progress
                                              failure:(MSOFailureBlock)failure {
    
    NSURL *url = [NSURL URLWithString:kMSOLogicielHTTPURLKey];
    url = [url URLByAppendingPathComponent:pin];
    url = [url URLByAppendingPathComponent:@"Photos"];
    url = [url URLByAppendingPathComponent:filename];

    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestImage:url
                             timeout:kMSOTimeoutImageSyncKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         UIImage *image = [UIImage imageWithData:responseObject];
         
         if (!image) {
             error = [NSError mso_internet_image_download_error:response.URL.lastPathComponent];
             [self errorHandler:error response:response failure:failure];
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
- (NSURLSessionDataTask *)_msoWebServiceDownloadEventList:(NSString *)pin
                                                  success:(MSOSuccessBlock)success
                                                 progress:(MSOProgressBlock)progress
                                                  failure:(MSOFailureBlock)failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:pin           forKey:@"PIN"];
    [parameters setObject:mso_password forKey:@"password"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:parameters
                             keys:@[@"PIN", @"password"]
                             type:mso_soap_function_getEventList
                             url:[MSOSDK logicielCustomerURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
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
         
     }];
    
    return task;
}

#pragma mark Check For Files
- (NSURLSessionDataTask *)_msoWebServiceCheckForNumberOfFilesToDownload:(NSString *)userId
                                                                    pin:(NSString *)pin
                                                                   date:(NSDate *)date
                                                                success:(MSOSuccessBlock)success
                                                               progress:(MSOProgressBlock)progress
                                                                failure:(MSOFailureBlock)failure {
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:pin                             forKey:@"sPIN"];
    [dict setObject:userId                          forKey:@"sUserID"];
    [dict setObject:@"1"                            forKey:@"iCheckType"];
    [dict setObject:[MSOSDK stringFromDate:date]    forKey:@"sLastViewDate"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:dict
                             keys:@[@"sPIN", @"sUserID", @"iCheckType", @"sLastViewDate"]
                             type:mso_soap_function_iCheckMobileMessage
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         responseObject = nil;
         data = [data mso_stringBetweenString:@"<_iCheckMobileMessageResult>" andString:@"</_iCheckMobileMessageResult>"];
         
         NSNumber *numberOfFile = @([data integerValue]);
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, numberOfFile);
             });
         }
         
         
     }];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebServiceCheckForFilesToDownload:(NSString *)userId
                                                            pin:(NSString *)pin
                                                           date:(NSDate *)date
                                                        success:(MSOSuccessBlock)success
                                                       progress:(MSOProgressBlock)progress
                                                        failure:(MSOFailureBlock)failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:pin                             forKey:@"sPIN"];
    [dict setObject:userId                          forKey:@"sUserID"];
    [dict setObject:@"1"                            forKey:@"iCheckType"];
    [dict setObject:[MSOSDK stringFromDate:date]    forKey:@"sLastViewDate"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:dict
                             keys:@[@"sPIN", @"sUserID", @"iCheckType", @"sLastViewDate"]
                             type:mso_soap_function_iCheckMobileFileForDownloading
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         
         MSOSDKResponseWebServiceFilesToDownload *mso_response = [MSOSDKResponseWebServiceFilesToDownload msosdk_commandWithResponse:document];
         mso_response.command = mso_soap_function_iCheckMobileFileForDownloading;
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     }];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebServiceCheckForFiles:(NSString *)userId
                                                  pin:(NSString *)pin
                                                 date:(NSDate *)date
                                              success:(MSOSuccessBlock)success
                                             progress:(MSOProgressBlock)progress
                                              failure:(MSOFailureBlock)failure {
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:pin                             forKey:@"sPIN"];
    [dict setObject:userId                          forKey:@"sUserID"];
    [dict setObject:@"1"                            forKey:@"iCheckType"];
    [dict setObject:[MSOSDK stringFromDate:date]    forKey:@"lastViewDate"];
    
    NSError *error = nil;
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:dict
                             keys:@[@"sPIN", @"sUserID", @"iCheckType", @"lastViewDate"]
                             type:mso_soap_function_iCheckPDAMessage
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         //NSString *data = [[NSString alloc] initWithData:responseObject encoding:stringEncoding];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, nil);
             });
         }
         
     }];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebServiceUpdateDownloadInfo:(NSString *)username
                                               companyname:(NSString *)companyname
                                                      udid:(NSString *)udid
                                                       pin:(NSString *)pin
                                                  fileName:(NSString *)fileName
                                              downloadDate:(NSDate *)downloadDate
                                                   success:(MSOSuccessBlock)success
                                                  progress:(MSOProgressBlock)progress
                                                   failure:(MSOFailureBlock)failure {
    
    NSFileManager *man = [[NSFileManager alloc] init];
    NSDictionary *attrs = [man attributesOfItemAtPath:fileName error:nil];
    unsigned long long fileS = [attrs fileSize];
    
    NSString * fileLength = [NSString stringWithFormat:@"%llu", fileS];
    
    NSString *dateString = [MSOSDK stringFromDate:downloadDate];
    
    NSMutableArray *allInfo = [NSMutableArray array];
    [allInfo addObject:@""];
    [allInfo addObject:pin];
    [allInfo addObject:@"PDA"];
    [allInfo addObject:@"100"];
    [allInfo addObject:[fileName lastPathComponent]];
    [allInfo addObject:@""];
    [allInfo addObject:dateString];
    [allInfo addObject:companyname];
    [allInfo addObject:@""];
    [allInfo addObject:username];
    [allInfo addObject:@"Rep"];
    [allInfo addObject:@""];
    [allInfo addObject:udid];
    [allInfo addObject:@""];
    [allInfo addObject:fileLength];
    [allInfo addObject:@"00:00:01"];
    [allInfo addObject:@""];
    [allInfo addObject:@""];
    
    NSMutableString *str = [NSMutableString string];
    for (NSString *s in allInfo) {
        [str appendString:[NSString stringWithFormat:@"<string>%@</string>", s]];
    }
    
    NSMutableString *command = [NSMutableString string];
    for (NSString *str in allInfo) {
        [command appendFormat:@"<string>%@</string>", str];
    }
    
    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@{@"allInfo" : command}
                             keys:@[@"allInfo"]
                             type:mso_soap_function_updateDownloadInfo
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDataRequestKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *statusResponse = [element firstObject];
         SMXMLElement *statusResponseFormatted = [statusResponse descendantWithPath:@"_UpdateDownloadInfoResponse._UpdateDownloadInfoResult"];
         NSString *formattedStatus = statusResponseFormatted.value;
         
         MSOSDKResponseWebServiceRequestData *mso_response = [MSOSDKResponseWebServiceRequestData msosdk_commandWithResponse:nil];
         mso_response.status = @([formattedStatus integerValue]);
         mso_response.command = mso_soap_function_updateDownloadInfo;
         
         if (![mso_response.status isEqualToNumber:@2]) {
             error = [NSError mso_internet_request_data_error];
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     }];
    
    return task;
}

- (NSURLSessionDataTask *)_msoWebServiceCheckPDAHistoryForDownloading:(NSString *)username
                                                                  pin:(NSString *)pin
                                                              success:(MSOSuccessBlock)success
                                                             progress:(MSOProgressBlock)progress
                                                              failure:(MSOFailureBlock)failure {
    
    username = username ?: @"";
    pin = pin ?: @"";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:pin         forKey:@"sPIN"];
    [dict setObject:username    forKey:@"sUserID"];
    [dict setObject:@"0"        forKey:@"iCheckType"];
    
    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:dict
                             keys:@[@"sPIN", @"sUserID", @"iCheckType"]
                             type:mso_soap_function_iCheckPDAHistoryForDownloading
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         
         MSOSDKResponseWebServiceDownloadHistory *mso_response = [MSOSDKResponseWebServiceDownloadHistory msosdk_commandWithResponse:document];
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     }];
    
    return task;
    
}

#pragma mark - FTP Interaction
#pragma mark Upload
- (NSURLSessionDataTask *)_msoWebServiceUploadToFTP:(NSDictionary <NSString *, NSData *> *)data
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
          _msoWebServiceUploadToFTP:dDict
          pin:pin
          newfile:newfile
          success:success
          progress:progress
          failure:failure];
         
         [innerTask resume];

     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         [self errorHandler:error response:response failure:failure];
         
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
    
    NSString *d = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn | NSDataBase64EncodingEndLineWithLineFeed];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:pin                             forKey:@"sPIN"];
    [dict setObject:[filename lastPathComponent]    forKey:@"sFileName"];
    [dict setObject:d                               forKey:@"bytesBuff"];
    [dict setObject:@((int)[data length])           forKey:@"contentLenth"];
    [dict setObject:@(newfile)                      forKey:@"newFile"];
    
    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:dict
                             keys:@[@"sPIN", @"sFileName", @"bytesBuff", @"contentLenth", @"newFile"]
                             type:mso_soap_function_uploadFile
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutSalesOrderKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:progress
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
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
         
     }];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoWebServiceUploadToFTPUpdate:(NSString *)pin
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
    [allInfo addObject:[MSOSDK stringFromDate:updateDate]];
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
    
    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@{@"allInfo" : info}
                             keys:@[@"allInfo"]
                             type:mso_soap_function_updateUploadInfo
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
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
         [self errorHandler:error response:response failure:failure];
         
     }];

    return task;
}

- (NSURLSessionDataTask *)_msoWebServiceSendDataRequest:(NSString *)username
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
    [allInfo addObject:[MSOSDK stringFromDate:[NSDate date]]];
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
    
    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@{@"allInfo" : command}
                             keys:@[@"allInfo"]
                             type:mso_soap_function_updateUploadInfo
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutDataRequestKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray <SMXMLElement *> *element = document.children;
         SMXMLElement *statusResponse = [element firstObject];
         SMXMLElement *statusResponseFormatted = [statusResponse descendantWithPath:@"_UpdateUploadInfoResponse._UpdateUploadInfoResult"];
         NSString *formattedStatus = statusResponseFormatted.value;
         
         MSOSDKResponseWebServiceRequestData *mso_response = [MSOSDKResponseWebServiceRequestData msosdk_commandWithResponse:nil];
         mso_response.status = @([formattedStatus integerValue]);
         mso_response.command = mso_soap_function_updateUploadInfo;
         
         if (![mso_response.status isEqualToNumber:@2]) {
             error = [NSError mso_internet_request_data_error];
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     }];
    
    return task;
}

#pragma mark - Catalogs
- (NSURLSessionDataTask *)_msoWebServiceFetchCatalog:(NSString *)catalogName
                                                 pin:(NSString *)pin
                                             success:(MSOSuccessBlock)success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:pin         forKey:@"sPIN"];
    [dict setObject:catalogName forKey:@"sCatalogNo"];
    
    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:dict
                             keys:@[@"sPIN", @"sCatalogNo"]
                             type:mso_soap_function_checkCatalogFileStatus
                             url:[MSOSDK logicielFTPServiceURL]
                             netserver:NO
                             timeout:kMSOTimeoutCatalogKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLElement *element = [document descendantWithPath:@"Body._CheckCatalogFileStatusResponse._CheckCatalogFileStatusResult"];
         NSArray <SMXMLElement *> *catalogs = [element children];
         
         if (!catalogs || [catalogs count] == 0) {
             // No data in FTP, return error
             error = [NSError mso_internet_catalog_no_content];
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         NSMutableArray *catalogObjects = [NSMutableArray array];
         
         for (SMXMLElement *catalog in catalogs) {
             
             NSString *value = catalog.value;
             NSArray* components = [value componentsSeparatedByString:@"]["];
             if ([components count] > 2) {
                 MSOSDKResponseWebServiceCatalog *catalogObject = [MSOSDKResponseWebServiceCatalog msosdk_commandWithResponse:components];
                 [catalogObjects addObject:catalogObject];
             }
             
         }
         
         if ([catalogObjects count] == 0) {
             error = [NSError mso_internet_catalog_no_content];
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, catalogObjects);
             });
         }
         
     }];
    
    return task;

}

- (NSURLSessionDataTask *)_msoWebServiceFetchCustomersByCompanyName:(NSString *)companyName
                                                                pin:(NSString *)pin
                                                            success:(MSOSuccessBlock)success
                                                           progress:(MSOProgressBlock)progress
                                                            failure:(MSOFailureBlock)failure
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:companyName     forKey:@"companyName"];
    [dict setObject:pin             forKey:@"pin"];
    [dict setObject:mso_password   forKey:@"password"];
    [dict setObject:@"1"            forKey:@"logicielApplication"];
    
    NSError *error = nil;
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:dict
                             keys:@[@"companyName", @"pin", @"password", @"logicielApplication"]
                             type:mso_soap_function_getCustomersByCompany
                             url:[MSOSDK logicielCustomerURL]
                             netserver:NO
                             timeout:kMSOTimeoutDefaultKey
                             error:&error];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             [self errorHandler:error response:response failure:failure];
             return;
         }
         
         SMXMLDocument *document = [SMXMLDocument documentWithData:responseObject error:&error];
         responseObject = nil;
         
         if (!document) {
             [self errorHandler:error response:response failure:failure];
             return;
         }

//         SMXMLElement *element = [document descendantWithPath:@"Body.GetCustomersByCompanyResponse.GetCustomersByCompanyResult"];

         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, nil);
             });
         }
         
     }];
    
    return task;
    
}

@end
