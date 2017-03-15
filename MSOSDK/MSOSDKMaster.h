//
//  MSOSDKMaster.h
//  iMobileRep
//
//  Created by John Setting on 6/27/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "MSOSDKConstants.h"
#import "GRRequestsManager.h"

#import "NSString+MSOSDKAdditions.h"
#import "NSError+MSOSDKAdditions.h"
#import "NSURLRequest+MSOSDKAdditions.h"

@interface MSOSoapParameter : NSObject

+ (nullable instancetype)parameterWithObject:(nullable id)object forKey:(nonnull NSString *)key;
- (nonnull NSString *)xml;

@end

/**
 `MSOSDK` adopts `NSObject` and is the master object for all Logiciel web operations
 */
@interface MSOSDK : NSObject

/**
 A `GRRequestsManager` object that is used for fetching all file listings within an FTP directory for fetching all photo image references.
 */
@property (strong, nonatomic, nullable, readwrite) GRRequestsManager *requestsManager;


/**
 A shared `AFHTTPSessionManager` object that handles all requests
 */
@property (strong, nonatomic, nullable, readonly) AFHTTPSessionManager *operation;

/**
 The Netserver `NSURL` object that is used for all Netserver requests.
 */
@property (strong, nonatomic, nonnull, readonly) NSURL *serviceUrl;


/**
 Returns an `MSOSDK` object that uses the same `AFHTTPSessionManager` across all requests. This object is instantiated once and only once

 @return an `MSOSDK` object
 */
+ (nullable instancetype)sharedSession;

/**
 Sets the NetserverIPAddress, deviceName, deviceIpAddress and EventId to validate requests made to Netserver. This method must be called before signaling the first call using MSOSDK networking methods

 @param msoNetserverIpAddress The Netserver IP Address set for interacting with Netserver on the host computer.
 @param msoDeviceName The Device Name of the iPad for interacting with Netserver on the host computer.
 @param msoDeviceIpAddress The Device IP Address of the iPad for interacting with Netserver on the host computer.
 @param msoEventId The Event ID the current rep is assigned to for interacting with Netserver on the host computer.
 */
+ (void)setMSONetserverIpAddress:(nullable NSString *)msoNetserverIpAddress
                   msoDeviceName:(nullable NSString *)msoDeviceName
              msoDeviceIpAddress:(nullable NSString *)msoDeviceIpAddress
                      msoEventId:(nullable NSString *)msoEventId;


+ (nonnull NSString *)sanatizeData:(nonnull NSData *)responseObject;
+ (nonnull NSString *)sanatizeImageData:(nonnull NSData *)responseObject;
+ (nonnull NSURL *)logicielCustomerURL;
+ (nonnull NSURL *)logicielFTPServiceURL;

+ (nonnull NSDateFormatter *)longDateFormatter;
+ (nonnull NSDateFormatter *)mediumDateFormatter;

+ (nullable NSString *)stringFromDate:(nullable NSDate *)date;
+ (nullable NSDate *)dateFromString:(nullable NSString *)date;

+ (BOOL)validate:(nullable NSString *)data
         command:(nullable NSString *)command
          status:(nullable NSString *)status
           error:(NSError * __autoreleasing _Nullable * _Nullable)error;

+ (BOOL)validateCredentials:(nullable NSString *)data
                    command:(nullable NSString *)command
                     status:(nullable NSString *)status
                      error:(NSError * __autoreleasing _Nullable * _Nullable)error;

+ (BOOL)validateResults:(nullable NSString *)data
                command:(nullable NSString *)command
                 status:(nullable NSString *)status
                  error:(NSError * __autoreleasing _Nullable * _Nullable)error;

+ (nonnull NSString *)kMSOProductSearchType:(kMSOProductSearchType)type;

+ (nonnull NSURLRequest *)urlRequestImage:(nullable NSURL *)url
                                  timeout:(NSTimeInterval)timeout
                                    error:(NSError * __autoreleasing _Nullable * _Nullable)error;

+ (nullable NSURLRequest *)urlRequestWithParameters:(nullable NSArray <MSOSoapParameter *> *)parameters
                                               type:(nullable NSString *)type
                                                url:(nullable NSURL *)url
                                          netserver:(BOOL)netserver
                                            timeout:(NSTimeInterval)timeout;

- (void)errorHandler:(nullable NSError *)error
            response:(nullable NSURLResponse *)response
             failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)dataTaskWithRequest:(nonnull NSURLRequest *)request
                                             progress:(_Nullable MSOProgressBlock)progress
                                           completion:(void (^_Nullable)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))completion;


@end
