//
//  MSOSDKMaster.h
//  iMobileRep
//
//  Created by John Setting on 6/27/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <SMXMLDocument/SMXMLDocument.h>

#import "MSOSDK.h"

#import "MSOSDKConstants.h"
#import "GRRequestsManager.h"

#import "NSString+MSOSDKAdditions.h"
#import "NSError+MSOSDKAdditions.h"
#import "NSURLRequest+MSOSDKAdditions.h"

/**
 enums that define a product search type. This is only applied to Netserver Product Requests

 - kMSOProductSearchTypeItemNumber: Search By Item #
 - kMSOProductSearchTypeDescription: Search By Description
 - kMSOProductSearchTypeColor: Search By Color
 - kMSOProductSearchTypeSize: Search By Size
 - kMSOProductSearchTypeProductInfo: Search By Product Info (product line | category | season) for all companies
 - kMSOProductSearchTypeUserDefined: Search By User Defined Fields, (e.g N| = new item, S| = special item, H| hot item)
 */
typedef NS_ENUM(NSInteger, kMSOProductSearchType) {
    kMSOProductSearchTypeItemNumber = 0,
    kMSOProductSearchTypeDescription = 1,
    kMSOProductSearchTypeColor = 2,
    kMSOProductSearchTypeSize = 3,
    kMSOProductSearchTypeProductInfo = 4,
    kMSOProductSearchTypeUserDefined = 5,
};


/**
 A progress block used within blocks to signal progression of a methods action

 @param progress An NSProgress object
 */
typedef void (^ MSOProgressBlock)(NSProgress * _Nonnull progress);


/**
 A success block used to signal a method has successfully finished with no errors

 @param response The URLResponse of the block
 @param responseObject A nullable object. It will only be null if there is a handler within the block to process that data
 */
typedef void (^ MSOSuccessBlock)(NSURLResponse * _Nonnull response, id _Nullable responseObject);

/**
 A failure block used to signal a method has failed with an error

 @param response The URLResponse of the block
 @param error A nonnull error object
 */
typedef void (^ MSOFailureBlock)(NSURLResponse * _Nonnull response, NSError * _Nonnull error);

typedef void (^ MSONetserverSyncBlock)
(NSURLResponse * _Nonnull response,
__kindof MSOSDKResponseNetserverSync * _Nonnull responseObject,
NSError * __autoreleasing _Nullable * _Nullable error);

typedef void (^ MSONetserverQueryBlock)
(NSURLResponse * _Nonnull response,
__kindof MSOSDKResponseNetserverQuery * _Nonnull responseObject,
NSError * __autoreleasing _Nullable * _Nullable error);

typedef void (^ MSONetserverImageBlock)
(NSURLResponse * _Nonnull response,
NSString * _Nonnull responseObject,
NSError * __autoreleasing _Nullable * _Nullable error);

static NSStringEncoding stringEncoding = NSUTF8StringEncoding;

static NSString * _Nonnull const DoWork = @"IServiceLibrary/DoWork";

static NSString * _Nonnull const iRegisterCode = @"iRegisterCode";
static NSString * _Nonnull const _UploadFile = @"_UploadFile";
static NSString * _Nonnull const _UpdateUploadInfo = @"_UpdateUploadInfo";
static NSString * _Nonnull const iRegisterShortKey = @"iRegisterShortKey";
static NSString * _Nonnull const iCheckMobileDevice = @"iCheckMobileDevice";
static NSString * _Nonnull const iCheckMobileUser = @"iCheckMobileUser";
static NSString * _Nonnull const iCheckPDAMessage = @"_iCheckPDAMessage";
static NSString * _Nonnull const _CheckCatalogFileStatus = @"_CheckCatalogFileStatus";
static NSString * _Nonnull const GetCustomersByCompany = @"GetCustomersByCompany";
static NSString * _Nonnull const _iCheckPDAHistoryForDownloading = @"_iCheckPDAHistoryForDownloading";
static NSString * _Nonnull const _UpdateDownloadInfo = @"_UpdateDownloadInfo";
static NSString * _Nonnull const _iCheckMobileMessage = @"_iCheckMobileMessage";
static NSString * _Nonnull const _iCheckMobileFileForDownloading = @"_iCheckMobileFileForDownloading";
static NSString * _Nonnull const GetEventList = @"GetEventList";

#pragma mark - Endpoints
static NSString * _Nonnull const LogicielIncUrl = @"http://logicielinc.com";
static NSString * _Nonnull const LogicielUrl = @"http://logiciel.com";
static NSString * _Nonnull const logicielUpdateEndpoint = @"logicielupdatews";
static NSString * _Nonnull const logicielCustomerASMX = @"logicielcustomer.asmx";
static NSString * _Nonnull const logicielFTPWSEndpoint = @"logiciel_ftp_ws";
static NSString * _Nonnull const logicielFTPServiceASMX = @"FTPService.asmx";
static NSString * _Nonnull const _mso_password = @"logic99";

#pragma mark - Static Commands
static NSString * _Nonnull const _msoNetserverPingCommand = @"<*!BEGIN!*><~~>_S001^^WLAN Connection?<*!END!*>";
static NSString * _Nonnull const _msoNetserverLogoutCommand = @"<*!BEGIN!*><~~><*!END!*>";

static NSString * _Nonnull const _msoNetserverBeginEscapedCommand = @"&amp;lt;*!BEGIN!*&amp;gt;";
static NSString * _Nonnull const _msoNetserverEndEscapedCommand = @"&amp;lt;*!END!*&amp;gt;";

@interface MSOSDK : NSObject
@property (strong, nonatomic, nullable, readwrite) GRRequestsManager *requestsManager;
@property (strong, nonatomic, nullable, readonly) AFHTTPSessionManager *operation;
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

+ (nonnull NSURLRequest *)urlRequestWithParameters:(nullable NSDictionary *)parameters
                                              keys:(nullable NSArray *)keys
                                              type:(nullable NSString *)type
                                               url:(nullable NSURL *)url
                                         netserver:(BOOL)netserver
                                           timeout:(NSTimeInterval)timeout
                                             error:(NSError * __autoreleasing _Nullable * _Nullable)error;

- (void)errorHandler:(nullable NSError *)error
            response:(nullable NSURLResponse *)response
             failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)dataTaskWithRequest:(nonnull NSURLRequest *)request
                                             progress:(_Nullable MSOProgressBlock)progress
                                           completion:(void (^_Nullable)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))completion;


@end
