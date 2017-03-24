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
- (NSURLSessionDataTask *)_msoNetserverPing:(MSOSuccessBlock)success
                                    failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_S001" mso_build_command:@[@"",
                                                                                                      @"WLAN Connection?"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutPingKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         NSArray *commandArray = [command componentsSeparatedByString:@"^"];
         command = nil;
         MSOSDKResponseNetserverPing *msosdk_command = [MSOSDKResponseNetserverPing msosdk_commandWithResponse:commandArray];
         commandArray = nil;
         
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
                                     success:(MSOSuccessBlock)success
                                     failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_U001" mso_build_command:@[@"",
                                                                                                      username,
                                                                                                      password]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         NSArray *commandArray = [command componentsSeparatedByString:@"^"];
         command = nil;
         MSOSDKResponseNetserverLogin *msosdk_command = [MSOSDKResponseNetserverLogin msosdk_commandWithResponse:commandArray];
         commandArray = nil;
         
         BOOL validate = [MSOSDK validate:msosdk_command.response
                                  command:msosdk_command.command
                                   status:msosdk_command.status error:&error];
         if (!validate) {
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
                                                    success:(MSOSuccessBlock)success
                                                    failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_S002" mso_build_command:@[username,
                                                                                                      @"Initial iPad Settings?"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         NSArray *commandArray = [command componentsSeparatedByString:@"^"];
         command = nil;
         MSOSDKResponseNetserverSettings *msosdk_command = [MSOSDKResponseNetserverSettings msosdk_commandWithResponse:commandArray];
         commandArray = nil;
         
         BOOL validate = [MSOSDK validate:msosdk_command.response
                                  command:msosdk_command.command
                                   status:msosdk_command.status error:&error];
         if (!validate) {
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
- (NSURLSessionDataTask *)_msoNetserverLogout:(MSOSuccessBlock)success
                                      failure:(MSOFailureBlock)failure {
    
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"" mso_build_command:nil]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutLoginKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                  
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, nil);
             });
         }
         
     } failure:failure];
    
    return task;
}

#pragma mark - Products
- (NSURLSessionDataTask *)_msoNetserverFetchItemList:(NSString *)username
                                           companyId:(NSString *)companyId
                                            itemList:(NSArray<NSString *> *)itemList
                                             success:(MSOSuccessBlock)success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure
                                             handler:(MSOHandlerBlock)handler {
 
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_P005" mso_build_command:@[username,
                                                                                                      companyId,
                                                                                                      @"Item List",
                                                                                                      [itemList componentsJoinedByString:@"^"]]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutProductsSyncKey];

    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *components = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverQueryProducts *mso_response = [MSOSDKResponseNetserverQueryProducts msosdk_commandWithResponse:components];

         if (handler) {
             handler(response, mso_response, &error);
         }
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
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
         }
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverDownloadNumberOfProducts:(NSString *)username
                                                        success:(MSOSuccessBlock)success
                                                       progress:(MSOProgressBlock)progress
                                                        failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_S004" mso_build_command:@[username,
                                                                                                      @"Product Total?",
                                                                                                      @""]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *components = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverProductsCount *mso_response = [MSOSDKResponseNetserverProductsCount msosdk_commandWithResponse:components];
         validate = [MSOSDK validate:mso_response.status command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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

- (NSURLSessionDataTask *)_msoNetserverDownloadAllProducts:(NSString *)username
                                                    nextId:(NSString *)nextId
                                                 companyId:(NSString *)companyId
                                                   success:(MSOSuccessBlock)success
                                                  progress:(MSOProgressBlock)progress
                                                   failure:(MSOFailureBlock)failure
                                                   handler:(MSOHandlerBlock)handler {
    
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
                                                   success:(MSOSuccessBlock)success
                                                   failure:(MSOFailureBlock)failure
                                                   handler:(MSOHandlerBlock)handler {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_S004" mso_build_command:@[username,
                                                                                                      @"Product List?[iPad]",
                                                                                                      companyId,
                                                                                                      nextId]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverSyncProducts *mso_response = [MSOSDKResponseNetserverSyncProducts msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
         
         
         commandParameters = nil;
         command = nil;
         
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
    
    NSString *type = [NSString mso_product_search_type_formatted:searchType];
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_P002" mso_build_command:@[username,
                                                                                                      searchTerm,
                                                                                                      companyId,
                                                                                                      @"0",
                                                                                                      type]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverQueryProducts *mso_response = [MSOSDKResponseNetserverQueryProducts msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[mso_response.command mso_build_command:@[username,
                                                                                                                  mso_response.pages]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutProductsSyncKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         [mso_response appendResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                                         success:(MSOSuccessBlock)success
                                                        progress:(MSOProgressBlock)progress
                                                         failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_C006" mso_build_command:@[username,
                                                                                                      @"Auto-Mapping",
                                                                                                      mappingScheme]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutCustomersSyncKey];

    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:@"_C006" status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }

         if (success) {
             success(response, nil);
         }
         
         
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverUpdateCustomerMappingScheme:(NSString *)username
                                                     mappingScheme:(NSString *)mappingScheme
                                                 mappingSchemeData:(NSString *)mappingSchemeData
                                                           success:(MSOSuccessBlock)success
                                                          progress:(MSOProgressBlock)progress
                                                           failure:(MSOFailureBlock)failure {

    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_C007" mso_build_command:@[username,
                                                                                                      @"Save-Mapping",
                                                                                                      mappingScheme,
                                                                                                      mappingSchemeData]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutCustomersSyncKey];

    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:@"_C007" status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }

         if (success) {
             success(response, nil);
         }
         
     } failure:failure];

    return task;
}

- (NSURLSessionDataTask *)_msoNetserverDownloadAllCustomers:(NSString *)username
                                                     nextId:(NSString *)nextId
                                                    success:(MSOSuccessBlock)success
                                                   progress:(MSOProgressBlock)progress
                                                    failure:(MSOFailureBlock)failure
                                                    handler:(MSOHandlerBlock)handler {
    
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_S003" mso_build_command:@[username,
                                                                                                      @"Customer List?[iPad]",
                                                                                                      nextId]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutCustomersSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *parameters = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverSyncCustomers *mso_response = [MSOSDKResponseNetserverSyncCustomers msosdk_commandWithResponse:parameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
         
         command = nil;
         
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
                                                 success:(MSOSuccessBlock)success
                                                progress:(MSOProgressBlock)progress
                                                 failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_C001" mso_build_command:@[username,
                                                                                                      billing ? @"0" : @"1",
                                                                                                      accountNumber,
                                                                                                      name,
                                                                                                      phone,
                                                                                                      city,
                                                                                                      state,
                                                                                                      zip,
                                                                                                      @"Search Customer"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutCustomerSearchKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *parameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverQueryCustomers *mso_response = [MSOSDKResponseNetserverQueryCustomers msosdk_commandWithResponse:parameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                            success:(MSOSuccessBlock)success
                                           progress:(MSOProgressBlock)progress
                                            failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_C005" mso_build_command:@[username,
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
                                                                                                      @""]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *parameters = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverSaveCustomer *mso_response = [MSOSDKResponseNetserverSaveCustomer msosdk_commandWithResponse:parameters];
         validate = [MSOSDK validate:mso_response.status command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                                           success:(MSOSuccessBlock)success
                                                          progress:(MSOProgressBlock)progress
                                                           failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_C005" mso_build_command:@[username,
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
                                                                                                      ]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *parameters = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverSaveCustomerShippingAddress *mso_response = [MSOSDKResponseNetserverSaveCustomerShippingAddress msosdk_commandWithResponse:parameters];
         validate = [MSOSDK validate:mso_response.status command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                                     success:(MSOSuccessBlock)success
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
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_C004" mso_build_command:@[username,
                                                                                                      @"Update Customer Information",
                                                                                                      companyName,
                                                                                                      accountNumber,
                                                                                                      com]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutCustomerSaveKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverUpdateCustomer *mso_response = [MSOSDKResponseNetserverUpdateCustomer msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.message command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                                   success:(MSOSuccessBlock)success
                                                  progress:(MSOProgressBlock)progress
                                                   failure:(MSOFailureBlock)failure
                                                   handler:(MSOHandlerBlock)handler {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_S005" mso_build_command:@[username,
                                                                                                      @"Group Settings?[iPad]",
                                                                                                      nextId]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutSettingsSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverSyncSettings *mso_response = [MSOSDKResponseNetserverSyncSettings msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
         
         commandParameters = nil;
         command = nil;
         
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
                                                       success:(MSOSuccessBlock)success
                                                      progress:(MSOProgressBlock)progress
                                                       failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_S007" mso_build_command:@[username,
                                                                                                      @"All Photo?[iPad]",
                                                                                                      @""]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutAllImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverQueryImages *mso_response = [MSOSDKResponseNetserverQueryImages msosdk_commandWithResponse:commandParameters];
         
         if (success) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 success(response, mso_response);
             });
         }
     } failure:failure];
    
    return task;
}

- (NSURLSessionDataTask *)_msoNetserverDownloadProductImage:(NSString *)identifier
                                                    success:(MSOSuccessBlock)success
                                                   progress:(MSOProgressBlock)progress
                                                    failure:(MSOFailureBlock)failure
                                                    handler:(MSOHandlerBlock)handler {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[[NSString stringWithFormat:@"<PHOTOALL>%@", identifier] mso_build_command:nil]
                                                                 forKey:@"str"];
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutImageSyncKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeImageData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (handler) {
             handler(response, command, &error);
         }
         
         if (error) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         if (success) {
             
             if (handler) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, nil);
                 });
             } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(response, command);
                 });
             }
             
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
                                             success:(MSOSuccessBlock)success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_O001" mso_build_command:@[username,
                                                                                                      orderNumber,
                                                                                                      @"Restore Submitted Order (check in-use)"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverQuerySalesOrder *mso_response = [MSOSDKResponseNetserverQuerySalesOrder msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                                     success:(MSOSuccessBlock)success
                                                    progress:(MSOProgressBlock)progress
                                                     failure:(MSOFailureBlock)failure {
    
    __block MSOSDKResponseNetserverQuerySalesOrder *mso_response = *mso_respons;
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_X001" mso_build_command:@[username,
                                                                                                      orderNumber,
                                                                                                      @"Get More Order Data"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         [mso_response mso_appendResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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

- (NSURLSessionDataTask *)_msoNetserverRetrieveOrders:(NSString *)username
                                         customerName:(NSString *)customerName
                                customerAccountNumber:(NSString *)customerAccountNumber
                                              success:(MSOSuccessBlock)success
                                             progress:(MSOProgressBlock)progress
                                              failure:(MSOFailureBlock)failure {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_E004" mso_build_command:@[username,
                                                                                                      customerName,
                                                                                                      customerAccountNumber,
                                                                                                      @"Search Submitted Order"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutSalesOrderKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverQueryCustomerSalesOrders *mso_response = [MSOSDKResponseNetserverQueryCustomerSalesOrders msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.data command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                                success:(MSOSuccessBlock)success
                                               progress:(MSOProgressBlock)progress
                                                failure:(MSOFailureBlock)failure {
    
    if ([imageNotes count] == 0) {
        if (success) {
            MSOSDKResponseNetserverSubmitSalesOrder *mso_response = [MSOSDKResponseNetserverSubmitSalesOrder msosdk_commandWithResponse:@[@"_X003", @"OK"]];
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
                                               success:(MSOSuccessBlock)success
                                              progress:(MSOProgressBlock)progress
                                               failure:(MSOFailureBlock)failure {
    
    NSError *error = nil;
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_X003" mso_build_command:@[username,
                                                                                                      orderNumber,
                                                                                                      [NSString stringWithFormat:@"%lu", (unsigned long)index],
                                                                                                      [NSString stringWithFormat:@"%lu", (unsigned long)[imageNotes count]],
                                                                                                      @"Pre-Send Image Data",
                                                                                                      [imageNotes firstObject]]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutSalesOrderKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverSubmitSalesOrder *mso_response = [MSOSDKResponseNetserverSubmitSalesOrder msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.status command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                           success:(MSOSuccessBlock)success
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
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_O002" mso_build_command:@[username,
                                                                                                      orderNumber,
                                                                                                      commandInteger,
                                                                                                      commandString,
                                                                                                      orderString]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutSalesOrderKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:@"_O002" status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverSubmitSalesOrder *mso_response = [MSOSDKResponseNetserverSubmitSalesOrder msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.status command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
                                                          success:(MSOSuccessBlock)success
                                                         progress:(MSOProgressBlock)progress
                                                          failure:(MSOFailureBlock)failure
                                                          handler:(MSOHandlerBlock)handler {
    
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
                                                       success:(MSOSuccessBlock)success
                                                      progress:(MSOProgressBlock)progress
                                                       failure:(MSOFailureBlock)failure
                                                       handler:(MSOHandlerBlock)handler {
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
                                             success:(MSOSuccessBlock)success
                                            progress:(MSOProgressBlock)progress
                                             failure:(MSOFailureBlock)failure
                                             handler:(MSOHandlerBlock)handler {
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_H001" mso_build_command:@[username,
                                                                                                      customerName,
                                                                                                      customerZip,
                                                                                                      nextId,
                                                                                                      @"Sales Order History"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         MSOSDKResponseNetserverSyncPurchaseHistory *mso_response = [MSOSDKResponseNetserverSyncPurchaseHistory msosdk_commandWithResponse:commandParameters];
         
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
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_X001" mso_build_command:@[username,
                                                                                                      [NSString stringWithFormat:@"%li", (long)mso_response.detailLoop],
                                                                                                      @"Get More History Data"]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutPurchaseHistoryKey];
    
    NSURLSessionDataTask *task =
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         [mso_response appendCommand:commandParameters];
         
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
    
    
    MSOSoapParameter *parameter = [MSOSoapParameter parameterWithObject:[@"_P011" mso_build_command:@[username,
                                                                                                      identifier,
                                                                                                      @"Submit Product Photo",
                                                                                                      base64EncodedImage]]
                                                                 forKey:@"str"];
    
    NSURLRequest *request = [MSOSDK
                             urlRequestWithParameters:@[parameter]
                             type:mso_soap_function_doWork
                             url:self.serviceUrl
                             netserver:YES
                             timeout:kMSOTimeoutImageUploadSyncKey];
    
    NSURLSessionDataTask *task =
    
    [self
     dataTaskWithRequest:request
     progress:progress
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         NSString *command = [MSOSDK sanatizeData:responseObject];
         
         BOOL validate = [MSOSDK validate:command command:nil status:nil error:&error];
         if (!validate) {
             [NSError errorHandler:error response:response failure:failure];
             return;
         }
         
         NSArray *commandParameters = [command componentsSeparatedByString:@"^"];
         
         MSOSDKResponseNetserverSaveImage *mso_response = [MSOSDKResponseNetserverSaveImage msosdk_commandWithResponse:commandParameters];
         validate = [MSOSDK validate:mso_response.message command:mso_response.command status:mso_response.status error:&error];
         if (!validate) {
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
