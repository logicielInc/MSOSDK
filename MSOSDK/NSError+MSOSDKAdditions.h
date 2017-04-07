//
//  NSError+MSOSDKAdditions.h
//  iMobileRep
//
//  Created by John Setting on 3/8/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSOSDKConstants.h"

/**
 Description
 */
@interface NSError (MSOSDKAdditions)

+ (nonnull instancetype)mso_internet_login_credientials_invalid;
+ (nonnull instancetype)mso_internet_registration_key_invalid;
+ (nonnull instancetype)mso_internet_registration_key_not_found;

+ (nonnull instancetype)mso_internet_registration_key_same_company_use;
+ (nonnull instancetype)mso_internet_registration_key_in_use;
+ (nonnull instancetype)mso_internet_registration_key_not_ready;
+ (nonnull instancetype)mso_internet_registration_key_unlock_code_error;
+ (nonnull instancetype)mso_internet_registration_key_disabled_or_inuse;
+ (nonnull instancetype)mso_internet_request_data_error;
+ (nonnull instancetype)mso_internet_upload_processing_error;
+ (nonnull instancetype)mso_internet_catalog_no_content;
+ (nonnull instancetype)mso_internet_image_download_error;
+ (nonnull instancetype)mso_internet_image_download_error:(nullable NSString *)filename;
+ (nonnull instancetype)mso_internet_registration_key_disabled;
+ (nonnull instancetype)mso_internet_registration_key_unregistered;
+ (nonnull instancetype)mso_internet_registration_key_expired;
+ (nonnull instancetype)mso_internet_registration_key_suspended;

+ (nonnull instancetype)mso_netserver_ping_error;

+ (nonnull instancetype)mso_netserver_product_fetch_empty_result;
+ (nonnull instancetype)mso_netserver_event_invalid;
+ (nonnull instancetype)mso_netserver_event_invalid_with_eventName:(nullable NSString *)eventName eventId:(nullable NSString *)eventId;
+ (nonnull instancetype)mso_netserver_method_request_error:(nullable NSString *)action;
+ (nonnull instancetype)mso_netserver_sales_order_total_error;
+ (nonnull instancetype)mso_netserver_out_of_memory_exception_error;
+ (nonnull instancetype)mso_netserver_unknown_format_error:(nullable NSString *)unknownFormat;
+ (nonnull instancetype)mso_netserver_image_not_found_error;
+ (nonnull instancetype)mso_netserver_customer_query_exceeded_limit_error;
+ (nonnull instancetype)mso_netserver_customer_query_not_found_error;

+ (nonnull instancetype)mso_netserver_order_retrieval_in_use;
+ (nonnull instancetype)mso_netserver_order_retrieval_no_orders;
+ (nonnull instancetype)mso_netserver_order_retrieval_order_not_found;
+ (nonnull instancetype)mso_netserver_image_upload_error;
+ (nonnull instancetype)mso_netserver_auto_mapping_not_created_error;
+ (nonnull instancetype)mso_netserver_auto_mapping_update_error;

+ (void)errorHandler:(nullable NSError *)error
            response:(nullable NSURLResponse *)response
             failure:(_Nullable MSOFailureBlock)failure;
@end
