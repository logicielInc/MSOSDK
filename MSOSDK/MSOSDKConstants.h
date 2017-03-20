//
//  MSOSDKConstants.h
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const kMSOTimeoutDefaultKey;

extern NSInteger const kMSOTimeoutAllImageSyncKey;
extern NSInteger const kMSOTimeoutCatalogKey;
extern NSInteger const kMSOTimeoutCustomerSaveKey;
extern NSInteger const kMSOTimeoutCustomersSyncKey;
extern NSInteger const kMSOTimeoutCustomerSearchKey;
extern NSInteger const kMSOTimeoutDataRequestKey;
extern NSInteger const kMSOTimeoutForgotPassword;
extern NSInteger const kMSOTimeoutImageSyncKey;
extern NSInteger const kMSOTimeoutLoginKey;
extern NSInteger const kMSOTimeoutPingKey;
extern NSInteger const kMSOTimeoutProductsSyncKey;
extern NSInteger const kMSOTimeoutPurchaseHistoryKey;
extern NSInteger const kMSOTimeoutRegistrationKey;
extern NSInteger const kMSOTimeoutSalesOrderKey;
extern NSInteger const kMSOTimeoutScannerKey;
extern NSInteger const kMSOTimeoutSettingsSyncKey;

extern NSString * _Nonnull const kMSOLogicielHTTPURLKey;

static NSStringEncoding stringEncoding = NSUTF8StringEncoding;

static NSString * _Nonnull const mso_soap_function_doWork                           = @"IServiceLibrary/DoWork";

static NSString * _Nonnull const mso_soap_function_iRegisterCode                    = @"iRegisterCode";
static NSString * _Nonnull const mso_soap_function_uploadFile                       = @"_UploadFile";
static NSString * _Nonnull const mso_soap_function_updateUploadInfo                 = @"_UpdateUploadInfo";
static NSString * _Nonnull const mso_soap_function_iRegisterShortKey                = @"iRegisterShortKey";
static NSString * _Nonnull const mso_soap_function_iCheckMobileDevice               = @"iCheckMobileDevice";
static NSString * _Nonnull const mso_soap_function_iCheckMobileUser                 = @"iCheckMobileUser";
static NSString * _Nonnull const mso_soap_function_iCheckPDAMessage                 = @"_iCheckPDAMessage";
static NSString * _Nonnull const mso_soap_function_checkCatalogFileStatus           = @"_CheckCatalogFileStatus";
static NSString * _Nonnull const mso_soap_function_getCustomersByCompany            = @"GetCustomersByCompany";
static NSString * _Nonnull const mso_soap_function_iCheckPDAHistoryForDownloading   = @"_iCheckPDAHistoryForDownloading";
static NSString * _Nonnull const mso_soap_function_updateDownloadInfo               = @"_UpdateDownloadInfo";
static NSString * _Nonnull const mso_soap_function_iCheckMobileMessage              = @"_iCheckMobileMessage";
static NSString * _Nonnull const mso_soap_function_iCheckMobileFileForDownloading   = @"_iCheckMobileFileForDownloading";
static NSString * _Nonnull const mso_soap_function_getEventList                     = @"GetEventList";
static NSString * _Nonnull const mso_soap_function_checkPhotoFileStatus             = @"_CheckPhotoFileStatus";

#pragma mark - Endpoints
static NSString * _Nonnull const mso_endpoint_logicielIncUrl                        = @"http://logicielinc.com";
static NSString * _Nonnull const mso_endpoint_logicielUrl                           = @"http://logiciel.com/";
static NSString * _Nonnull const mso_endpoint_logicielUpdateEndpoint                = @"logicielupdatews";
static NSString * _Nonnull const mso_endpoint_logicielCustomerASMX                  = @"logicielcustomer.asmx";
static NSString * _Nonnull const mso_endpoint_logicielFTPWSEndpoint                 = @"logiciel_ftp_ws";
static NSString * _Nonnull const mso_endpoint_logicielFTPServiceASMX                = @"FTPService.asmx";

#pragma mark - Static Commands
static NSString * _Nonnull const _msoNetserverPingCommand = @"<*!BEGIN!*><~~>_S001^^WLAN Connection?<*!END!*>";
static NSString * _Nonnull const _msoNetserverLogoutCommand = @"<*!BEGIN!*><~~><*!END!*>";

static NSString * _Nonnull const _msoNetserverBeginEscapedCommand = @"&amp;lt;*!BEGIN!*&amp;gt;";
static NSString * _Nonnull const _msoNetserverEndEscapedCommand = @"&amp;lt;*!END!*&amp;gt;";

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
 enums that define the registration status of an access key. This is only applied to Web Service calls

 - kMSOSDKResponseWebServiceStatusNotFound: Status Not Found = 0
 - kMSOSDKResponseWebServiceStatusUnregistered: Status Unregistered = 00
 - kMSOSDKResponseWebServiceStatusExpired: Status Expired = 1
 - kMSOSDKResponseWebServiceStatusDisabled: Status Disabled = 11
 - kMSOSDKResponseWebServiceStatusSuspended: Status Suspended = -1
 - kMSOSDKResponseWebServiceStatusInvalid: Status Invalid = -2
 - kMSOSDKResponseWebServiceStatusSuccess: Status Success = 2
 - kMSOSDKResponseWebServiceStatusUnknown: Status Unknown = ?
 */
typedef NS_ENUM(NSInteger, kMSOSDKResponseWebServiceStatus) {
    kMSOSDKResponseWebServiceStatusNotFound = 0,
    kMSOSDKResponseWebServiceStatusUnregistered = 1,
    kMSOSDKResponseWebServiceStatusExpired = 2,
    kMSOSDKResponseWebServiceStatusDisabled = 3,
    kMSOSDKResponseWebServiceStatusSuspended = 4,
    kMSOSDKResponseWebServiceStatusInvalid = 5,
    kMSOSDKResponseWebServiceStatusSuccess = 6,
    kMSOSDKResponseWebServiceStatusUnknown = -1,
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


typedef void (^ MSOHandlerBlock)
(NSURLResponse * _Nonnull response,
id _Nonnull responseObject,
NSError * __autoreleasing _Nullable * _Nullable error);
