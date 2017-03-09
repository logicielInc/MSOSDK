//
//  MSOSDK.h
//  iMobileRep
//
//  Created by John Setting on 6/27/16.
//  Copyright © 2016 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <SMXMLDocument/SMXMLDocument.h>

#import "MSOSDKResponseNetserver.h"
#import "MSOSDKResponseWebService.h"

#import "GRRequestsManager.h"

#import "MSOSDKConstants.h"

#import "NSString+MSOSDKAdditions.h"
#import "NSError+MSOSDKAdditions.h"
#import "NSURLRequest+MSOSDKAdditions.h"

/**
 case 0: //search by item#
 case 1: //search by description
 case 2: //search by color
 case 3: //search by size
 case 4: //search by product_info: product line|category|season                  //for all companies
 case 5: //search for N|S|H| in all 5 user defined fields;    N| for new item, S| for special item,  H| for hot sale item,
 */
typedef NS_ENUM(NSInteger, kMSOProductSearchType) {
    kMSOProductSearchTypeItemNumber = 0,
    kMSOProductSearchTypeDescription = 1,
    kMSOProductSearchTypeColor = 2,
    kMSOProductSearchTypeSize = 3,
    kMSOProductSearchTypeProductInfo = 4,
    kMSOProductSearchTypeUserDefined = 5,
};

typedef void (^ MSOProgressBlock)(NSProgress * _Nonnull progress);
typedef void (^ MSOSuccessBlock)(NSURLResponse * _Nonnull response, id _Nullable responseObject);
typedef void (^ MSOFailureBlock)(NSURLResponse * _Nonnull response, NSError * _Nullable error);

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
@property (strong, nonatomic, nullable, readwrite) NSMutableDictionary *infoDictionary;
@property (strong, nonatomic, nullable, readwrite) NSMutableString *tempPurchaseHistoryXML;
@property (strong, nonatomic, nullable, readwrite) NSMutableString *productsString;

+ (nullable instancetype)sharedSession;

/**
 Sets the NetserverIPAddress, deviceName, deviceIpAddress and EventId to validate requests made to Netserver.
 @param msoNetserverIPAddress The Netserver IP Address set for interacting with Netserver on the host computer.
 @param msoDeviceName The Device Name of the iPad for interacting with Netserver on the host computer.
 @param msoDeviceIpAddress The Device IP Address of the iPad for interacting with Netserver on the host computer.
 @param msoEventId The Event ID the current rep is assigned to for interacting with Netserver on the host computer.
 */
+ (void)setMSONetserverIPAddress:(nullable NSString *)msoNetserverIPAddress
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

+ (nullable NSString *)buildRequestFromDictionary:(nullable NSDictionary *)dict
                                       sortedKeys:(nullable NSArray *)sortedKeys
                                             type:(nullable NSString *)type
                                 netserverRequest:(BOOL)netserverRequest;

- (nonnull NSURLSessionDataTask *)dataTaskWithRequest:(nonnull NSURLRequest *)request
                                             progress:(_Nullable MSOProgressBlock)progress
                                           completion:(void (^_Nullable)(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error))completion;


@end
