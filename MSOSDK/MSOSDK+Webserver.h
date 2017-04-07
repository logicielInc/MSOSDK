//
//  MSOSDK+Webserver.h
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDKMaster.h"

#import <SMXMLDocument/SMXMLDocument.h>

#import "GRRequestProtocol.h"
#import "MSOSDKResponseWebserver.h"

#import "NSURL+MSOSDKAdditions.h"
#import "NSString+MSOSDKAdditions.h"
#import "NSDate+MSOSDKAdditions.h"

@interface MSOSDK (Webserver) <GRRequestsManagerDelegate>

#pragma mark - LogicielCustomer

#pragma mark Login

/**
 Checks whether the current credentials are valid
 
 @param username The userID assigned to the current rep
 @param accesskey The key assigned to the current rep
 @param udid The unique identifier for the specified device attempting to register the rep
 @param companyname The company whose associated with the current rep
 @param user A boolean to check whether we are checking credentials again the device or the rep
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and MSOSDKResponseWebserverCredentials.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see http://logicielinc.com/logicielupdatews/logicielcustomer.asmx?op=iCheckMobileUser
 @see http://logicielinc.com/logicielupdatews/logicielcustomer.asmx?op=iCheckMobileDevice
 */
- (nonnull NSURLSessionDataTask *)_msoWebserverValidity:(nullable NSString *)username
                                               accesskey:(nullable NSString *)accesskey
                                                    udid:(nullable NSString *)udid
                                                     pin:(nullable NSString *)pin
                                             companyname:(nullable NSString *)companyname
                                              appversion:(nullable NSString *)appversion
                                                    user:(BOOL)user
                                                 success:(_Nullable MSOSuccessBlock)success
                                                 failure:(_Nullable MSOFailureBlock)failure;


#pragma mark Forgot password
/**
 Sends out an email to the rep whose email is in MSO
 
 @param username The userID assigned to the current rep
 @param password The password assigned to the current rep
 @param accesskey The key assigned to the current rep
 @param udid The unique identifier for the specified device attempting to register the rep
 @param pin The pin identifier of the company the rep is assigned to
 @param appversion The current build of iMobileRep
 @param companyname The company whose associated with the current rep
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and MSOSDKResponseWebserverCredentials.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see http://logicielinc.com/logicielupdatews/logicielcustomer.asmx?op=iCheckMobileDevice
 */
- (nonnull NSURLSessionDataTask *)_msoWebserverForgotPassword:(nullable NSString *)username
                                                      password:(nullable NSString *)password
                                                     accesskey:(nullable NSString *)accesskey
                                                          udid:(nullable NSString *)udid
                                                           pin:(nullable NSString *)pin
                                                    appversion:(nullable NSString *)appversion
                                                   companyname:(nullable NSString *)companyname
                                                       success:(_Nullable MSOSuccessBlock)success
                                                       failure:(_Nullable MSOFailureBlock)failure;

#pragma mark Registration
/**
 Registers the current rep and assigns a device to the key
 
 @param username The userID assigned to the current rep
 @param accesskey The key assigned to the current rep
 @param email The email assigned to the current rep
 @param udid The unique identifier for the specified device attempting to register the rep
 @param appversion The current build of iMobileRep
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and MSOSDKResponseWebserverRegister.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred. If the key is already in use, attempting to re-register the key with another device will result in an error object 'In-Use' to be returned.
 @see http://logicielinc.com/logicielupdatews/logicielcustomer.asmx?op=iRegisterShortKey
 */
- (nonnull NSURLSessionDataTask *)_msoWebserverRegisterRep:(nullable NSString *)username
                                                  accesskey:(nullable NSString *)accesskey
                                                      email:(nullable NSString *)email
                                                       udid:(nullable NSString *)udid
                                                 appversion:(nullable NSString *)appversion
                                                    success:(_Nullable MSOSuccessBlock)success
                                                    failure:(_Nullable MSOFailureBlock)failure;


/**
 Registers the current rep and assigns a device to the key
 
 @param username The userID assigned to the current rep
 @param cds An array of components parsed from the MSOSDKResponseWebserverRegister object within _msoWebserverRegisterRep:accesskey:email:udid:appversion:completion:failure:
 @param accesskey The key assigned to the current rep
 @param code The unlock code returned from MSOSDKResponseWebserverRegister object within _msoWebserverRegisterRep:accesskey:email:udid:appversion:completion:failure:
 @param company The company assigned to the current rep
 @param email The email assigned to the current rep
 @param udid The unique identifier for the specified device attempting to register the rep
 @param appversion The current build of iMobileRep
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and MSOSDKResponseWebserverRegister.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 @see http://logicielinc.com/logicielupdatews/logicielcustomer.asmx?op=iRegisterCode
 */
- (nonnull NSURLSessionDataTask *)_msoWebserverRegisterCode:(nullable NSString *)username
                                                         cds:(nullable NSString *)cds
                                                   accesskey:(nullable NSString *)accesskey
                                                        code:(nullable NSString *)code
                                                        type:(nullable NSString *)type
                                                     company:(nullable NSString *)company
                                                       email:(nullable NSString *)email
                                                        udid:(nullable NSString *)udid
                                                  appversion:(nullable NSString *)appversion
                                                  reregister:(BOOL)reregister
                                                     success:(_Nullable MSOSuccessBlock)success
                                                     failure:(_Nullable MSOFailureBlock)failure;

#pragma mark - FTPService

#pragma mark Images
- (void)_msoWebserverFetchAllPhotoReferences:(nullable NSString *)pin
                                      success:(_Nullable MSOSuccessBlock)success
                                     progress:(_Nullable MSOProgressBlock)progress
                                      failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverFetchPhotoFileStatus:(nullable NSString *)itemNo
                                                                 pin:(nullable NSString *)pin
                                                             success:(_Nullable MSOSuccessBlock)success
                                                            progress:(_Nullable MSOProgressBlock)progress
                                                             failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverDownloadPhoto:(nullable NSString *)filename
                                                          pin:(nullable NSString *)pin
                                                      success:(_Nullable MSOSuccessBlock)success
                                                     progress:(_Nullable MSOProgressBlock)progress
                                                      failure:(_Nullable MSOFailureBlock)failure;

#pragma mark Event

/**
 @method _msoWebserverDownloadEventList:completion:progress:failure:
 
 @response NSArray of NSString objects (filenames of .zip files)
 */
- (void)_msoWebserverDownloadEventList:(nullable NSString *)pin
                                success:(_Nullable MSOSuccessBlock)success
                               progress:(_Nullable MSOProgressBlock)progress
                                failure:(_Nullable MSOFailureBlock)failure;


#pragma mark Check For Files
- (nonnull NSURLSessionDataTask *)_msoWebserverCheckForNumberOfFilesToDownload:(nullable NSString *)userId
                                                                            pin:(nullable NSString *)pin
                                                                           date:(nullable NSDate *)date
                                                                        success:(_Nullable MSOSuccessBlock)success
                                                                       progress:(_Nullable MSOProgressBlock)progress
                                                                        failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverCheckForFilesToDownload:(nullable NSString *)userId
                                                                    pin:(nullable NSString *)pin
                                                                   date:(nullable NSDate *)date
                                                                success:(_Nullable MSOSuccessBlock)success
                                                               progress:(_Nullable MSOProgressBlock)progress
                                                                failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverCheckForFiles:(nullable NSString *)userId
                                                          pin:(nullable NSString *)pin
                                                         date:(nullable NSDate *)date
                                                      success:(_Nullable MSOSuccessBlock)success
                                                     progress:(_Nullable MSOProgressBlock)progress
                                                      failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverUploadToFTP:(nullable NSDictionary <NSString *, NSData *> *)data
                                                        pin:(nullable NSString *)pin
                                                    newfile:(BOOL)newfile
                                                    success:(_Nullable MSOSuccessBlock)success
                                                   progress:(_Nullable MSOProgressBlock)progress
                                                    failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverUploadToFTPUpdate:(nullable NSString *)pin
                                                         username:(nullable NSString *)userName
                                                      companyname:(nullable NSString *)companyName
                                                         filename:(nullable NSString *)fileName
                                                         filesize:(unsigned long long)filesize
                                                             udid:(nullable NSString *)udid
                                                       updateDate:(nullable NSDate *)updateDate
                                                          success:(_Nullable MSOSuccessBlock)success
                                                         progress:(_Nullable MSOProgressBlock)progress
                                                          failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverSendDataRequest:(nullable NSString *)username
                                                            pin:(nullable NSString *)pin
                                                           udid:(nullable NSString *)udid
                                                    companyname:(nullable NSString *)companyname
                                                       criteria:(nullable NSString *)criteria
                                                        success:(_Nullable MSOSuccessBlock)success
                                                       progress:(_Nullable MSOProgressBlock)progress
                                                        failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverUpdateDownloadInfo:(nullable NSString *)username
                                                       companyname:(nullable NSString *)companyname
                                                              udid:(nullable NSString *)udid
                                                               pin:(nullable NSString *)pin
                                                          fileName:(nullable NSString *)fileName
                                                      downloadDate:(nullable NSDate *)downloadDate
                                                          filesize:(unsigned long long)filesize
                                                           success:(_Nullable MSOSuccessBlock)success
                                                          progress:(_Nullable MSOProgressBlock)progress
                                                           failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoWebserverCheckPDAHistoryForDownloading:(nullable NSString *)username
                                                                          pin:(nullable NSString *)pin
                                                                      success:(_Nullable MSOSuccessBlock)success
                                                                     progress:(_Nullable MSOProgressBlock)progress
                                                                      failure:(_Nullable MSOFailureBlock)failure;

#pragma mark Catalogs
- (nonnull NSURLSessionDataTask *)_msoWebserverFetchCatalog:(nullable NSString *)catalogName
                                                         pin:(nullable NSString *)pin
                                                     success:(_Nullable MSOSuccessBlock)success
                                                    progress:(_Nullable MSOProgressBlock)progress
                                                     failure:(_Nullable MSOFailureBlock)failure;
    

/**
 @brief This method may be unimplemented on the server side. All thats returned is the schema for a customer object
 */
- (nonnull NSURLSessionDataTask *)_msoWebserverFetchCustomersByCompanyName:(nullable NSString *)companyName
                                                                        pin:(nullable NSString *)pin
                                                                    success:(_Nullable MSOSuccessBlock)success
                                                                   progress:(_Nullable MSOProgressBlock)progress
                                                                    failure:(_Nullable MSOFailureBlock)failure;
@end
