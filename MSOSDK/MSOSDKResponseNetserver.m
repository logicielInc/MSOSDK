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
+ (instancetype)msosdk_commandWithResponse:(NSArray *)response {
    return [[self alloc] initWithCommand:response];
}

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super init];
    if (self) {
        _command = [command mso_safeObjectAtIndex:0];
        _status = [command mso_safeObjectAtIndex:1];
    }
    return self;
}

- (NSString *)fullData:(NSArray *)command breakpoint:(NSUInteger)breakpoint {
    if ([command count] > breakpoint + 1) {
        NSArray *subArray = [command subarrayWithRange:NSMakeRange(breakpoint, [command count] - breakpoint)];
        return [subArray componentsJoinedByString:@""];
    } else {
        return [command mso_safeObjectAtIndex:breakpoint];
    }
}

@end

@implementation MSOSDKResponseNetserverProductsCount

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _productCount = @([[command mso_safeObjectAtIndex:2] integerValue]);
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSaveCustomer

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _objectsSavedCount = @([[command mso_safeObjectAtIndex:2] integerValue]);
        _mainstoreNumber = [command mso_safeObjectAtIndex:3];
        _accountNumber = [command mso_safeObjectAtIndex:4];
        _terms = [command mso_safeObjectAtIndex:5];
        _something = @([[command mso_safeObjectAtIndex:6] integerValue]);
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverUpdateCustomer

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _objectsSavedCount = @([[command mso_safeObjectAtIndex:2] integerValue]);
        _message = [command mso_safeObjectAtIndex:3];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSaveCustomerShippingAddress

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _customerName = [command mso_safeObjectAtIndex:7];
        _contactName = [command mso_safeObjectAtIndex:8];
        _address1 = [command mso_safeObjectAtIndex:9];
        _address2 = [command mso_safeObjectAtIndex:10];
        _city = [command mso_safeObjectAtIndex:11];
        _state = [command mso_safeObjectAtIndex:12];
        _zip = [command mso_safeObjectAtIndex:13];
        _country = [command mso_safeObjectAtIndex:14];
        _phone = [command mso_safeObjectAtIndex:15];
        _fax = [command mso_safeObjectAtIndex:16];
        _email = [command mso_safeObjectAtIndex:17];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSync

@end

@implementation MSOSDKResponseNetserverSyncSettings

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        NSString *index = [command mso_safeObjectAtIndex:2];
        NSArray *components = [index componentsSeparatedByString:@"|"];
        self.objectCount = @([[components mso_safeObjectAtIndex:0] integerValue]);
        self.nextIndex = [components mso_safeObjectAtIndex:1];
        self.data = [self fullData:command breakpoint:3];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSyncCustomers

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        self.objectCount = [command mso_safeObjectAtIndex:2];
        self.nextIndex = [command mso_safeObjectAtIndex:3];
        self.data = [self fullData:command breakpoint:4];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSyncProducts

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        self.objectCount = [command mso_safeObjectAtIndex:2];
        _companyId = [command mso_safeObjectAtIndex:3];
        self.nextIndex = [command mso_safeObjectAtIndex:4];
        self.data = [self fullData:command breakpoint:5];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSyncPurchaseHistory

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        self.objectCount = @([[command mso_safeObjectAtIndex:2] integerValue]);
        _nextId = [command mso_safeObjectAtIndex:4];
        _detailLoop = [command mso_safeObjectAtIndex:5];
        self.data = [self fullData:command breakpoint:6];
    }
    return self;
}

- (void)appendCommand:(NSArray *)command {
    self.detailLoop = @([[command mso_safeObjectAtIndex:2] integerValue]);
    self.data = [self.data stringByAppendingString:[command mso_safeObjectAtIndex:3]];
}

@end


@implementation MSOSDKResponseNetserverQuery

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _pages = [command mso_safeObjectAtIndex:2];
        _data = [self fullData:command breakpoint:3];
    }
    return self;
}

- (void)appendResponse:(NSArray *)response {
    self.status = [response mso_safeObjectAtIndex:1];
    _pages = [response mso_safeObjectAtIndex:2];
    NSString *data = [self fullData:response breakpoint:3];
    data = [data stringByReplacingOccurrencesOfString:@"<NewDataSet>" withString:@""];
    data = [data stringByReplacingOccurrencesOfString:@"</NewDataSet>" withString:@""];
    _data = [_data stringByReplacingOccurrencesOfString:@"<NewDataSet>" withString:@""];
    _data = [_data stringByReplacingOccurrencesOfString:@"</NewDataSet>" withString:@""];
    _data = [_data stringByAppendingString:data];
    NSMutableString *formattedData = [_data mutableCopy];
    [formattedData insertString:@"<NewDataSet>" atIndex:0];
    [formattedData appendString:@"</NewDataSet>"];
    _data = [formattedData copy];
}


@end

@implementation MSOSDKResponseNetserverQueryProducts

@end

@implementation MSOSDKResponseNetserverQueryCustomers

@end

@implementation MSOSDKResponseNetserverQueryCustomerSalesOrders

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _objectCount = @([[command mso_safeObjectAtIndex:2] integerValue]);
        _data = [command mso_safeObjectAtIndex:3];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverQuerySalesOrder

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _objectCount = @([[command mso_safeObjectAtIndex:2] integerValue]);

        if ([command count] >= 5) {
            _data = [command mso_safeObjectAtIndex:4];
            return self;
        }
        
        NSString *data = [command mso_safeObjectAtIndex:3];
        _data = data;
    }
    return self;
}

- (void)mso_appendResponse:(NSArray *)response {
    _objectCount = @([[response mso_safeObjectAtIndex:2] integerValue]);
    NSString *data = [response mso_safeObjectAtIndex:3];
    _data = [_data stringByAppendingString:data];
}

@end


@implementation MSOSDKResponseNetserverQueryImages

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        NSUInteger count = [command count];
        NSInteger index = 3;
        if (index < count) {
            NSRange range = NSMakeRange(index, count - index);
            _images = [command subarrayWithRange:range];
        } else {
            _images = [NSArray array];
        }
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSaveImage

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _identifier = [command mso_safeObjectAtIndex:2];
        _message = [command mso_safeObjectAtIndex:3];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSubmitSalesOrder

- (instancetype)initWithCommand:(NSArray *)command {
    
    self = [super initWithCommand:command];
    if (self) {
        _objectCount = @([[command mso_safeObjectAtIndex:2] integerValue]);
        _orderNumber = [command mso_safeObjectAtIndex:3];
        _customerName = [command mso_safeObjectAtIndex:4];

        if (_customerName) {
            _customerAccountNumber = [_customerName mso_stringBetweenString:@"[" andString:@"]"];
            NSString *replacement = [NSString stringWithFormat:@" [%@]", _customerAccountNumber];
            _customerName = [_customerName stringByReplacingOccurrencesOfString:replacement withString:@""];
        }
        
        //_customerName = [command mso_safeObjectAtIndex:5];
        //_customerName = [command mso_safeObjectAtIndex:6];
        //_customerName = [command mso_safeObjectAtIndex:7];
        
    }
    return self;
    
}

@end


@implementation MSOSDKResponseNetserverPing

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _extendedCommand = [command mso_safeObjectAtIndex:2];
        _eventId = [command mso_safeObjectAtIndex:3];
        _eventName = [command mso_safeObjectAtIndex:4];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverLogin

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        _response = [command componentsJoinedByString:@"^"];
        
        _userId = [command mso_safeObjectAtIndex:2];
        _message = [command mso_safeObjectAtIndex:3];
    }
    return self;
}

@end

@implementation MSOSDKResponseNetserverSettings

- (instancetype)initWithCommand:(NSArray *)command {
    self = [super initWithCommand:command];
    if (self) {
        
        _response = [command componentsJoinedByString:@"^"];
        
        if ([_response hasPrefix:@"Invalid Event."]) {
            
            self.status = [_response mso_stringBetweenString:@"[" andString:@"]"];

            NSUInteger position = [_response rangeOfString:@"]"].location + 2;
            NSUInteger length = [_response length] - position;
            NSRange range = NSMakeRange(position, length);

            self.command = [_response substringWithRange:range];
            
            return self;
        }
        
        // Start at index 2: 0 = Command, 1 = Status
        _keyboardControl                                = @([[command mso_safeObjectAtIndex:2] integerValue]);
        NSString *scannerSetup                              = [command mso_safeObjectAtIndex:3];
        // 4 (TCP WLAN)
        _productPhotoSaveOption                         = @([[command mso_safeObjectAtIndex:5] integerValue]);
        NSString *displayFormat                             = [command mso_safeObjectAtIndex:6];
        // 7 (Dummy)
        // 8 (PDA Prefix ?)
        _minimumOrderAmount                             = @([[command mso_safeObjectAtIndex:9] doubleValue]);
        _multipleCompanies                              = @([[command mso_safeObjectAtIndex:10] boolValue]);
        _recalculateSet                                 = @([[command mso_safeObjectAtIndex:11] boolValue]);
        _recalculatePriceTagAlong                       = @([[command mso_safeObjectAtIndex:12] boolValue]);
        _itemSelectionAlert                             = @([[command mso_safeObjectAtIndex:13] integerValue]);
        _pricingStructure                               = [command mso_safeObjectAtIndex:14];
        _discountRule                                   = @([[command mso_safeObjectAtIndex:15] integerValue]);
        _discountRuleSubtotal                           = @([[command mso_safeObjectAtIndex:16] integerValue]);
        _discountRuleAllowShipping                      = @([[command mso_safeObjectAtIndex:17] boolValue]);
        // 18 (WLAN Submit)
        _eventName                                      = [command mso_safeObjectAtIndex:19];
        _alertIfOrderQuantityMoreThanOnHandQuantity     = @([[command mso_safeObjectAtIndex:20] boolValue]);
        _applyCustomerDiscountAsOrderDiscount           = [command mso_safeObjectAtIndex:21];
        _backupOrder                                    = [command mso_safeObjectAtIndex:22];
        _keepSubmittedOrderCopy                         = [command mso_safeObjectAtIndex:23];
        // 24 999 (Dummy)
        _orderDefaultShipVia                            = [command mso_safeObjectAtIndex:25];
        _orderDefaultTerms                              = [command mso_safeObjectAtIndex:26];
        NSString *autoDefaultQuantityShipDate               = [command mso_safeObjectAtIndex:27];
        _alertBelowMinimumPrice                         = @([[command mso_safeObjectAtIndex:28] boolValue]);
        _orderSortByItemNumber                          = @([[command mso_safeObjectAtIndex:29] boolValue]);
        NSString *salesOrderRequirements                    = [command mso_safeObjectAtIndex:30];
        _salesTax                                       = [command mso_safeObjectAtIndex:31];
        _scanSwipeBadgeMapping                          = @([[command mso_safeObjectAtIndex:32] boolValue]);
        // 33
        // 34
        // 35
        _orderRequiresMinimumItemQuantity               = @([[command mso_safeObjectAtIndex:36] boolValue]);
        _allowCustomAssortment                          = @([[command mso_safeObjectAtIndex:37] boolValue]);
        _optionsIfOrderQuantityMoreThanOnHandQuantity   = @([[command mso_safeObjectAtIndex:38] integerValue]);
        _lastPurchasePricePriority                      = @([[command mso_safeObjectAtIndex:39] boolValue]);
        NSString *eventDefaultTitles                        = [command mso_safeObjectAtIndex:40];
        _salesManagerPrivilegeInTradeshow               = @([[command mso_safeObjectAtIndex:41] boolValue]);
        _salesTaxForSampleSales                         = [command mso_safeObjectAtIndex:42];
        _discountRuleShippingChoice                     = [command mso_safeObjectAtIndex:43];
        _companyPriceLevel                              = [command mso_safeObjectAtIndex:44];
        // 45-53 (Blanks)
//        NSString *licenseInfo                               = [command mso_safeObjectAtIndex:54];
        NSString *printOut                                  = [command mso_safeObjectAtIndex:55];
        _messageCompanyPolicy                           = [command mso_safeObjectAtIndex:56];
        _messageCustomerGreeting                        = [command mso_safeObjectAtIndex:57];
        _messagePayment                                 = [command mso_safeObjectAtIndex:58];
        
        [self parseAutoDefaultQuantityShipDate:autoDefaultQuantityShipDate];
        [self parseScannerSetup:scannerSetup];
        [self parseDisplayFormat:displayFormat];
        [self parsePDAConfigurationII:salesOrderRequirements eventDefaultTitles:eventDefaultTitles];
        [self parsePrintOut:printOut];
        
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
    _formatterPriceItemLevel = [self returnParsedFormatter:priceItemLevel];
    
    NSString *priceTotal = [displayFormatParameters mso_safeObjectAtIndex:1];
    _formatterPriceTotal = [self returnParsedFormatter:priceTotal];
    
    NSString *quantityItemLevel = [displayFormatParameters mso_safeObjectAtIndex:2];
    _formatterQuantityItemLevel = [self returnParsedFormatter:quantityItemLevel];
    
    NSString *quantityTotal = [displayFormatParameters mso_safeObjectAtIndex:3];
    _formatterQuantityTotal = [self returnParsedFormatter:quantityTotal];
    
    NSString *weightItemLevel = [displayFormatParameters mso_safeObjectAtIndex:4];
    _formatterWeightItemLevel = [self returnParsedFormatter:weightItemLevel];
    
    NSString *weightTotal = [displayFormatParameters mso_safeObjectAtIndex:5];
    _formatterWeightTotal = [self returnParsedFormatter:weightTotal];
    
    NSString *volumeItemLevel = [displayFormatParameters mso_safeObjectAtIndex:6];
    _formatterVolumeItemLevel = [self returnParsedFormatter:volumeItemLevel];
    
    NSString *volumeTotal = [displayFormatParameters mso_safeObjectAtIndex:7];
    _formatterVolumeTotal = [self returnParsedFormatter:volumeTotal];
    
}

- (NSNumberFormatter *)returnParsedFormatter:(NSString *)formatter {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    NSScanner* scan = [NSScanner scannerWithString:formatter];
    int val;
    if ([scan scanInt:&val] && [scan isAtEnd]) {
        [format setPositiveFormat:formatter];
        return format;
    }
    
    return format;
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

@end
