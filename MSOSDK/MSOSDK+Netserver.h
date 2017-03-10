//
//  MSOSDK+Netserver.h
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDK.h"

@interface MSOSDK (Netserver)

///---------------------
/// @name Connection
///---------------------

/**
 Creates an `NSURLSessionDataTask` that checks if netserver is running
 
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the redirect response, and a `MSOSDKResponseNetserverPing` object.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
 @see MSOSDKResponseNetserverPing
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverPing:(_Nullable MSOSuccessBlock)success
                                            failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Login/Logout
///---------------------

/**
 Creates an `NSURLSessionDataTask` that checks if netserver is running
 
 @param username The username to check against in netserver
 @param password The password to check against in netserver
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the redirect response, and a `MSOSDKResponseNetserverLogin` object.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
 @see MSOSDKResponseNetserverLogin
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverLogin:(nullable NSString *)username
                                            password:(nullable NSString *)password
                                             success:(_Nullable MSOSuccessBlock)success
                                             failure:(_Nullable MSOFailureBlock)failure;

/**
 Creates an `NSURLSessionDataTask` sends a request to netserver to logout
 
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the redirect response, and a `MSOSDKResponseNetserverLogin` object.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
 @see MSOSDKResponseNetserverLogin
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverLogout:(_Nullable MSOSuccessBlock)success
                                              failure:(_Nullable MSOFailureBlock)failure;




/**
 Creates an `NSURLSessionDataTask` that requests for initial settings from netserver (e.g Configuration I and II)

 @param username The id of the current rep
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the redirect response, and a `MSOSDKResponseNetserverSettings` object.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
 @see MSOSDKResponseNetserverSettings
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverFetchInitialSettings:(nullable NSString *)username
                                                            success:(_Nullable MSOSuccessBlock)success
                                                            failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Products
///---------------------

- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadNumberOfProducts:(nullable NSString *)username
                                                                success:(_Nullable MSOSuccessBlock)success
                                                               progress:(_Nullable MSOProgressBlock)progress
                                                                failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadProducts:(nullable NSString *)username
                                                     searchTerm:(nullable NSString *)searchTerm
                                                      companyId:(nullable NSString *)companyId
                                                     searchType:(kMSOProductSearchType)searchType
                                                        success:(_Nullable MSOSuccessBlock)success
                                                        failure:(_Nullable MSOFailureBlock)failure;


- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllProducts:(nullable NSString *)username
                                                            nextId:(nullable NSString *)nextId
                                                         companyId:(nullable NSString *)companyId
                                                           success:(_Nullable MSOSuccessBlock)success
                                                          progress:(_Nullable MSOProgressBlock)progress
                                                           failure:(_Nullable MSOFailureBlock)failure
                                                           handler:(_Nullable MSONetserverSyncBlock)handler;

- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllProducts:(nullable NSString *)username
                                                            nextId:(nullable NSString *)nextId
                                                         companyId:(nullable NSString *)companyId
                                                           success:(_Nullable MSOSuccessBlock)success
                                                           failure:(_Nullable MSOFailureBlock)failure
                                                           handler:(_Nullable MSONetserverSyncBlock)handler;

///---------------------
/// @name Customers
///---------------------

- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllCustomers:(nullable NSString *)username
                                                             nextId:(nullable NSString *)nextId
                                                            success:(_Nullable MSOSuccessBlock)success
                                                           progress:(_Nullable MSOProgressBlock)progress
                                                            failure:(_Nullable MSOFailureBlock)failure
                                                            handler:(_Nullable MSONetserverSyncBlock)handler;

- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadCustomers:(nullable NSString *)username
                                                   accountnumber:(nullable NSString *)accountNumber
                                                            name:(nullable NSString *)name
                                                           phone:(nullable NSString *)phone
                                                            city:(nullable NSString *)city
                                                           state:(nullable NSString *)state
                                                             zip:(nullable NSString *)zip
                                                         billing:(BOOL)billing
                                                         success:(_Nullable MSOSuccessBlock)success
                                                        progress:(_Nullable MSOProgressBlock)progress
                                                         failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoNetserverSaveCustomer:(nullable NSString *)username
                                               customerName:(nullable NSString *)customerName
                                                contactName:(nullable NSString *)contactName
                                                   address1:(nullable NSString *)address1
                                                   address2:(nullable NSString *)address2
                                                       city:(nullable NSString *)city
                                                      state:(nullable NSString *)state
                                                        zip:(nullable NSString *)zip
                                                    country:(nullable NSString *)country
                                                      phone:(nullable NSString *)phone
                                                        fax:(nullable NSString *)fax
                                                      email:(nullable NSString *)email
                                                      terms:(nullable NSString *)terms
                                                    success:(_Nullable MSOSuccessBlock)success
                                                   progress:(_Nullable MSOProgressBlock)progress
                                                    failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoNetserverSaveCustomerShippingAddress:(nullable NSString *)username
                                                             accountNumber:(nullable NSString *)accountNumber
                                                           mainstoreNumber:(nullable NSString *)mainstoreNumber
                                                              customerName:(nullable NSString *)customerName
                                                               contactName:(nullable NSString *)contactName
                                                                  address1:(nullable NSString *)address1
                                                                  address2:(nullable NSString *)address2
                                                                      city:(nullable NSString *)city
                                                                     state:(nullable NSString *)state
                                                                       zip:(nullable NSString *)zip
                                                                   country:(nullable NSString *)country
                                                                     phone:(nullable NSString *)phone
                                                                       fax:(nullable NSString *)fax
                                                                     email:(nullable NSString *)email
                                                                     terms:(nullable NSString *)terms
                                                                   success:(_Nullable MSOSuccessBlock)success
                                                                  progress:(_Nullable MSOProgressBlock)progress
                                                                   failure:(_Nullable MSOFailureBlock)failure;

/**
 
 @warning When updating a ship to address, you need to ensure that the billing flag is set to NO,
 as well as the account number being appended with -XXX (where XXX is the ship to store id).
 If the ship to store is not appended, the result will be updating the bill to address / default ship to
 
 @param name The the NAME field in a shipping address (Billing = NO) or CUSTOMER NAME (Billing = YES)
 
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverUpdateCustomerAddress:(nullable NSString *)username
                                                         companyName:(nullable NSString *)companyName
                                                       accountNumber:(nullable NSString *)accountNumber
                                                                name:(nullable NSString *)name
                                                         contactName:(nullable NSString *)contactName
                                                            address1:(nullable NSString *)address1
                                                            address2:(nullable NSString *)address2
                                                                city:(nullable NSString *)city
                                                               state:(nullable NSString *)state
                                                                 zip:(nullable NSString *)zip
                                                             country:(nullable NSString *)country
                                                               phone:(nullable NSString *)phone
                                                                 fax:(nullable NSString *)fax
                                                               email:(nullable NSString *)email
                                                               terms:(nullable NSString *)terms
                                                                 rep:(nullable NSString *)rep
                                                            discount:(nullable NSNumber *)discount
                                                          priceLevel:(nullable NSNumber *)priceLevel
                                                             billing:(BOOL)billing
                                                             success:(_Nullable MSOSuccessBlock)success
                                                            progress:(_Nullable MSOProgressBlock)progress
                                                             failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Settings
///---------------------
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllSettings:(nullable NSString *)userId
                                                            nextId:(nullable NSString *)nextId
                                                           success:(_Nullable MSOSuccessBlock)success
                                                          progress:(_Nullable MSOProgressBlock)progress
                                                           failure:(_Nullable MSOFailureBlock)failure
                                                           handler:(_Nullable MSONetserverSyncBlock)handler;

///---------------------
/// @name Image
///---------------------

- (nonnull NSURLSessionDataTask *)_msoNetserverFetchAllImageReferences:(nullable NSString *)username
                                                               success:(_Nullable MSOSuccessBlock)success
                                                              progress:(_Nullable MSOProgressBlock)progress
                                                               failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadProductImage:(nullable NSString *)identifier
                                                            success:(_Nullable MSOSuccessBlock)success
                                                           progress:(_Nullable MSOProgressBlock)progress
                                                            failure:(_Nullable MSOFailureBlock)failure
                                                            handler:(_Nullable MSONetserverImageBlock)handler;
- (nonnull NSURLSessionDataTask *)_msoNetserverUploadImage:(nullable NSString *)username
                                        base64EncodedImage:(nullable NSString *)base64EncodedImage
                                                identifier:(nullable NSString *)identifier
                                                   success:(_Nullable MSOSuccessBlock)success
                                                  progress:(_Nullable MSOProgressBlock)progress
                                                   failure:(_Nullable MSOFailureBlock)failure;

- (void)_msoDownloadLastPurchasePrice:(_Nullable MSOSuccessBlock)success
                             progress:(_Nullable MSOProgressBlock)progress
                              failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Order Retrieval
///---------------------
- (nonnull NSURLSessionDataTask *)_msoNetserverRetrieveOrder:(nullable NSString *)username
                                                 orderNumber:(nullable NSString *)orderNumber
                                                     success:(_Nullable MSOSuccessBlock)success
                                                    progress:(_Nullable MSOProgressBlock)progress
                                                     failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoNetserverRetrieveOrders:(nullable NSString *)username
                                                 customerName:(nullable NSString *)customerName
                                        customerAccountNumber:(nullable NSString *)customerAccountNumber
                                                      success:(_Nullable MSOSuccessBlock)success
                                                     progress:(_Nullable MSOProgressBlock)progress
                                                      failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Order Submission
///---------------------
- (nonnull NSURLSessionDataTask *)_msoNetserverSubmitImageNotes:(nullable NSString *)username
                                                    orderNumber:(nullable NSString *)orderNumber
                                                     imageNotes:(nullable NSArray<NSString *> *)imageNotes
                                                        success:(_Nullable MSOSuccessBlock)success
                                                       progress:(_Nullable MSOProgressBlock)progress
                                                        failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoNetserverSubmitOrder:(nullable NSString *)username
                                               orderNumber:(nullable NSString *)orderNumber
                                               orderString:(nullable NSString *)orderString
                                                    update:(BOOL)update
                                                imageNotes:(BOOL)imageNotes
                                                   success:(_Nullable MSOSuccessBlock)success
                                                  progress:(_Nullable MSOProgressBlock)progress
                                                   failure:(_Nullable MSOFailureBlock)failure;


///---------------------
/// @name Order History
///---------------------
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllPurchaseHistory:(nullable NSString *)username
                                                                  success:(_Nullable MSOSuccessBlock)success
                                                                 progress:(_Nullable MSOProgressBlock)progress
                                                                  failure:(_Nullable MSOFailureBlock)failure
                                                                  handler:(_Nullable MSONetserverSyncBlock)handler;

- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadPurchaseHistory:(nullable NSString *)username
                                                          customerName:(nullable NSString *)customerName
                                                           customerZip:(nullable NSString *)customerZip
                                                               success:(_Nullable MSOSuccessBlock)success
                                                              progress:(_Nullable MSOProgressBlock)progress
                                                               failure:(_Nullable MSOFailureBlock)failure
                                                               handler:(_Nullable MSONetserverSyncBlock)handler;


@end
