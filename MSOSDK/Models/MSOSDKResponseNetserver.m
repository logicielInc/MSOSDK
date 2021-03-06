//
//  MSOSDKResponseNetserver.m
//  iMobileRep
//
//  Created by John Setting on 2/14/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDKResponseNetserver.h"

#import "NSArray+MSOSDKAdditions.h"
#import "NSString+MSOSDKAdditions.h"

@implementation MSOSDKResponseNetserver

+ (instancetype)msosdk_commandWithResponse:(NSString *)response error:(NSError **)error {

    if ([response hasPrefix:@"Invalid Login:"] ||
        [response hasSuffix:@"Invalid ID/Password or Access Level."]) {
        
        *error = [NSError mso_internet_login_credientials_invalid];
        return nil;
    }
    
    if ([response hasPrefix:@"Invalid Event:"]) {
        *error = [NSError mso_netserver_event_invalid];
        return nil;
    }

    if ([response containsString:@"OutOfMemoryException"]) {
        *error = [NSError mso_netserver_out_of_memory_exception_error];
        return nil;
    }
    
    if ([response hasPrefix:@"Invalid Event."]) {

        NSString *eventId = [response mso_stringBetweenString:@"[" andString:@"]"];
        
        NSUInteger position = [response rangeOfString:@"]"].location + 2;
        NSUInteger length = [response length] - position;
        NSRange range = NSMakeRange(position, length);
        
        NSString *eventName = [response substringWithRange:range];

        *error = [NSError mso_netserver_event_invalid_with_eventName:eventName eventId:eventId];        
        return nil;
    }
    
    if ([response isEqualToString:@"Photo Not Found"]) {
        *error = [NSError mso_netserver_image_not_found_error];
        return nil;
    }
    
    NSArray *components = [response componentsSeparatedByString:@"^"];
    return [[self alloc] initWithResponse:components];
}

- (instancetype)initWithResponse:(NSArray *)response {
    self = [super init];
    if (self) {
        
        _command = [response mso_safeObjectAtIndex:0];
        
        if ([_command isEqualToString:@"iPad connection terminated"]) {
            _status = @"OK";
            return self;
        }
        
        _status = [response mso_safeObjectAtIndex:1];

        if ([response count] > 2) {
            _trailingResponse = [response subarrayWithRange:NSMakeRange(2, [response count] - 2)];
        }
        
    }
    return self;
}

+ (instancetype)msosdk_commandWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    return [[self alloc] initWithResponseObject:responseObject error:error];
}

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super init];
    if (self) {
        _command = [responseObject command];
        _status = [responseObject status];
        _trailingResponse = [responseObject trailingResponse];
    }
    
    return self;
    
}

- (NSString *)fullData:(NSArray *)command breakpoint:(NSUInteger)breakpoint {
    if ([command count] > breakpoint + 1) {
        NSArray *subArray = [command subarrayWithRange:NSMakeRange(breakpoint, [command count] - breakpoint)];
        return [subArray componentsJoinedByString:@"^"];
    } else {
        return [command mso_safeObjectAtIndex:breakpoint];
    }
}

@end

@implementation MSOSDKResponseNetserverProductsCount

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {

        NSArray <NSString *> *response = responseObject.trailingResponse;
        if (response) {
            _productCount = @([[response mso_safeObjectAtIndex:0] integerValue]);
        }

    }
    return self;

}

@end

@implementation MSOSDKResponseNetserverSaveCustomer

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {

        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            
            _objectsSavedCount = @([[response mso_safeObjectAtIndex:0] integerValue]);
            _mainstoreNumber = [response mso_safeObjectAtIndex:1];
            _accountNumber = [response mso_safeObjectAtIndex:2];
            _terms = [response mso_safeObjectAtIndex:3];
            _priceLevel = @([[response mso_safeObjectAtIndex:4] integerValue]);
            
        }

    }
    return self;

}

@end

@implementation MSOSDKResponseNetserverUpdateCustomer

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {

        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            
            _objectsSavedCount = @([[response mso_safeObjectAtIndex:0] integerValue]);
            
            NSString *message = [response mso_safeObjectAtIndex:1];
            if (!message || [message isEqualToString:@"No Customer Updated."]) {
                *error = [NSError mso_netserver_customer_query_not_found_error];
                return nil;
            }
            
            _message = message;
            
        }

    }
    return self;

}

@end

@implementation MSOSDKResponseNetserverSaveCustomerShippingAddress

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            
            _customerName = [response mso_safeObjectAtIndex:5];
            _contactName = [response mso_safeObjectAtIndex:6];
            _address1 = [response mso_safeObjectAtIndex:7];
            _address2 = [response mso_safeObjectAtIndex:8];
            _city = [response mso_safeObjectAtIndex:9];
            _state = [response mso_safeObjectAtIndex:10];
            _zip = [response mso_safeObjectAtIndex:11];
            _country = [response mso_safeObjectAtIndex:12];
            _phone = [response mso_safeObjectAtIndex:13];
            _fax = [response mso_safeObjectAtIndex:14];
            _email = [response mso_safeObjectAtIndex:15];
            
        }
    }
    return self;

}

@end

@implementation MSOSDKResponseNetserverSync

@end

@implementation MSOSDKResponseNetserverSyncSettings

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {

        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            
            NSString *index = [response mso_safeObjectAtIndex:0];
            NSArray *components = [index componentsSeparatedByString:@"|"];
            self.objectCount = @([[components mso_safeObjectAtIndex:0] integerValue]);
            self.nextIndex = [components mso_safeObjectAtIndex:1];
            self.data = [self fullData:response breakpoint:1];
            
        }

    }
    
    return self;

}

@end

@implementation MSOSDKResponseNetserverSyncCustomers

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {

        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            
            self.objectCount = [response mso_safeObjectAtIndex:0];
            self.nextIndex = [response mso_safeObjectAtIndex:1];
            self.data = [self fullData:response breakpoint:2];
            
        }

    }
    
    return self;
}

@end

@implementation MSOSDKResponseNetserverSyncSaveCustomerMapping

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            
            if ([response containsObject:@"No Auto-Mapping Created."]) {
                
                *error = [NSError mso_netserver_auto_mapping_not_created_error];
                return nil;
                
            }
            
            self.objectCount = [response mso_safeObjectAtIndex:0];
            self.data = [self fullData:response breakpoint:1];
        }        
    }
    return self;
    
}

@end

@implementation MSOSDKResponseNetserverSyncUpdateCustomerMapping

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            
            if ([response containsObject:@" *****Error Message: Index was outside the bounds of the array."]) {
                            
                *error = [NSError mso_netserver_auto_mapping_update_error];
                return nil;
                
            }
            
            self.objectCount = [response mso_safeObjectAtIndex:0];
            self.data = [self fullData:response breakpoint:1];
        }
    }
    return self;
    
}

@end

@implementation MSOSDKResponseNetserverSyncProducts

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            self.objectCount = [response mso_safeObjectAtIndex:0];
            _companyId = [response mso_safeObjectAtIndex:1];
            self.nextIndex = [response mso_safeObjectAtIndex:2];
            self.data = [self fullData:response breakpoint:3];
        }
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSyncPurchaseHistory

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            self.objectCount = @([[response mso_safeObjectAtIndex:0] integerValue]);
            _nextId = [response mso_safeObjectAtIndex:2];
            _detailLoop = [response mso_safeObjectAtIndex:3];
            self.data = [self fullData:response breakpoint:4];
        }
    }
    return self;
}

- (void)mso_appendResponseObject:(MSOSDKResponseNetserverSyncPurchaseHistory *)responseObject {
    self.command = responseObject.command;
    self.status = responseObject.status;
    NSArray <NSString *> *command = responseObject.trailingResponse;
    self.detailLoop = @([[command mso_safeObjectAtIndex:0] integerValue]);
    self.data = [self.data stringByAppendingString:[command mso_safeObjectAtIndex:1]];
}

@end


@implementation MSOSDKResponseNetserverQuery

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            self.pages = [response mso_safeObjectAtIndex:0];
            self.data = [self fullData:response breakpoint:1];
        }
    }
    
    return self;
}

- (void)mso_appendResponseObject:(MSOSDKResponseNetserverQuery *)responseObject {
    self.command = responseObject.command;
    self.status = responseObject.status;
    
    NSArray <NSString *> *response = responseObject.trailingResponse;
    
    _pages = [response mso_safeObjectAtIndex:0];
    NSString *data = [self fullData:response breakpoint:1];
    NSMutableString *formattedData = [_data mutableCopy];
    [formattedData appendString:data];
    [formattedData replaceOccurrencesOfString:@"<NewDataSet>" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [formattedData length])];
    [formattedData replaceOccurrencesOfString:@"</NewDataSet>" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [formattedData length])];
    [formattedData insertString:@"<NewDataSet>" atIndex:0];
    [formattedData appendString:@"</NewDataSet>"];
    _data = [formattedData copy];
}


@end

@implementation MSOSDKResponseNetserverQueryProducts

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            self.pages = [response mso_safeObjectAtIndex:0];
            
            NSString *data = [response mso_safeObjectAtIndex:1];
            if ([data isEqualToString:@"Item Not Found."]) {
                *error = [NSError mso_netserver_product_fetch_empty_result];
                return nil;
            }
            
            self.data = [self fullData:response breakpoint:1];
        }
    }
    
    return self;
}

@end

@implementation MSOSDKResponseNetserverQueryCustomers

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            self.pages = [response mso_safeObjectAtIndex:0];
            
            NSString *data = [response mso_safeObjectAtIndex:1];
            if ([data hasPrefix:@"Exceeded Limit"]) {
                *error = [NSError mso_netserver_customer_query_exceeded_limit_error];
                return nil;
            }
            
            self.data = [self fullData:response breakpoint:1];
        }
    }
    
    return self;
}

@end

@implementation MSOSDKResponseNetserverQueryCustomerSalesOrders

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            NSString *count = [response mso_safeObjectAtIndex:0];
            if ([count integerValue] == 0) {
                *error = [NSError mso_netserver_order_retrieval_no_orders];
                return nil;
            }
            self.objectCount = [response mso_safeObjectAtIndex:0];
            self.data = [self fullData:response breakpoint:1];
        }
    }

    return self;
}

@end

@implementation MSOSDKResponseNetserverQuerySalesOrder

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {

    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        
        NSArray <NSString *> *response = self.trailingResponse;
        
        if ([response containsObject:@"Order in Using."]) {
            *error = [NSError mso_netserver_order_retrieval_in_use];
            return nil;
        }
        
        if ([response containsObject:@"No Sales Order Found."]) {
            *error = [NSError mso_netserver_order_retrieval_order_not_found];
            return nil;
        }
        
        _objectCount = @([[response mso_safeObjectAtIndex:0] integerValue]);

        if ([response count] >= 3) {
            _data = [response mso_safeObjectAtIndex:2];
            return self;
        }
        
        NSString *data = [response mso_safeObjectAtIndex:1];
        _data = data;
    }
    return self;
}

- (void)mso_appendResponseObject:(MSOSDKResponseNetserverQuerySalesOrder *)responseObject {
    self.command = responseObject.command;
    self.status = responseObject.status;
    NSArray <NSString *> *response = responseObject.trailingResponse;
    _objectCount = @([[response mso_safeObjectAtIndex:0] integerValue]);
    NSString *data = [response mso_safeObjectAtIndex:1];
    _data = [_data stringByAppendingString:data];
}

@end


@implementation MSOSDKResponseNetserverQueryImages
- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            _objectCount = [response mso_safeObjectAtIndex:0];
            NSUInteger count = [response count];
            NSInteger index = 1;
            if (index < count) {
                NSRange range = NSMakeRange(index, count - index);
                _images = [response subarrayWithRange:range];
            } else {
                _images = [NSArray array];
            }

        }
        
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSaveImage

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
            _identifier = [response mso_safeObjectAtIndex:0];
            _message = [response mso_safeObjectAtIndex:1];
        }
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSubmitSalesOrder

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        NSArray <NSString *> *response = self.trailingResponse;
        if (response) {
        
            if ([[response lastObject] hasSuffix:@"*****Error Message: Value was either too large or too small for a Decimal."]) {
                *error = [NSError mso_netserver_sales_order_total_error];
                return nil;
            }

            _objectCount = @([[response mso_safeObjectAtIndex:0] integerValue]);
            _orderNumber = [response mso_safeObjectAtIndex:1];
            _customerName = [response mso_safeObjectAtIndex:2];
            
            if (_customerName) {
                _customerAccountNumber = [_customerName mso_stringBetweenString:@"[" andString:@"]"];
                NSString *replacement = [NSString stringWithFormat:@" [%@]", _customerAccountNumber];
                _customerName = [_customerName stringByReplacingOccurrencesOfString:replacement withString:@""];
            }
            
            //_customerName = [command mso_safeObjectAtIndex:5];
            //_customerName = [command mso_safeObjectAtIndex:6];
            //_customerName = [command mso_safeObjectAtIndex:7];

        }
    }
    return self;
    
}

@end


@implementation MSOSDKResponseNetserverPing

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {

        if ([self.status isEqualToString:@"NO"]) {
            
            *error =
            [NSError
             mso_netserver_ping_error];

            return nil;
        }
        
        NSArray <NSString *> *response = self.trailingResponse;
        
        if (response) {
            _extendedCommand = [response mso_safeObjectAtIndex:0];
            _eventId = [response mso_safeObjectAtIndex:1];
            _eventName = [response mso_safeObjectAtIndex:2];
        }
        
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverLogin

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        
        if ([self.status isEqualToString:@"NO"]) {
            *error =
            [NSError
             mso_internet_login_credientials_invalid];
            return nil;
        }
        
        NSArray <NSString *> *response = self.trailingResponse;
        
        if (response) {
            _userId = [response mso_safeObjectAtIndex:0];

            NSString *manager = [response mso_safeObjectAtIndex:1];
            _manager = manager ? @([manager boolValue]) : @0;
            
            NSString *priceLevels = [response mso_safeObjectAtIndex:2];
            _foundPriceLevels = [priceLevels containsString:@"|"] ? @1 : @0;
            
            // 0 means default level, but only be useful for the road rep batch mode, so don't need to handle here
            NSArray *priceLevelComponents = [priceLevels componentsSeparatedByString:@"|"];
            NSString *priceLevel1       = [priceLevelComponents mso_safeObjectAtIndex:1];
            NSString *priceLevel2       = [priceLevelComponents mso_safeObjectAtIndex:2];
            NSString *priceLevel3       = [priceLevelComponents mso_safeObjectAtIndex:3];
            NSString *priceLevel4       = [priceLevelComponents mso_safeObjectAtIndex:4];
            NSString *priceLevel5       = [priceLevelComponents mso_safeObjectAtIndex:5];
            NSString *priceLevelAllow   = [priceLevelComponents mso_safeObjectAtIndex:6];

            _priceLevelAllow1 = priceLevel1 ? @([priceLevel1 boolValue]) : @0;
            _priceLevelAllow2 = priceLevel2 ? @([priceLevel2 boolValue]) : @0;
            _priceLevelAllow3 = priceLevel3 ? @([priceLevel3 boolValue]) : @0;
            _priceLevelAllow4 = priceLevel4 ? @([priceLevel4 boolValue]) : @0;
            _priceLevelAllow5 = priceLevel5 ? @([priceLevel5 boolValue]) : @0;

            _allowUserDefinedPriceLevel = priceLevelAllow ? @([priceLevelAllow boolValue]) : @0;
        }
        
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSettings

- (instancetype)initWithResponseObject:(MSOSDKResponseNetserver *)responseObject error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithResponseObject:responseObject error:error];
    if (self) {
        
        NSArray <NSString *> *response = responseObject.trailingResponse;
        
        _keyboardControl                                    = @([[response mso_safeObjectAtIndex:0] integerValue]);
        NSString *scannerSetup                              = [response mso_safeObjectAtIndex:1];
        // 2 (TCP WLAN)
        _productPhotoSaveOption                             = @([[response mso_safeObjectAtIndex:3] integerValue]);
        NSString *displayFormat                             = [response mso_safeObjectAtIndex:4];
        // 5 (Dummy)
        // 6 (PDA Prefix ?)
        _minimumOrderAmount                                 = @([[response mso_safeObjectAtIndex:7] doubleValue]);
        _multipleCompanies                                  = @([[response mso_safeObjectAtIndex:8] boolValue]);
        _recalculateSet                                     = @([[response mso_safeObjectAtIndex:9] boolValue]);
        _recalculatePriceTagAlong                           = @([[response mso_safeObjectAtIndex:10] boolValue]);
        _behaviorWhenEnteringItem                           = [[response mso_safeObjectAtIndex:11] integerValue];
        _pricingStructure                                   = [response mso_safeObjectAtIndex:12];
        _discountRule                                       = @([[response mso_safeObjectAtIndex:13] integerValue]);
        _discountRuleSubtotal                               = @([[response mso_safeObjectAtIndex:14] integerValue]);
        _discountRuleAllowShipping                          = @([[response mso_safeObjectAtIndex:15] boolValue]);
        // 16 (WLAN Submit)
        NSString *eventNameAndId                            = [response mso_safeObjectAtIndex:17];
        _alertIfOrderQuantityMoreThanOnHandQuantity         = @([[response mso_safeObjectAtIndex:18] boolValue]);
        _applyCustomerDiscountAsOrderDiscount               = [response mso_safeObjectAtIndex:19];
        _backupOrder                                        = [response mso_safeObjectAtIndex:20];
        _keepSubmittedOrderCopy                             = [response mso_safeObjectAtIndex:21];
        // 22 999 (Dummy)
        _orderDefaultShipVia                                = [response mso_safeObjectAtIndex:23];
        _orderDefaultTerms                                  = [response mso_safeObjectAtIndex:24];
        NSString *autoDefaultQuantityShipDate               = [response mso_safeObjectAtIndex:25];
        _alertBelowMinimumPrice                             = @([[response mso_safeObjectAtIndex:26] boolValue]);
        _orderSortByItemNumber                              = @([[response mso_safeObjectAtIndex:27] boolValue]);
        NSString *salesOrderRequirements                    = [response mso_safeObjectAtIndex:28];
        _salesTax                                           = @([[response mso_safeObjectAtIndex:29] doubleValue]);
        _scanSwipeBadgeMapping                              = @([[response mso_safeObjectAtIndex:30] boolValue]);
        // 31
        // 32
        // 33
        _orderRequiresMinimumItemQuantity                   = @([[response mso_safeObjectAtIndex:34] boolValue]);
        _allowCustomAssortment                              = @([[response mso_safeObjectAtIndex:35] boolValue]);
        _optionsIfOrderQuantityGreaterThanOnHandQuantity    = [[response mso_safeObjectAtIndex:36] integerValue];
        _lastPurchasePricePriority                          = @([[response mso_safeObjectAtIndex:37] boolValue]);
        NSString *eventDefaultTitles                        = [response mso_safeObjectAtIndex:38];
        _salesManagerPrivilegeInTradeshow                   = @([[response mso_safeObjectAtIndex:39] boolValue]);
        _salesTaxForSampleSales                             = [response mso_safeObjectAtIndex:40];
        _discountRuleShippingChoice                         = [response mso_safeObjectAtIndex:41];
        _companyPriceLevel                                  = [response mso_safeObjectAtIndex:42];
        _workPeriodControl                              = [response mso_safeObjectAtIndex:43];
        _eventInterval                                 = [response mso_safeObjectAtIndex:44];
        
        
        
        // 45-51 (Blanks)
        NSString *licenseInfo                               = [response mso_safeObjectAtIndex:52];
        NSString *printOut                                  = [response mso_safeObjectAtIndex:53];
        _messageCompanyPolicy                               = [response mso_safeObjectAtIndex:54];
        _messageCustomerGreeting                            = [response mso_safeObjectAtIndex:55];
        _messagePayment                                     = [response mso_safeObjectAtIndex:56];
        
        [self parseEventNameAndEventId:eventNameAndId];
        [self parseAutoDefaultQuantityShipDate:autoDefaultQuantityShipDate];
        [self parseScannerSetup:scannerSetup];
        [self parseDisplayFormat:displayFormat];
        [self parsePDAConfigurationII:salesOrderRequirements eventDefaultTitles:eventDefaultTitles];
        [self parsePrintOut:printOut];
        [self parseLicenseInfo:licenseInfo];
    }
    return self;
}

- (void)parseAutoDefaultQuantityShipDate:(NSString *)autoDefaultQuantityShipDate {
    
    if ([autoDefaultQuantityShipDate isEqualToString:@"1"]) {
        _defaultQuantityToPreviousEntry = @1;
        _defaultShipDateToPreviousEntry = @0;
        return;
    }
    
    if ([autoDefaultQuantityShipDate isEqualToString:@"2"]) {
        _defaultQuantityToPreviousEntry = @0;
        _defaultShipDateToPreviousEntry = @1;
        return;
    }
    
    if ([autoDefaultQuantityShipDate isEqualToString:@"3"]) {
        _defaultQuantityToPreviousEntry = @1;
        _defaultShipDateToPreviousEntry = @1;
        return;
    }
    
    _defaultQuantityToPreviousEntry = @0;
    _defaultShipDateToPreviousEntry = @0;
}

- (void)parseDisplayFormat:(NSString *)displayFormat {
    NSArray *displayFormatParameters = [displayFormat componentsSeparatedByString:@"|"];
    
    NSString *priceItemLevel = [displayFormatParameters mso_safeObjectAtIndex:0];
    _formatterPriceItemLevel = [self returnParsedFormatter:priceItemLevel currency:YES];
    
    NSString *priceTotal = [displayFormatParameters mso_safeObjectAtIndex:1];
    _formatterPriceTotal = [self returnParsedFormatter:priceTotal currency:YES];
    
    NSString *quantityItemLevel = [displayFormatParameters mso_safeObjectAtIndex:2];
    _formatterQuantityItemLevel = [self returnParsedFormatter:quantityItemLevel currency:NO];
    
    NSString *formatterItemDiscount = [displayFormatParameters mso_safeObjectAtIndex:4];
    _formatterItemDiscount = [self returnParsedFormatter:formatterItemDiscount currency:NO];
    
    NSString *quantityTotal = [displayFormatParameters mso_safeObjectAtIndex:3];
    _formatterQuantityTotal = [self returnParsedFormatter:quantityTotal currency:NO];
    
    NSString *weightItemLevel = [displayFormatParameters mso_safeObjectAtIndex:4];
    _formatterWeightItemLevel = [self returnParsedFormatter:weightItemLevel currency:NO];
    
    NSString *weightTotal = [displayFormatParameters mso_safeObjectAtIndex:5];
    _formatterWeightTotal = [self returnParsedFormatter:weightTotal currency:NO];
    
    NSString *volumeItemLevel = [displayFormatParameters mso_safeObjectAtIndex:6];
    _formatterVolumeItemLevel = [self returnParsedFormatter:volumeItemLevel currency:NO];
    
    NSString *volumeTotal = [displayFormatParameters mso_safeObjectAtIndex:7];
    _formatterVolumeTotal = [self returnParsedFormatter:volumeTotal currency:NO];
    
}

- (NSNumberFormatter *)returnParsedFormatter:(NSString *)formatter currency:(BOOL)currency {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setNumberStyle:currency ? NSNumberFormatterCurrencyStyle : NSNumberFormatterDecimalStyle];
    NSString *currencySymbol = @"¤";
    NSScanner* scan = [NSScanner scannerWithString:formatter];
    int i;
    double d;
    if ([scan scanInt:&i] && [scan isAtEnd]) {
        if (currency) {
            formatter = [NSString stringWithFormat:@"%@#,##0", currencySymbol];
        }
        [format setPositiveFormat:formatter];
        return format;
    } else if ([scan scanDouble:&d] && [scan isAtEnd]) {
        NSArray *components = [formatter componentsSeparatedByString:@"."];
        NSString *decimalPlaces = [components lastObject];
        NSUInteger decimalPlacesCount = [decimalPlaces length];
        NSMutableString *str = [NSMutableString string];
        for (NSUInteger i = 0; i < decimalPlacesCount; i++) {
            [str appendString:@"0"];
        }
        if (currency) {
            formatter = [NSString stringWithFormat:@"%@#,##0.%@", currencySymbol, str];
        }
        [format setPositiveFormat:formatter];
        return format;
    } else {
        return format;
    }
}

- (void)parseEventNameAndEventId:(NSString *)eventNameId {
    
    if (!eventNameId) {
        _eventName = @"";
        _eventId = @"LOGICIEL";
        return;
    }
    
    _eventName = eventNameId;
    NSArray *components = [eventNameId componentsSeparatedByString:@"]"];
    NSString *component = [components firstObject];
    NSString *parsedEventId = [component stringByReplacingOccurrencesOfString:@"[" withString:@""];
    if (parsedEventId && [parsedEventId length] > 0) {
        _eventId = parsedEventId;
    } else {
        _eventId = @"LOGICIEL";
    }
}

- (void)parseScannerSetup:(NSString *)scannerSetup {
    
    NSArray *scannerSetupParameters = [scannerSetup componentsSeparatedByString:@","];
    
    _scannerSetupReadCountryCode = @([[scannerSetupParameters mso_safeObjectAtIndex:0] doubleValue]);
    _scannerSetupReadSystemCodePrefix = @([[scannerSetupParameters mso_safeObjectAtIndex:1] doubleValue]);
    _scannerSetupReadChecksumDigit = @([[scannerSetupParameters mso_safeObjectAtIndex:2] doubleValue]);
}

- (void)parsePrintOut:(NSString *)printOut {
    NSArray *printOutParameters = [printOut componentsSeparatedByString:@"|"];
    
    NSString *showQuantityPriceWhenSellingBulk = [printOutParameters mso_safeObjectAtIndex:0];
    if ([showQuantityPriceWhenSellingBulk isEqualToString:@"B"]) {
        _printIfBulkSellingShowPrice = @1;
        _printIfBulkSellingShowQuantity = @0;
    } else if ([showQuantityPriceWhenSellingBulk isEqualToString:@"C"]) {
        _printIfBulkSellingShowPrice = @0;
        _printIfBulkSellingShowQuantity = @1;
    } else {
        _printIfBulkSellingShowPrice = @0;
        _printIfBulkSellingShowQuantity = @0;
    }
    
    _printCustomerRep       = @([[printOutParameters mso_safeObjectAtIndex:1] boolValue]);
    _printUPC               = @([[printOutParameters mso_safeObjectAtIndex:3] boolValue]);
    _printItemDescription2  = @([[printOutParameters mso_safeObjectAtIndex:2] boolValue]);
    _printItemVendorName    = @([[printOutParameters mso_safeObjectAtIndex:9] boolValue]);
    _printManufacturerName  = @([[printOutParameters mso_safeObjectAtIndex:10] boolValue]);
    _printShowOrderTotal    = @(![[printOutParameters mso_safeObjectAtIndex:6] boolValue]);
    
    _printMSRP                          = @([[printOutParameters mso_safeObjectAtIndex:11] boolValue]);
    _printPrice                         = @([[printOutParameters mso_safeObjectAtIndex:12] boolValue]);
    _printItemColorSizeAbbreviation     = @([[printOutParameters mso_safeObjectAtIndex:13] boolValue]);
    _printItemWeight                    = @([[printOutParameters mso_safeObjectAtIndex:14] boolValue]);
    _printTotalWeight                   = @([[printOutParameters mso_safeObjectAtIndex:4] boolValue]);
    _printItemVolume                    = @([[printOutParameters mso_safeObjectAtIndex:15] boolValue]);
    _printTotalVolume                   = @([[printOutParameters mso_safeObjectAtIndex:5] boolValue]);
    
    _printItemDiscountIfDiscounted      = @([[printOutParameters mso_safeObjectAtIndex:7] boolValue]);
    
    _printSortByItemNumber              = @([[printOutParameters mso_safeObjectAtIndex:8] boolValue]);
}

- (void)parsePDAConfigurationII:(NSString *)salesOrderRequirements eventDefaultTitles:(NSString *)eventDefaultTitles {
    NSArray *salesOrderRequirementsParameters = [salesOrderRequirements componentsSeparatedByString:@"|"];
    
    _orderRequiresAddress       = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:0] boolValue]);
    _orderRequiresPhone         = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:1] boolValue]);
    _orderRequiresEmail         = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:2] boolValue]);
    _orderRequiresShipDate      = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:3] boolValue]);
    _orderRequiresCancelDate    = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:4] boolValue]);
    _orderRequiresPONumber      = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:5] boolValue]);
    
    _orderRequiresBuyerName     = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:6] boolValue]);
    _orderRequiresFOB           = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:7] boolValue]);
    _orderRequiresWarehouse     = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:8] boolValue]);
    _orderRequiresCreditCard    = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:9] boolValue]);
    _orderRequiresPaymentTerms  = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:10] boolValue]);
    
    _staticCreditCard           = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:11] boolValue]);
    _staticPaymentTerms         = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:12] boolValue]);
    
    _orderRequiredMinimumOrderAmountForMasterOrder = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:13] boolValue]);
    _allowCustomTermsShipViaFOB                    = @(![[salesOrderRequirementsParameters mso_safeObjectAtIndex:14] boolValue]);
    _orderRequiredMinimumOrderAmountForEachCompany = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:15] boolValue]);
    
    NSArray *eventDefaultTitlesParameters = [eventDefaultTitles componentsSeparatedByString:@"|"];
    
    _userDefinedProductLine = [eventDefaultTitlesParameters mso_safeObjectAtIndex:0];
    _userDefinedCategory = [eventDefaultTitlesParameters mso_safeObjectAtIndex:1];
    _userDefinedSeason = [eventDefaultTitlesParameters mso_safeObjectAtIndex:2];
}

- (void)parseLicenseInfo:(NSString *)licenseInfo {
    
    licenseInfo = [licenseInfo stringByReplacingOccurrencesOfString:@"{License Info.*}" withString:@""];
    NSArray *companyComponents = [licenseInfo componentsSeparatedByString:@"}"];

    _companyName    = [companyComponents mso_safeObjectAtIndex:0];
    _pin            = [companyComponents mso_safeObjectAtIndex:1];
    _address1       = [companyComponents mso_safeObjectAtIndex:2];
    _address2       = [companyComponents mso_safeObjectAtIndex:3];
    _city           = [companyComponents mso_safeObjectAtIndex:4];
    _state          = [companyComponents mso_safeObjectAtIndex:5];
    _zip            = [companyComponents mso_safeObjectAtIndex:6];
    _country        = [companyComponents mso_safeObjectAtIndex:7];
    _phone1         = [companyComponents mso_safeObjectAtIndex:8];
    _phone2         = [companyComponents mso_safeObjectAtIndex:9];
    _fax            = [companyComponents mso_safeObjectAtIndex:10];
    _email          = [companyComponents mso_safeObjectAtIndex:11];
    _website        = [companyComponents mso_safeObjectAtIndex:12];
    _oneCustomerListInfo = [companyComponents mso_safeObjectAtIndex:13];
    
}

- (BOOL)productPricing {
    return [self.pricingStructure isEqualToString:@"B"];
}

- (NSString *)formattedEventName {
    NSString *eventName = [self.eventName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"[%@]", self.eventId] withString:@""];
    if (!eventName || [eventName length] == 0 || !self.eventId || [self.eventId length] == 0) {
        return @"NO DATA";
    }
    return [NSString stringWithFormat:@"%@ - %@", self.eventId, eventName];
}

- (NSString *)formattedCompanyAddress {

    NSMutableArray *components = [NSMutableArray arrayWithCapacity:4];
    

    NSMutableArray *addressComponents = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *addressComponents1 = [NSMutableArray arrayWithCapacity:6];
    if (self.address1 && [self.address1 length] > 0) {
        [addressComponents1 addObject:self.address1];
    }
    if ([addressComponents1 count] > 0) {
        [addressComponents addObject:[addressComponents1 componentsJoinedByString:@" "]];
    }

    NSMutableArray *addressComponents2 = [NSMutableArray arrayWithCapacity:6];
    if (self.address2 && [self.address2 length] > 0) {
        [addressComponents2 addObject:self.address2];
    }

    if (self.city && [self.city length] > 0) {
        [addressComponents2 addObject:self.city];
    }
    if ([addressComponents2 count] > 0) {
        [addressComponents addObject:[addressComponents2 componentsJoinedByString:@" "]];
    }

    NSMutableArray *addressComponents3 = [NSMutableArray arrayWithCapacity:6];
    NSString *addressComponent3 = [NSString string];
    if (self.state && [self.state length] > 0) {
        [addressComponents3 addObject:self.state];
    }

    if (self.zip && [self.zip length] > 0) {
        [addressComponents3 addObject:self.zip];
    }
    
    if (self.country && [self.country length] > 0) {
        [addressComponents3 addObject:self.country];
    }
    if ([addressComponents3 count] > 0) {
        [addressComponents addObject:[addressComponents3 componentsJoinedByString:@" "]];
    }

    if ([addressComponents count] > 0) {
        [components addObject:[addressComponents componentsJoinedByString:@", "]];
    }
    
    NSMutableArray *phoneComponents = [NSMutableArray arrayWithCapacity:2];
    if (self.phone1 && [self.phone1 length] > 0) {
        [phoneComponents addObject:self.phone1];
    }
    if (self.phone2 && [self.phone2 length] > 0) {
        [phoneComponents addObject:self.phone2];
    }
    if (self.fax && [self.fax length] > 0) {
        [phoneComponents addObject:[NSString stringWithFormat:@"Fax %@", self.fax]];
    }
    if ([phoneComponents count] > 0) {
        if ([phoneComponents count] > 1) {
            [components addObject:[NSString stringWithFormat:@"Tel %@", [phoneComponents componentsJoinedByString:@" "]]];
        } else {
            [components addObject:[phoneComponents componentsJoinedByString:@" "]];
        }
    }

    NSMutableArray *webComponents = [NSMutableArray arrayWithCapacity:2];
    if (self.email && [self.email length] > 0) {
        [webComponents addObject:self.email];
    }
    if (self.website && [self.website length] > 0) {
        [webComponents addObject:self.website];
    }
    if ([webComponents count] > 0) {
        [components addObject:[webComponents componentsJoinedByString:@" "]];
    }
    
    return [components count] > 0 ? [components componentsJoinedByString:@"\n"] : nil;

}

@end
