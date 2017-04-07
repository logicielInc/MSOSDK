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

#import "MSOSDKResponseNetserver.h"
#import "MSOSDKResponseWebserver.h"

#import "NSString+MSOSDKAdditions.h"
#import "NSError+MSOSDKAdditions.h"
#import "NSURLRequest+MSOSDKAdditions.h"
#import "NSDateFormatter+MSOSDKAdditions.h"
#import "NSURL+MSOSDKAdditions.h"
#import "NSData+MSOSDKAdditions.h"

@class MSOSoapParameter;

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

+ (nullable NSString *)_msoNetserverIpAddress;
+ (nullable NSString *)_msoDeviceName;
+ (nullable NSString *)_msoDeviceIpAddress;
+ (nullable NSString *)_msoEventId;
+ (nullable NSString *)_msoPassword;

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
                      msoEventId:(nullable NSString *)msoEventId
                     msoPassword:(nullable NSString *)msoPassword;

/**
 Sets the NetserverIPAddress, deviceName, deviceIpAddress and EventId to validate requests made to Netserver. This method must be called before signaling the first call using MSOSDK networking methods
 
 @param msoNetserverIpAddress The Netserver IP Address set for interacting with Netserver on the host computer.
 @param msoDeviceName The Device Name of the iPad for interacting with Netserver on the host computer.
 @param msoDeviceIpAddress The Device IP Address of the iPad for interacting with Netserver on the host computer.
 @param msoEventId The Event ID the current rep is assigned to for interacting with Netserver on the host computer.
 @param authUsername The Event ID the current rep is assigned to for interacting with Netserver on the host computer.
 @param authPassword The Event ID the current rep is assigned to for interacting with Netserver on the host computer.
 */
+ (void)setMSONetserverIpAddress:(nullable NSString *)msoNetserverIpAddress
                   msoDeviceName:(nullable NSString *)msoDeviceName
              msoDeviceIpAddress:(nullable NSString *)msoDeviceIpAddress
                      msoEventId:(nullable NSString *)msoEventId
                     msoPassword:(nullable NSString *)msoPassword
                    authUsername:(nullable NSString *)authUsername
                    authPassword:(nullable NSString *)authPassword;


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

+ (nonnull NSURLRequest *)urlRequestImage:(nullable NSURL *)url
                                  timeout:(NSTimeInterval)timeout
                                    error:(NSError * __autoreleasing _Nullable * _Nullable)error;

+ (nullable NSURLRequest *)urlRequestWithParameters:(nullable NSArray <MSOSoapParameter *> *)parameters
                                               type:(nullable NSString *)type
                                                url:(nullable NSURL *)url
                                          netserver:(BOOL)netserver
                                            timeout:(NSTimeInterval)timeout;

- (nonnull NSURLSessionDataTask *)dataTaskForNetserverWithRequest:(nonnull NSURLRequest *)request
                                                         progress:(_Nullable MSOProgressBlock)progress
                                                          success:(void (^_Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserver * _Nullable responseObject, NSError * _Nullable error))success
                                                          failure:(void (^_Nullable)(NSURLResponse * _Nonnull response, NSError * _Nonnull error))failure;


- (nonnull NSURLSessionDataTask *)dataTaskForWebserverWithRequest:(nonnull NSURLRequest *)request
                                                         progress:(_Nullable MSOProgressBlock)progress
                                                          success:(void (^_Nullable)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))success
                                                          failure:(void (^_Nullable)(NSURLResponse * _Nonnull response, NSError * _Nonnull error))failure;


+ (nullable NSURLRequest *)mso_imageRequestNetserver:(nullable NSString *)ipAddress filename:(nullable NSString *)filename;

@end

/**
 `MSOSoapParameter` is a subclass of NSObject and is used to format an `NSURLRequest` body parameters
 */
@interface MSOSoapParameter : NSObject

/**
 The object to be formatted for the XML `NSURLRequest`
 */
@property (strong, nonatomic, nullable, readonly) id object;

/**
 The identifier to be formatted for the XML `NSURLRequest`
 */
@property (strong, nonatomic, nullable, readonly) NSString *key;

/**
 Generates an `MSOSoapParameter` object that is used to generate a Soap Request
 
 @param object The value of the parameter
 @param key The identifier of the parameter
 @return `MSOSoapParameter
 */
+ (nullable instancetype)parameterWithObject:(nullable id)object forKey:(nonnull NSString *)key;

/**
 Generates an `NSString` object that is formatted for XML requests.
 
 @return An `NSString` object
 */
- (nonnull NSString *)xml;

@end
