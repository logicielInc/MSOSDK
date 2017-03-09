//
//  NSError+MSOSDKAdditions.m
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "NSError+MSOSDKAdditions.h"

@implementation NSError (MSOSDKAdditions)

+ (instancetype)mso_internet_login_credientials_invalid {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Login Failed",
                                      NSLocalizedFailureReasonErrorKey : @"Your login credentials are incorrect. Please verify your username and password are correct"}];
}

+ (instancetype)mso_internet_registration_key_invalid {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : @"Invalid key or email address. Please verify your access key and email address are correct"}];
}

+ (instancetype)mso_internet_registration_key_not_found {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : @"Key was not found"}];
}

+ (instancetype)mso_internet_registration_key_same_company_use {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is in use by the same company"]}];
}

+ (instancetype)mso_internet_registration_key_in_use {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is currently in use"]}];
}

+ (instancetype)mso_internet_registration_key_not_ready {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is not assigned"]}];
}

+ (instancetype)mso_internet_registration_key_unlock_code_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Device ID or Unlock Code does not match"]}];
}

+ (instancetype)mso_internet_registration_key_disabled_or_inuse {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is currently disabled or in use"]}];;
}

+ (instancetype)mso_internet_request_data_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Request Data Error",
                                      NSLocalizedFailureReasonErrorKey : @"The FTP Service could not process your request. Please try again"}];
}

+ (instancetype)mso_internet_upload_processing_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Upload File Error",
                                      NSLocalizedFailureReasonErrorKey : @"Our servers could not process the file. Please try again"}];
}

+ (instancetype)mso_internet_catalog_no_content {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey:@"Catalog has no content",
                                      NSLocalizedFailureReasonErrorKey : @"Please verify this Catalog is part of the event in MSO and has content. Then resync settings"}];
}

+ (instancetype)mso_internet_image_download_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:404
                           userInfo:@{NSLocalizedDescriptionKey : @"Error Downloading Images",
                                      NSLocalizedFailureReasonErrorKey : @"There seems to be some images that were unable to be synced. Please ensure that all images have an extension (e.g '.jpg') before downloading again"}];
}

+ (instancetype)mso_internet_image_download_error:(NSString *)filename {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:404
                           userInfo:@{NSLocalizedDescriptionKey : @"Error Downloading Image",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"There was an error downloading image named %@. Ensure this is actually an image file and is not corrupted", filename]}];
}

+ (instancetype)mso_internet_registration_key_disabled {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is currently disabled"]}];;
}

+ (instancetype)mso_internet_registration_key_unregistered {
    return  [NSError errorWithDomain:NSURLErrorDomain
                                code:204
                            userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                       NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is currently unregistered"]}];
}

+ (instancetype)mso_internet_registration_key_expired {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is currently expired"]}];
}

+ (instancetype)mso_internet_registration_key_suspended {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Registration Error",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Key is currently suspended"]}];
}

+ (instancetype)mso_netserver_product_fetch_empty_result {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Product Search Query",
                                      NSLocalizedFailureReasonErrorKey : @"No results found"}];
}

+ (instancetype)mso_netserver_event_invalid {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Event Invalid",
                                      NSLocalizedFailureReasonErrorKey : @"Please refresh your event as the current event in MSO does not match what is on the iPad"}];
}

+ (instancetype)mso_netserver_method_request_error:(NSString *)action {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Error Retrieving Data",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Please inform Logiciel there was an issue with requesting data from MSO reguarding action : %@", [[action componentsSeparatedByString:@"/"] lastObject]]}];
}

+ (instancetype)mso_netserver_sales_order_total_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Sales Order Error",
                                      NSLocalizedFailureReasonErrorKey : @"The current order's value is too low. Ensure that your order's total results in a value greater than $0.00"}];
}

+ (instancetype)mso_netserver_out_of_memory_exception_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Netserver Out of Memory Error",
                                      NSLocalizedFailureReasonErrorKey : @"Netserver seems to be out of memory. Please reboot netserver and try again"}];
}

+ (instancetype)mso_netserver_unknown_format_error:(NSString *)unknownFormat {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Netserver Unknown Format Error",
                                      NSLocalizedFailureReasonErrorKey : unknownFormat}];
}

+ (instancetype)mso_netserver_image_not_found_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"No Photo Found",
                                      NSLocalizedFailureReasonErrorKey : @"You can add a photo for this item in MSO is necessary then re-download the product image"}];
}

+ (instancetype)mso_netserver_customer_query_exceeded_limit_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Exceeded Search Limit with MSO",
                                      NSLocalizedFailureReasonErrorKey : @"The return result exceeded the limit (200). Please make a more specific search to retrieve customers from MSO"}];
}

+ (instancetype)mso_netserver_customer_query_not_found_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"No Customer(s) Found",
                                      NSLocalizedFailureReasonErrorKey : @"Try different search methods and also check MSO to see if there in fact does contain a customer with the exact search criteria"}];
}

+ (instancetype)mso_netserver_order_retrieval_no_orders {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{
                                      NSLocalizedDescriptionKey : @"No Sales Orders Found",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"There were no sales orders found for the specified search criteria"]
                                      }];
}

+ (instancetype)mso_netserver_order_retrieval_order_not_found {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{
                                      NSLocalizedDescriptionKey : @"No Sales Orders Found",
                                      NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"There was no sales order found for the specified order number"]
                                      }];
}

+ (instancetype)mso_netserver_image_upload_error {
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:204
                           userInfo:@{NSLocalizedDescriptionKey : @"Netserver Image Upload",
                                      NSLocalizedFailureReasonErrorKey : @"No Photo was submitted. Please try again"}];
}

@end

