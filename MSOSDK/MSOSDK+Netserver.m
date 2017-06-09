//
//  MSOSDK+Netserver.m
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDK+Netserver.h"

@implementation MSOSDK (Netserver)

#pragma mark - Connection
- (NSURLSessionDataTask *)_msoNetserverPing:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverPing * _Nonnull))success
                                    failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_S001"
     mso_build_command:@[@"",
                         @"WLAN Connection?"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutPingKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverPing *msosdk_command =
         [MSOSDKResponseNetserverPing
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!msosdk_command) {

             if (failure) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     failure(response, error);
                 });
             }

             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, msosdk_command);
             });
         }
         
     } failure:failure];
    
    return task;
}

#pragma mark - Netserver Credentials
#pragma mark Login
- (NSURLSessionDataTask *)_msoNetserverLogin:(NSString *)username
                                    password:(NSString *)password
                                     success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverLogin * _Nonnull))success
                                     failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_U001"
     mso_build_command:@[@"",
                         username,
                         password]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverLogin *msosdk_command =
         [MSOSDKResponseNetserverLogin
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!msosdk_command) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
                  
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, msosdk_command);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoNetserverIsManager:(NSString *)username
                                    password:(NSString *)password
                                     success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverLogin * _Nonnull))success
                                     failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_U001"
     mso_build_command:@[@"",
                         username,
                         password]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverLogin *msosdk_command =
         [MSOSDKResponseNetserverLogin
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!msosdk_command) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, msosdk_command);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoNetserverFetchInitialSettings:(NSString *)username
                                                    success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSettings * _Nonnull))success
                                                    failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_S002"
     mso_build_command:@[username,
                         @"Initial iPad Settings?"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverSettings *msosdk_command =
         [MSOSDKResponseNetserverSettings
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!msosdk_command) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, msosdk_command);
             });
         }
         
     } failure:failure];
    
    return task;
}

#pragma mark Logout
- (NSURLSessionDataTask *)_msoNetserverLogout:(void (^ _Nullable)(NSURLResponse * _Nonnull, BOOL))success
                                      failure:(MSOFailureBlock)failure {
    
    
    NSString *xml =
    [@""
     mso_build_command:nil];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, YES);
             });
         }
         
     } failure:failure];
    
    return task;
}

#pragma mark - Products
- (NSURLSessionDataTask *)_msoNetserverFetchItemList:(NSString *)username
                                           companyId:(NSString *)companyId
                                            itemList:(NSArray<NSString *> *)itemList
                                             success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverQueryProducts * _Nullable))success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure
                                             handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverQueryProducts * _Nonnull, NSError **error))handler {
 
    NSString *xml =
    [@"_P005"
     mso_build_command:@[username,
                         companyId,
                         @"Item List",
                         [itemList componentsJoinedByString:@"^"]]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutProductsSyncKey];

    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverQueryProducts *mso_response =
         [MSOSDKResponseNetserverQueryProducts
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         if (handler) {
             handler(response, mso_response, &error);
         }
         
         if (success) {
             if (handler) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, nil);
                 });
             } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, mso_response);
                 });
             }
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverDownloadNumberOfProducts:(NSString *)username
                                                        success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverProductsCount * _Nonnull))success
                                                       progress:(MSOProgressBlock)progress
                                                        failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_S004"
     mso_build_command:@[username,
                         @"Product Total?",
                         @""]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverProductsCount *msosdk_command =
         [MSOSDKResponseNetserverProductsCount
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!msosdk_command) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, msosdk_command);
             });
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoNetserverDownloadAllProducts:(NSString *)username
                                                    nextId:(NSString *)nextId
                                                 companyId:(NSString *)companyId
                                                   success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncProducts * _Nonnull))success
                                                  progress:(MSOProgressBlock)progress
                                                   failure:(MSOFailureBlock)failure
                                                   handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncProducts * _Nonnull, NSError **))handler {
    
    NSURLSessionDataTask *task =
    [self
     _msoNetserverDownloadNumberOfProducts:username
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         MSOSDKResponseNetserverProductsCount *mso_response = responseObject;
         NSNumber *productCount = mso_response.productCount;
         __block NSInteger cur = 0;
         
         NSURLSessionDataTask *task =
         [self
          _msoNetserverDownloadAllProducts:username
          nextId:nextId
          companyId:companyId
          success:success
          failure:failure
          handler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
              
              if (handler) {
                  handler(response, responseObject, error);
              }
              
              if (*error) {
                  [NSError errorHandler:*error response:response failure:failure];
                  return;
              }
              
              
              if (progress) {
                  NSInteger count = [productCount integerValue];
                  NSProgress *progression = [NSProgress progressWithTotalUnitCount:count];
                  if (count < 2000) {
                      cur += count;
                  } else {
                      cur += 2000;
                  }
                  [progression setCompletedUnitCount:cur];
                  progress(progression);
              }
              
          }];
         [task resume];
         
     } progress:nil failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverDownloadAllProducts:(NSString *)username
                                                    nextId:(NSString *)nextId
                                                 companyId:(NSString *)companyId
                                                   success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncProducts * _Nullable))success
                                                   failure:(MSOFailureBlock)failure
                                                   handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncProducts * _Nonnull, NSError **))handler {

    NSString *xml =
    [@"_S004"
     mso_build_command:@[username,
                         @"Product List?[iPad]",
                         companyId,
                         nextId]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverSyncProducts *mso_response =
         [MSOSDKResponseNetserverSyncProducts
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (handler) {
             handler(response, mso_response, &error);
         }
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *nextIndex = mso_response.nextIndex;
         NSString *companyId = mso_response.companyId;
         
         if (nextIndex.length > 0 && companyId.length > 0) {
             NSURLSessionDataTask *task =
             [self
              _msoNetserverDownloadAllProducts:username
              nextId:nextIndex
              companyId:companyId
              success:success
              failure:failure
              handler:handler];
             
             [task resume];
             return;
         }
         
         if (success) {
             if (handler) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, nil);
                 });
             } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, mso_response);
                 });
             }
             return;
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverDownloadProducts:(NSString *)username
                                             searchTerm:(NSString *)searchTerm
                                              companyId:(NSString *)companyId
                                             searchType:(kMSOProductSearchType)searchType
                                                success:(MSOSuccessBlock)success
                                                failure:(MSOFailureBlock)failure {
    
    NSString *type =
    [NSString
     mso_product_search_type_formatted:searchType];

    NSString *xml =
    [@"_P001"
     mso_build_command:@[username,
                         searchTerm,
                         companyId,
                         @"0",
                         type]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverQueryProducts *mso_response =
         [MSOSDKResponseNetserverQueryProducts
          msosdk_commandWithResponseObject:responseObject
          error:&error];

         if (!mso_response) {
             
             [NSError errorHandler:error response:response failure:failure];
             return;
             
         }
         
         if ([mso_response.command isEqualToString:@"_X001"]) {
             // fetch for more data
             
             NSURLSessionDataTask *task =
             [self
              _msoNetserverDownloadExtendedProducts:username
              mso_response:&mso_response
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

- (NSURLSessionDataTask *)_msoNetserverDownloadExtendedProducts:(NSString *)username
                                                   mso_response:(MSOSDKResponseNetserverQueryProducts **)mso_respons
                                                        success:(MSOSuccessBlock)success
                                                        failure:(MSOFailureBlock)failure {
    
    __block MSOSDKResponseNetserverQueryProducts *mso_response = *mso_respons;
    
    NSString *xml =
    [mso_response.command
     mso_build_command:@[username,
                         mso_response.pages]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         [mso_response mso_appendResponseObject:responseObject];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (![mso_response.pages isEqualToString:@"1"]) {
             
             NSURLSessionDataTask *task =
             [self
              _msoNetserverDownloadExtendedProducts:username
              mso_response:&mso_response
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


#pragma mark - Customers
- (NSURLSessionDataTask *)_msoNetserverSaveCustomerMappingScheme:(NSString *)username
                                                   mappingScheme:(NSString *)mappingScheme
                                                         success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncSaveCustomerMapping * _Nonnull))success
                                                        progress:(MSOProgressBlock)progress
                                                         failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_C006"
     mso_build_command:@[username,
                         @"Auto-Mapping",
                         mappingScheme]];

    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutCustomersSyncKey];

    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSyncSaveCustomerMapping *mso_response =
         [MSOSDKResponseNetserverSyncSaveCustomerMapping
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

- (NSURLSessionDataTask *)_msoNetserverUpdateCustomerMappingScheme:(NSString *)username
                                                     mappingScheme:(NSString *)mappingScheme
                                                 mappingSchemeData:(NSString *)mappingSchemeData
                                                           success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncUpdateCustomerMapping * _Nonnull))success
                                                          progress:(MSOProgressBlock)progress
                                                           failure:(MSOFailureBlock)failure {

    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:[@"_C007" mso_build_command:@[username,
                                                       @"Save-Mapping",
                                                       mappingScheme,
                                                       mappingSchemeData]]
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutCustomersSyncKey];

    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSyncUpdateCustomerMapping *mso_response =
         [MSOSDKResponseNetserverSyncUpdateCustomerMapping
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

- (NSURLSessionDataTask *)_msoNetserverDownloadAllCustomers:(NSString *)username
                                                     nextId:(NSString *)nextId
                                                    success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncCustomers * _Nullable))success
                                                   progress:(MSOProgressBlock)progress
                                                    failure:(MSOFailureBlock)failure
                                                    handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncCustomers * _Nonnull, NSError **))handler {
    
    NSString *xml =
    [@"_S003"
     mso_build_command:@[username,
                         @"Customer List?[iPad]",
                         nextId]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutCustomersSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSyncCustomers *mso_response =
         [MSOSDKResponseNetserverSyncCustomers
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (handler) {
             handler(response, mso_response, &error);
         }
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *nextIndex = mso_response.nextIndex;
         
         if ([nextIndex integerValue] != 0) {
             NSURLSessionDataTask *task =
             [self
              _msoNetserverDownloadAllCustomers:username
              nextId:nextIndex
              success:success
              progress:progress
              failure:failure
              handler:handler];
             
             [task resume];
             return;
         }
         
         if (success) {
             
             if (handler) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, nil);
                 });
             } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, mso_response);
                 });
             }
             return;
         }
         
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoNetserverDownloadCustomers:(NSString *)username
                                           accountnumber:(NSString *)accountNumber
                                                    name:(NSString *)name
                                                   phone:(NSString *)phone
                                                    city:(NSString *)city
                                                   state:(NSString *)state
                                                     zip:(NSString *)zip
                                                 billing:(BOOL)billing
                                                 success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverQueryCustomers * _Nonnull))success
                                                progress:(MSOProgressBlock)progress
                                                 failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_C001"
     mso_build_command:@[username,
                         billing ? @"0" : @"1",
                         accountNumber,
                         name,
                         phone,
                         city,
                         state,
                         zip,
                         @"Search Customer"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutCustomerSearchKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverQueryCustomers *mso_response =
         [MSOSDKResponseNetserverQueryCustomers
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

- (NSURLSessionDataTask *)_msoNetserverSaveCustomer:(NSString *)username
                                       customerName:(NSString *)customerName
                                        contactName:(NSString *)contactName
                                           address1:(NSString *)address1
                                           address2:(NSString *)address2
                                               city:(NSString *)city
                                              state:(NSString *)state
                                                zip:(NSString *)zip
                                            country:(NSString *)country
                                              phone:(NSString *)phone
                                                fax:(NSString *)fax
                                              email:(NSString *)email
                                              terms:(NSString *)terms
                                            success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSaveCustomer * _Nonnull))success
                                           progress:(MSOProgressBlock)progress
                                            failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_C005"
     mso_build_command:@[username,
                         @"New Customer",
                         @"", /* This is where account number would go, but since were in tradeshow mode, we dont set this becauase it would populate the PDA# */
                         terms,
                         customerName,
                         contactName,
                         address1,
                         address2,
                         city,
                         state,
                         zip,
                         country,
                         phone,
                         fax,
                         email,
                         @""]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSaveCustomer *mso_response =
         [MSOSDKResponseNetserverSaveCustomer
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
             return;
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoNetserverSaveCustomerShippingAddress:(NSString *)username
                                                     accountNumber:(NSString *)accountNumber
                                                   mainstoreNumber:(NSString *)mainstoreNumber
                                                      customerName:(NSString *)customerName
                                                       contactName:(NSString *)contactName
                                                          address1:(NSString *)address1
                                                          address2:(NSString *)address2
                                                              city:(NSString *)city
                                                             state:(NSString *)state
                                                               zip:(NSString *)zip
                                                           country:(NSString *)country
                                                             phone:(NSString *)phone
                                                               fax:(NSString *)fax
                                                             email:(NSString *)email
                                                             terms:(NSString *)terms
                                                           success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSaveCustomerShippingAddress * _Nonnull))success
                                                          progress:(MSOProgressBlock)progress
                                                           failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_C005"
     mso_build_command:@[username,
                         @"New Customer",
                         accountNumber,
                         terms,
                         customerName,
                         contactName,
                         address1,
                         address2,
                         city,
                         state,
                         zip,
                         country,
                         phone,
                         fax,
                         email,
                         mainstoreNumber
                         ]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSaveCustomerShippingAddress *mso_response =
         [MSOSDKResponseNetserverSaveCustomerShippingAddress
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
             return;
         }
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoNetserverUpdateCustomerAddress:(NSString *)username
                                                 companyName:(NSString *)companyName
                                               accountNumber:(NSString *)accountNumber
                                                        name:(NSString *)name
                                                 contactName:(NSString *)contactName
                                                    address1:(NSString *)address1
                                                    address2:(NSString *)address2
                                                        city:(NSString *)city
                                                       state:(NSString *)state
                                                         zip:(NSString *)zip
                                                     country:(NSString *)country
                                                       phone:(NSString *)phone
                                                         fax:(NSString *)fax
                                                       email:(NSString *)email
                                                       terms:(NSString *)terms
                                                         rep:(NSString *)rep
                                                    discount:(NSNumber *)discount
                                                  priceLevel:(NSNumber *)priceLevel
                                                     billing:(BOOL)billing
                                                     success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverUpdateCustomer * _Nonnull))success
                                                    progress:(MSOProgressBlock)progress
                                                     failure:(MSOFailureBlock)failure {
    
    NSMutableArray *components = [NSMutableArray arrayWithObject:@"CB3=1"];
    
    if (billing) {
        
        [components addObject:[NSString stringWithFormat:@"TB11=%@", zip]];
        [components addObject:[NSString stringWithFormat:@"TB12=%@", state]];
        [components addObject:[NSString stringWithFormat:@"TB13=%@", city]];
        [components addObject:[NSString stringWithFormat:@"TB14=%@", address1]];
        [components addObject:[NSString stringWithFormat:@"TB15=%@", name]];
        [components addObject:[NSString stringWithFormat:@"TB16=%@", fax]];
        [components addObject:[NSString stringWithFormat:@"TB17=%@", phone]];
        [components addObject:[NSString stringWithFormat:@"TB18=%@", email]];
        [components addObject:[NSString stringWithFormat:@"TB19=%@", contactName]];
        [components addObject:[NSString stringWithFormat:@"TB20=%@", address2]];
        [components addObject:[NSString stringWithFormat:@"TB21=%@", country]];
        
        [components addObject:[NSString stringWithFormat:@"TB33=%@", rep]];
        [components addObject:[NSString stringWithFormat:@"TB34=%@", terms]];
        [components addObject:[NSString stringWithFormat:@"TB38=%@", [discount stringValue]]];
        [components addObject:[NSString stringWithFormat:@"TB39=%@", [priceLevel stringValue]]];
        
    } else {
        
        [components addObject:[NSString stringWithFormat:@"TB22=%@", name]];
        [components addObject:[NSString stringWithFormat:@"TB23=%@", address2]];
        [components addObject:[NSString stringWithFormat:@"TB24=%@", address1]];
        [components addObject:[NSString stringWithFormat:@"TB25=%@", city]];
        [components addObject:[NSString stringWithFormat:@"TB26=%@", zip]];
        [components addObject:[NSString stringWithFormat:@"TB27=%@", state]];
        [components addObject:[NSString stringWithFormat:@"TB28=%@", fax]];
        [components addObject:[NSString stringWithFormat:@"TB29=%@", phone]];
        [components addObject:[NSString stringWithFormat:@"TB30=%@", email]];
        [components addObject:[NSString stringWithFormat:@"TB31=%@", country]];
        [components addObject:[NSString stringWithFormat:@"TB32=%@", contactName]];
        
    }
    
    NSString *com = [components componentsJoinedByString:@"{"];
    
    NSString *xml =
    [@"_C004"
     mso_build_command:@[username,
                         @"Update Customer Information",
                         companyName,
                         accountNumber,
                         com]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutCustomerSaveKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverUpdateCustomer *mso_response =
         [MSOSDKResponseNetserverUpdateCustomer
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

#pragma mark - Settings
- (NSURLSessionDataTask *)_msoNetserverDownloadAllSettings:(NSString *)username
                                                    nextId:(NSString *)nextId
                                                   success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncSettings * _Nullable))success
                                                  progress:(MSOProgressBlock)progress
                                                   failure:(MSOFailureBlock)failure
                                                   handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncSettings * _Nonnull, NSError **))handler {
    
    NSString *xml =
    [@"_S005"
     mso_build_command:@[username,
                         @"Group Settings?[iPad]",
                         nextId]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutSettingsSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverSyncSettings *mso_response =
         [MSOSDKResponseNetserverSyncSettings
          msosdk_commandWithResponseObject:responseObject
          error:&error];
         
         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (handler) {
             handler(response, mso_response, &error);
         }
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSString *nextIndex = mso_response.nextIndex;
         
         if (nextIndex.length > 0) {
             NSURLSessionDataTask *task =
             [self
              _msoNetserverDownloadAllSettings:username
              nextId:nextIndex
              success:success
              progress:progress
              failure:failure
              handler:handler];
             
             [task resume];
             return;
         }
         
         if (success) {
             if (handler) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, nil);
                 });
             } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, mso_response);
                 });
             }
             return;
         }
         
     } failure:failure];
    
    return task;
}

#pragma mark - Images
- (NSURLSessionDataTask *)_msoNetserverFetchAllImageReferences:(NSString *)username
                                                       success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverQueryImages * _Nonnull))success
                                                      progress:(MSOProgressBlock)progress
                                                       failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_S007"
     mso_build_command:@[username,
                         @"All Photo?[iPad]",
                         @""]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutAllImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverQueryImages *msosdk_command =
         [MSOSDKResponseNetserverQueryImages
          msosdk_commandWithResponseObject:responseObject
          error:&error];

         if (!msosdk_command) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, msosdk_command);
             });
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverDownloadProductImage:(NSString *)identifier
                                                    success:(void (^ _Nullable)(NSURLResponse * _Nonnull, UIImage * _Nonnull))success
                                                   progress:(MSOProgressBlock)progress
                                                    failure:(MSOFailureBlock)failure {

    NSString *xml =
    [[NSString stringWithFormat:@"<PHOTOALL>%@", identifier]
     mso_build_command:nil];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         NSData* data = [[NSData alloc] initWithBase64EncodedString:responseObject.command options:kNilOptions];
         UIImage *image = [UIImage imageWithData:data];
         if (!image) {
             
             if (failure) {
                 error = [NSError mso_internet_image_download_error:identifier];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     failure(response, error);
                 });
             }
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

- (void)_msoDownloadLastPurchasePrice:(MSOSuccessBlock)success progress:(MSOProgressBlock)progress failure:(MSOFailureBlock)failure {
    /*
     self.timeout = kiMRTimeoutProductsSyncKey;
     [self requestDataFromNetserver:@{@"str" : [@"_S006" mso_build_command:@[username,
     @"Last purchase price?"]]}
     success:^(NSURLResponse * _Nonnull response, id responseObject) {
     
     } progress:progress failure:^(NSURLResponse * _Nonnull response, NSError *error) {
     
     }];
     */
}

#pragma mark - Orders
- (NSURLSessionDataTask *)_msoNetserverRetrieveOrder:(NSString *)username
                                         orderNumber:(NSString *)orderNumber
                                             success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverQuerySalesOrder * _Nonnull))success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_O001"
     mso_build_command:@[username,
                         orderNumber,
                         @"Restore Submitted Order (check in-use)"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverQuerySalesOrder *mso_response =
         [MSOSDKResponseNetserverQuerySalesOrder
          msosdk_commandWithResponseObject:responseObject
          error:&error];

         if (!mso_response) {
             
             [NSError errorHandler:error response:response failure:failure];
             return;
             
         }
         
         if ([mso_response.objectCount integerValue] > 1) {
             
             NSURLSessionDataTask *task =
             [self
              _msoNetserverRetrieveExtendedOrder:username
              orderNumber:orderNumber
              mso_response:&mso_response
              success:success
              progress:progress
              failure:failure];
             
             [task resume];
             return;
             
         }
         
         NSString *formattedData = mso_response.data;
         NSArray *components = [formattedData componentsSeparatedByString:@"****Item Set Group****"];
         mso_response.data = [components mso_safeObjectAtIndex:0];
         mso_response.itemSet = [components mso_safeObjectAtIndex:1];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverRetrieveExtendedOrder:(NSString *)username
                                                 orderNumber:(NSString *)orderNumber
                                                mso_response:(MSOSDKResponseNetserverQuerySalesOrder **)mso_respons
                                                     success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverQuerySalesOrder * _Nonnull))success
                                                    progress:(MSOProgressBlock)progress
                                                     failure:(MSOFailureBlock)failure {
    
    __block MSOSDKResponseNetserverQuerySalesOrder *mso_response = *mso_respons;
    
    NSString *xml =
    [@"_X001"
     mso_build_command:@[username,
                         orderNumber,
                         @"Get More Order Data"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         [mso_response mso_appendResponseObject:responseObject];
         
         if ([mso_response.objectCount integerValue] > 1) {
             NSURLSessionDataTask *task =
             [self
              _msoNetserverRetrieveExtendedOrder:username
              orderNumber:orderNumber
              mso_response:&mso_response
              success:success
              progress:progress
              failure:failure];
             
             [task resume];
             return;
         }
         
         NSString *formattedData = mso_response.data;
         NSArray *components = [formattedData componentsSeparatedByString:@"****Item Set Group****"];
         mso_response.data = [components mso_safeObjectAtIndex:0];
         mso_response.itemSet = [components mso_safeObjectAtIndex:1];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverRetrieveOrders:(NSString *)username
                                         customerName:(NSString *)customerName
                                customerAccountNumber:(NSString *)customerAccountNumber
                                              success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverQueryCustomerSalesOrders * _Nonnull))success
                                             progress:(MSOProgressBlock)progress
                                              failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_E004"
     mso_build_command:@[username,
                         customerName,
                         customerAccountNumber,
                         @"Search Submitted Order"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutSalesOrderKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {
         
         MSOSDKResponseNetserverQueryCustomerSalesOrders *mso_response =
         [MSOSDKResponseNetserverQueryCustomerSalesOrders
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

#pragma mark Order Submission
- (NSURLSessionDataTask *)_msoNetserverSubmitImageNotes:(NSString *)username
                                            orderNumber:(NSString *)orderNumber
                                             imageNotes:(NSArray<NSString *> *)imageNotes
                                                success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSubmitSalesOrder * _Nonnull))success
                                               progress:(MSOProgressBlock)progress
                                                failure:(MSOFailureBlock)failure {
    
    if ([imageNotes count] == 0) {
        if (success) {
            MSOSDKResponseNetserverSubmitSalesOrder *mso_response =
            [MSOSDKResponseNetserverSubmitSalesOrder new];
            success([[NSURLResponse alloc] init], mso_response);
        }
        return nil;
    }
    
    return [self msoNetserverSubmitImageNotes:username orderNumber:orderNumber index:1 imageNotes:[imageNotes mutableCopy] success:success progress:progress failure:failure];
}

- (NSURLSessionDataTask *)msoNetserverSubmitImageNotes:(NSString *)username
                                           orderNumber:(NSString *)orderNumber
                                                 index:(NSUInteger)index
                                            imageNotes:(NSMutableArray<NSString *> *)imageNotes
                                               success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSubmitSalesOrder * _Nonnull))success
                                              progress:(MSOProgressBlock)progress
                                               failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_X003"
     mso_build_command:@[username,
                         orderNumber,
                         [NSString stringWithFormat:@"%lu", (unsigned long)index],
                         [NSString stringWithFormat:@"%lu", (unsigned long)[imageNotes count]],
                         @"Pre-Send Image Data",
                         [imageNotes firstObject]]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutSalesOrderKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSubmitSalesOrder *mso_response =
         [MSOSDKResponseNetserverSubmitSalesOrder
          msosdk_commandWithResponseObject:responseObject
          error:&error];

         if (!mso_response) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         [imageNotes removeObjectAtIndex:0];
         
         if ([imageNotes count] > 0) {
             
             NSURLSessionDataTask *task =
             [self
              msoNetserverSubmitImageNotes:username
              orderNumber:orderNumber
              index:index + 1
              imageNotes:[imageNotes mutableCopy]
              success:success
              progress:progress
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

- (NSURLSessionDataTask *)_msoNetserverSubmitOrder:(NSString *)username
                                       orderNumber:(NSString *)orderNumber
                                       orderString:(NSString *)orderString
                                            update:(BOOL)update
                                        imageNotes:(BOOL)imageNotes
                                           success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSubmitSalesOrder * _Nonnull))success
                                          progress:(MSOProgressBlock)progress
                                           failure:(MSOFailureBlock)failure {
    
    username = username ?: @"";
    orderNumber = orderNumber ?: @"New Order";
    orderString = orderString ?: @"";
    
    NSString *commandString = update ? @"Update Order" : @"Submit Order";
    NSString *commandInteger = update ? @"3" : @"";
    if (imageNotes) {
        commandString = [commandString stringByAppendingString:@" and Image Notes"];
    }
    
    if (update && !imageNotes) {
        commandString = @"Submit Order";
    }
    
    NSString *xml =
    [@"_O002"
     mso_build_command:@[username,
                         orderNumber,
                         commandInteger,
                         commandString,
                         orderString]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutSalesOrderKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSubmitSalesOrder *mso_response =
         [MSOSDKResponseNetserverSubmitSalesOrder
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

#pragma mark Order History
- (NSURLSessionDataTask *)_msoNetserverDownloadAllPurchaseHistory:(NSString *)username
                                                          success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncPurchaseHistory * _Nullable))success
                                                         progress:(MSOProgressBlock)progress
                                                          failure:(MSOFailureBlock)failure
                                                          handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncPurchaseHistory * _Nonnull, NSError **))handler {
    
    return [self
            msoDownloadPurchaseHistory:username
            customerName:@""
            customerZip:@""
            nextId:@""
            success:success
            progress:progress
            failure:failure
            handler:handler];
}

- (NSURLSessionDataTask *)_msoNetserverDownloadPurchaseHistory:(NSString *)username
                                                  customerName:(NSString *)customerName
                                                   customerZip:(NSString *)customerZip
                                                       success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncPurchaseHistory * _Nullable))success
                                                      progress:(MSOProgressBlock)progress
                                                       failure:(MSOFailureBlock)failure
                                                       handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncPurchaseHistory * _Nonnull, NSError **))handler {
    return [self
            msoDownloadPurchaseHistory:username
            customerName:customerName
            customerZip:customerZip
            nextId:@""
            success:success
            progress:progress
            failure:failure
            handler:handler];
}

- (NSURLSessionDataTask *)msoDownloadPurchaseHistory:(NSString *)username
                                        customerName:(NSString *)customerName
                                         customerZip:(NSString *)customerZip
                                              nextId:(NSString *)nextId
                                             success:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncPurchaseHistory * _Nullable))success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure
                                             handler:(void (^ _Nullable)(NSURLResponse * _Nonnull, MSOSDKResponseNetserverSyncPurchaseHistory * _Nonnull, NSError **))handler {
    
    NSString *xml =
    [@"_H001"
     mso_build_command:@[username,
                         customerName,
                         customerZip,
                         nextId,
                         @"Sales Order History"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSyncPurchaseHistory *mso_response =
         [MSOSDKResponseNetserverSyncPurchaseHistory
          msosdk_commandWithResponseObject:responseObject
          error:&error];

         if (!mso_response) {
             
             [NSError errorHandler:error response:response failure:failure];
             return;
             
         }
         
         if ([mso_response.detailLoop integerValue] != 1) {
             
             NSURLSessionDataTask *task =
             [self
              _msoDownloadPurchaseHistoryDetail:username
              customerName:customerName
              customerZip:customerZip
              mso_response:&mso_response
              success:success
              progress:progress
              failure:failure
              handler:handler];
             [task resume];
             
             return;
             
         }
         
         if (handler) {
             handler(response, mso_response, &error);
         }
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         
         if (mso_response.nextId.length > 0) {
             
             NSURLSessionDataTask *task =
             [self
              msoDownloadPurchaseHistory:username
              customerName:customerName
              customerZip:customerZip
              nextId:mso_response.nextId
              success:success
              progress:progress
              failure:failure
              handler:handler];
             [task resume];
             
             return;
         }
         
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, nil);
             });
         }
         
          
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoDownloadPurchaseHistoryDetail:(NSString *)username
                                               customerName:(NSString *)customerName
                                                customerZip:(NSString *)customerZip
                                               mso_response:(MSOSDKResponseNetserverSyncPurchaseHistory **)mso_respons
                                                    success:(MSOSuccessBlock)success
                                                   progress:(MSOProgressBlock)progress
                                                    failure:(MSOFailureBlock)failure
                                                    handler:(MSOHandlerBlock)handler {
    
    __block MSOSDKResponseNetserverSyncPurchaseHistory *mso_response = *mso_respons;
    
    NSString *xml =
    [@"_X001"
     mso_build_command:@[username,
                         [NSString stringWithFormat:@"%li", (long)mso_response.detailLoop],
                         @"Get More History Data"]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         [mso_response mso_appendResponseObject:responseObject];
         
         if ([mso_response.detailLoop integerValue] == 1) {
             
             if (handler) {
                 handler(response, mso_response, &error);
             }
             
             if (error) {
                 [NSError errorHandler:error response:response failure:failure];
                 return;
             }
             
             if (mso_response.nextId.length > 0) {

                 NSURLSessionDataTask *task =
                 [self
                  msoDownloadPurchaseHistory:username
                  customerName:customerName
                  customerZip:customerZip
                  nextId:mso_response.nextId
                  success:success
                  progress:progress
                  failure:failure
                  handler:handler];
                 
                 [task resume];

             } else {
                 
                 if (success) {
                     if (handler) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             success(response, nil);
                         });
                     } else {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             success(response, mso_response);
                         });
                     }
                 }
                 
             }
             
         } else {
             
             NSURLSessionDataTask *task =
             [self
              _msoDownloadPurchaseHistoryDetail:username
              customerName:customerName
              customerZip:customerZip
              mso_response:&mso_response
              success:success
              progress:progress
              failure:failure
              handler:handler];
             [task resume];
             
             return;
         }
         
         
     } failure:failure];
    
    return task;
    
}

- (NSURLSessionDataTask *)_msoNetserverUploadImage:(NSString *)username
                                base64EncodedImage:(NSString *)base64EncodedImage
                                        identifier:(NSString *)identifier
                                           success:(MSOSuccessBlock)success
                                          progress:(MSOProgressBlock)progress
                                           failure:(MSOFailureBlock)failure {
    
    NSString *xml =
    [@"_P011"
     mso_build_command:@[username,
                         identifier,
                         @"Submit Product Photo",
                         base64EncodedImage]];
    
    MSOSoapParameter *parameter =
    [MSOSoapParameter
     parameterWithObject:xml
     forKey:@"str"];
    
    NSURLRequest *request =
    [MSOSDK
     urlRequestWithParameters:@[parameter]
     type:mso_soap_function_doWork
     url:self.serviceUrl
     netserver:YES
     timeout:kMSOTimeoutImageUploadSyncKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskForNetserverWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error) {

         MSOSDKResponseNetserverSaveImage *mso_response =
         [MSOSDKResponseNetserverSaveImage
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


@end
