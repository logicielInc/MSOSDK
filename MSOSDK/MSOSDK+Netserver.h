//
//  MSOSDK+Netserver.h
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDKMaster.h"

#import "MSOSDKResponseNetserver.h"

#import "NSString+MSOSDKAdditions.h"
#import "NSArray+MSOSDKAdditions.h"

@interface MSOSDK (Netserver)

///---------------------
/// @name Connection
///---------------------

/**
 Creates an `NSURLSessionDataTask` that checks if netserver is running
 
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the redirect response, and a `MSOSDKResponseNetserverPing` object.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
 @see `MSOSDKResponseNetserverPing`
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverPing:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverPing * _Nonnull responseObject))success
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
 @see `MSOSDKResponseNetserverLogin`
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverLogin:(nullable NSString *)username
                                            password:(nullable NSString *)password
                                             success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverLogin * _Nonnull responseObject))success
                                             failure:(_Nullable MSOFailureBlock)failure;

/**
 Creates an `NSURLSessionDataTask` sends a request to netserver to logout
 
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the redirect response, and a `MSOSDKResponseNetserverLogin` object.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
 @see `MSOSDKResponseNetserverLogin`
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverLogout:(void (^ _Nullable)(NSURLResponse * _Nonnull response, BOOL responseObject))success
                                              failure:(_Nullable MSOFailureBlock)failure;




/**
 Creates an `NSURLSessionDataTask` that requests for initial settings from netserver (e.g Configuration I and II)

 @param username The id of the current rep
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the redirect response, and a `MSOSDKResponseNetserverSettings` object.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
 @see `MSOSDKResponseNetserverSettings`
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverFetchInitialSettings:(nullable NSString *)username
                                                            success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSettings * _Nonnull responseObject))success
                                                            failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Products
///---------------------

- (nonnull NSURLSessionDataTask *)_msoNetserverFetchItemList:(nullable NSString *)username
                                                   companyId:(nullable NSString *)companyId
                                                    itemList:(nullable NSArray <NSString *> *)itemList
                                                     success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverQueryProducts * _Nullable responseObject))success
                                                    progress:(_Nullable MSOProgressBlock)progress
                                                     failure:(_Nullable MSOFailureBlock)failure
                                                     handler:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverQueryProducts * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error))handler;

/**
 <#Description#>

 @param username <#username description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadNumberOfProducts:(nullable NSString *)username
                                                                success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverProductsCount * _Nonnull responseObject))success
                                                               progress:(_Nullable MSOProgressBlock)progress
                                                                failure:(_Nullable MSOFailureBlock)failure;

/**
 <#Description#>

 @param username <#username description#>
 @param searchTerm <#searchTerm description#>
 @param companyId <#companyId description#>
 @param searchType <#searchType description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadProducts:(nullable NSString *)username
                                                     searchTerm:(nullable NSString *)searchTerm
                                                      companyId:(nullable NSString *)companyId
                                                     searchType:(kMSOProductSearchType)searchType
                                                        success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverQueryProducts * _Nonnull responseObject))success
                                                        failure:(_Nullable MSOFailureBlock)failure;


/**
 <#Description#>

 @param username <#username description#>
 @param nextId <#nextId description#>
 @param companyId <#companyId description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @param handler <#handler description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllProducts:(nullable NSString *)username
                                                            nextId:(nullable NSString *)nextId
                                                         companyId:(nullable NSString *)companyId
                                                           success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncProducts * _Nonnull responseObject))success
                                                          progress:(_Nullable MSOProgressBlock)progress
                                                           failure:(_Nullable MSOFailureBlock)failure
                                                           handler:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncProducts * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error))handler;

/**
 <#Description#>

 @param username <#username description#>
 @param nextId <#nextId description#>
 @param companyId <#companyId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @param handler <#handler description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllProducts:(nullable NSString *)username
                                                            nextId:(nullable NSString *)nextId
                                                         companyId:(nullable NSString *)companyId
                                                           success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncProducts * _Nullable responseObject))success
                                                           failure:(_Nullable MSOFailureBlock)failure
                                                           handler:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncProducts * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error))handler;

///---------------------
/// @name Customers
///---------------------

- (nonnull NSURLSessionDataTask *)_msoNetserverSaveCustomerMappingScheme:(nullable NSString *)username
                                                           mappingScheme:(nullable NSString *)mappingScheme
                                                                 success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncSaveCustomerMapping * _Nonnull responseObject))success
                                                                progress:(_Nullable MSOProgressBlock)progress
                                                                 failure:(_Nullable MSOFailureBlock)failure;

- (nonnull NSURLSessionDataTask *)_msoNetserverUpdateCustomerMappingScheme:(nullable NSString *)username
                                                             mappingScheme:(nullable NSString *)mappingScheme
                                                         mappingSchemeData:(nullable NSString *)mappingSchemeData
                                                                   success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncUpdateCustomerMapping * _Nonnull responseObject))success
                                                                  progress:(_Nullable MSOProgressBlock)progress
                                                                   failure:(_Nullable MSOFailureBlock)failure;


/**
 <#Description#>

 @param username <#username description#>
 @param nextId <#nextId description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @param handler <#handler description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllCustomers:(nullable NSString *)username
                                                             nextId:(nullable NSString *)nextId
                                                            success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncCustomers * _Nullable responseObject))success
                                                           progress:(_Nullable MSOProgressBlock)progress
                                                            failure:(_Nullable MSOFailureBlock)failure
                                                            handler:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncCustomers * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error))handler;

/**
 <#Description#>

 @param username <#username description#>
 @param accountNumber <#accountNumber description#>
 @param name <#name description#>
 @param phone <#phone description#>
 @param city <#city description#>
 @param state <#state description#>
 @param zip <#zip description#>
 @param billing <#billing description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadCustomers:(nullable NSString *)username
                                                   accountnumber:(nullable NSString *)accountNumber
                                                            name:(nullable NSString *)name
                                                           phone:(nullable NSString *)phone
                                                            city:(nullable NSString *)city
                                                           state:(nullable NSString *)state
                                                             zip:(nullable NSString *)zip
                                                         billing:(BOOL)billing
                                                         success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverQueryCustomers * _Nonnull responseObject))success
                                                        progress:(_Nullable MSOProgressBlock)progress
                                                         failure:(_Nullable MSOFailureBlock)failure;

/**
 <#Description#>

 @param username <#username description#>
 @param customerName <#customerName description#>
 @param contactName <#contactName description#>
 @param address1 <#address1 description#>
 @param address2 <#address2 description#>
 @param city <#city description#>
 @param state <#state description#>
 @param zip <#zip description#>
 @param country <#country description#>
 @param phone <#phone description#>
 @param fax <#fax description#>
 @param email <#email description#>
 @param terms <#terms description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
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
                                                    success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSaveCustomer * _Nonnull responseObject))success
                                                   progress:(_Nullable MSOProgressBlock)progress
                                                    failure:(_Nullable MSOFailureBlock)failure;

/**
 <#Description#>

 @param username <#username description#>
 @param accountNumber <#accountNumber description#>
 @param mainstoreNumber <#mainstoreNumber description#>
 @param customerName <#customerName description#>
 @param contactName <#contactName description#>
 @param address1 <#address1 description#>
 @param address2 <#address2 description#>
 @param city <#city description#>
 @param state <#state description#>
 @param zip <#zip description#>
 @param country <#country description#>
 @param phone <#phone description#>
 @param fax <#fax description#>
 @param email <#email description#>
 @param terms <#terms description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
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
                                                                   success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSaveCustomerShippingAddress * _Nonnull responseObject))success
                                                                  progress:(_Nullable MSOProgressBlock)progress
                                                                   failure:(_Nullable MSOFailureBlock)failure;

/**
 A block that updates a customer's address. When updating a ship to address, you need to ensure that the billing flag is set to NO,
 as well as the account number being appended with -XXX (where XXX is the ship to store id).
 If the ship to store is not appended, the result will be updating the bill to address / default ship to

 @param username The user id of the current rep updating the customer
 @param companyName The customer address Company Name
 @param accountNumber The customer address ID to update
 @param name The name of the customer's address. If this is a billing address, the Customer Name field will be updated. If shipping, the Name field will be updated.
 @param contactName The contact name of the customer's address.
 @param address1 The primary street address of the customer's address.
 @param address2 The second street address of the customer's address.
 @param city The city of the customer's address.
 @param state The state of the customer's address.
 @param zip The zip code of the customer's address.
 @param country The country of the customer's address.
 @param phone The phone number of the customer's address. No special format is necessary
 @param fax The fax number of the customer's address. No special format is necessary
 @param email The email address of the customer's address.
 @param terms The terms of the customer to update. If this is a shipping address, this field is ignored.
 @param rep The rep name of the customer to update. If this is a shipping address, this field is ignored.
 @param discount The discount of the customer to update. If this is a shipping address, this field is ignored
 @param priceLevel The price level of the customer to update. If this is a shipping address, this field is ignored
 @param billing A boolean value signaling the web service that the passed in customer address is either billing (1) or shipping (0)
 @param success A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 @param progress A block object to be executed when the download progress is updated. Note this block is called on the session queue, not the main queue.
 @param failure A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 @return `NSURLSessionDataTask`
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
                                                             success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverUpdateCustomer * _Nonnull responseObject))success
                                                            progress:(_Nullable MSOProgressBlock)progress
                                                             failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Settings
///---------------------

/**
 <#Description#>

 @param userId <#userId description#>
 @param nextId <#nextId description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @param handler <#handler description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllSettings:(nullable NSString *)userId
                                                            nextId:(nullable NSString *)nextId
                                                           success:(void (^ _Nullable)(NSURLResponse * _Nonnull response , MSOSDKResponseNetserverSyncSettings * _Nullable responseObject))success
                                                          progress:(_Nullable MSOProgressBlock)progress
                                                           failure:(_Nullable MSOFailureBlock)failure
                                                           handler:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncSettings * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error))handler;

///---------------------
/// @name Image
///---------------------

/**
 <#Description#>

 @param username <#username description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverFetchAllImageReferences:(nullable NSString *)username
                                                               success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverQueryImages * _Nonnull responseObject))success
                                                              progress:(_Nullable MSOProgressBlock)progress
                                                               failure:(_Nullable MSOFailureBlock)failure;

/**
 <#Description#>

 @param identifier <#identifier description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadProductImage:(nullable NSString *)identifier
                                                            success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, UIImage * _Nonnull responseObject))success
                                                           progress:(_Nullable MSOProgressBlock)progress
                                                            failure:(_Nullable MSOFailureBlock)failure;

/**
 <#Description#>

 @param username <#username description#>
 @param base64EncodedImage <#base64EncodedImage description#>
 @param identifier <#identifier description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverUploadImage:(nullable NSString *)username
                                        base64EncodedImage:(nullable NSString *)base64EncodedImage
                                                identifier:(nullable NSString *)identifier
                                                   success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSaveImage * _Nonnull responseObject))success
                                                  progress:(_Nullable MSOProgressBlock)progress
                                                   failure:(_Nullable MSOFailureBlock)failure;

- (void)_msoDownloadLastPurchasePrice:(_Nullable MSOSuccessBlock)success
                             progress:(_Nullable MSOProgressBlock)progress
                              failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Order Retrieval
///---------------------
/**
 <#Description#>

 @param username <#username description#>
 @param orderNumber <#orderNumber description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverRetrieveOrder:(nullable NSString *)username
                                                 orderNumber:(nullable NSString *)orderNumber
                                                     success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverQuerySalesOrder * _Nonnull responseObject))success
                                                    progress:(_Nullable MSOProgressBlock)progress
                                                     failure:(_Nullable MSOFailureBlock)failure;

/**
 <#Description#>

 @param username <#username description#>
 @param customerName <#customerName description#>
 @param customerAccountNumber <#customerAccountNumber description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverRetrieveOrders:(nullable NSString *)username
                                                 customerName:(nullable NSString *)customerName
                                        customerAccountNumber:(nullable NSString *)customerAccountNumber
                                                      success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverQueryCustomerSalesOrders * _Nonnull responseObject))success
                                                     progress:(_Nullable MSOProgressBlock)progress
                                                      failure:(_Nullable MSOFailureBlock)failure;

///---------------------
/// @name Order Submission
///---------------------

/**
 <#Description#>

 @param username <#username description#>
 @param orderNumber <#orderNumber description#>
 @param imageNotes <#imageNotes description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverSubmitImageNotes:(nullable NSString *)username
                                                    orderNumber:(nullable NSString *)orderNumber
                                                     imageNotes:(nullable NSArray<NSString *> *)imageNotes
                                                        success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSubmitSalesOrder * _Nonnull responseObject))success
                                                       progress:(_Nullable MSOProgressBlock)progress
                                                        failure:(_Nullable MSOFailureBlock)failure;

/**
 <#Description#>

 @param username <#username description#>
 @param orderNumber <#orderNumber description#>
 @param orderString <#orderString description#>
 @param update <#update description#>
 @param imageNotes <#imageNotes description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverSubmitOrder:(nullable NSString *)username
                                               orderNumber:(nullable NSString *)orderNumber
                                               orderString:(nullable NSString *)orderString
                                                    update:(BOOL)update
                                                imageNotes:(BOOL)imageNotes
                                                   success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSubmitSalesOrder * _Nonnull responseObject))success
                                                  progress:(_Nullable MSOProgressBlock)progress
                                                   failure:(_Nullable MSOFailureBlock)failure;


///---------------------
/// @name Order History
///---------------------

/**
 <#Description#>

 @param username <#username description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @param handler <#handler description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadAllPurchaseHistory:(nullable NSString *)username
                                                                  success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncPurchaseHistory * _Nullable responseObject))success
                                                                 progress:(_Nullable MSOProgressBlock)progress
                                                                  failure:(_Nullable MSOFailureBlock)failure
                                                                  handler:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncPurchaseHistory * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error))handler;

/**
 <#Description#>

 @param username <#username description#>
 @param customerName <#customerName description#>
 @param customerZip <#customerZip description#>
 @param success <#success description#>
 @param progress <#progress description#>
 @param failure <#failure description#>
 @param handler <#handler description#>
 @return <#return value description#>
 */
- (nonnull NSURLSessionDataTask *)_msoNetserverDownloadPurchaseHistory:(nullable NSString *)username
                                                          customerName:(nullable NSString *)customerName
                                                           customerZip:(nullable NSString *)customerZip
                                                               success:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncPurchaseHistory * _Nullable responseObject))success
                                                              progress:(_Nullable MSOProgressBlock)progress
                                                               failure:(_Nullable MSOFailureBlock)failure
                                                               handler:(void (^ _Nullable)(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverSyncPurchaseHistory * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error))handler;


@end
