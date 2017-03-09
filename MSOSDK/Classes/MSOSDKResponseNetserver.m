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
        
        // Start at index 2: 0 = Command, 1 = Status
        self.keyboardControl                                = @([[command mso_safeObjectAtIndex:2] integerValue]);
        NSString *scannerSetup                              = [command mso_safeObjectAtIndex:3];
        // 4 (TCP WLAN)
        self.productPhotoSaveOption                         = @([[command mso_safeObjectAtIndex:5] integerValue]);
        NSString *displayFormat                             = [command mso_safeObjectAtIndex:6];
        // 7 (Dummy)
        // 8 (PDA Prefix ?)
        self.minimumOrderAmount                             = @([[command mso_safeObjectAtIndex:9] doubleValue]);
        self.multipleCompanies                              = @([[command mso_safeObjectAtIndex:10] boolValue]);
        self.recalculateSet                                 = @([[command mso_safeObjectAtIndex:11] boolValue]);
        self.recalculatePriceTagAlong                       = @([[command mso_safeObjectAtIndex:12] boolValue]);
        self.itemSelectionAlert                             = @([[command mso_safeObjectAtIndex:13] integerValue]);
        self.pricingStructure                               = [command mso_safeObjectAtIndex:14];
        self.discountRule                                   = @([[command mso_safeObjectAtIndex:15] integerValue]);
        self.discountRuleSubtotal                           = @([[command mso_safeObjectAtIndex:16] integerValue]);
        self.discountRuleAllowShipping                      = @([[command mso_safeObjectAtIndex:17] boolValue]);
        // 18 (WLAN Submit)
        self.eventName                                      = [command mso_safeObjectAtIndex:19];
        self.alertIfOrderQuantityMoreThanOnHandQuantity     = @([[command mso_safeObjectAtIndex:20] boolValue]);
        self.applyCustomerDiscountAsOrderDiscount           = [command mso_safeObjectAtIndex:21];
        self.backupOrder                                    = [command mso_safeObjectAtIndex:22];
        self.keepSubmittedOrderCopy                         = [command mso_safeObjectAtIndex:23];
        // 24 999 (Dummy)
        self.orderDefaultShipVia                            = [command mso_safeObjectAtIndex:25];
        self.orderDefaultTerms                              = [command mso_safeObjectAtIndex:26];
        NSString *autoDefaultQuantityShipDate               = [command mso_safeObjectAtIndex:27];
        self.alertBelowMinimumPrice                         = @([[command mso_safeObjectAtIndex:28] boolValue]);
        self.orderSortByItemNumber                          = @([[command mso_safeObjectAtIndex:29] boolValue]);
        NSString *salesOrderRequirements                    = [command mso_safeObjectAtIndex:30];
        self.salesTax                                       = [command mso_safeObjectAtIndex:31];
        self.scanSwipeBadgeMapping                          = @([[command mso_safeObjectAtIndex:32] boolValue]);
        // 33
        // 34
        // 35
        self.orderRequiresMinimumItemQuantity               = @([[command mso_safeObjectAtIndex:36] boolValue]);
        self.allowCustomAssortment                          = @([[command mso_safeObjectAtIndex:37] boolValue]);
        self.optionsIfOrderQuantityMoreThanOnHandQuantity   = @([[command mso_safeObjectAtIndex:38] integerValue]);
        self.lastPurchasePricePriority                      = @([[command mso_safeObjectAtIndex:39] boolValue]);
        NSString *eventDefaultTitles                        = [command mso_safeObjectAtIndex:40];
        self.salesManagerPrivilegeInTradeshow               = @([[command mso_safeObjectAtIndex:41] boolValue]);
        self.salesTaxForSampleSales                         = [command mso_safeObjectAtIndex:42];
        self.discountRuleShippingChoice                     = [command mso_safeObjectAtIndex:43];
        self.companyPriceLevel                              = [command mso_safeObjectAtIndex:44];
        // 45-53 (Blanks)
        NSString *licenseInfo                               = [command mso_safeObjectAtIndex:54];
        NSString *printOut                                  = [command mso_safeObjectAtIndex:55];
        self.messageCompanyPolicy                           = [command mso_safeObjectAtIndex:56];
        self.messageCustomerGreeting                        = [command mso_safeObjectAtIndex:57];
        self.messagePayment                                 = [command mso_safeObjectAtIndex:58];
        
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
        self.defaultQuantityToPreviousEntry = @1;
        self.defaultShipDateToPreviousEntry = @0;
        return;
    }
    
    if ([autoDefaultQuantityShipDate isEqualToString:@"2"]) {
        self.defaultQuantityToPreviousEntry = @0;
        self.defaultShipDateToPreviousEntry = @1;
        return;
    }
    
    if ([autoDefaultQuantityShipDate isEqualToString:@"3"]) {
        self.defaultQuantityToPreviousEntry = @1;
        self.defaultShipDateToPreviousEntry = @1;
        return;
    }
    
    self.defaultQuantityToPreviousEntry = @0;
    self.defaultShipDateToPreviousEntry = @0;
}

- (void)parseDisplayFormat:(NSString *)displayFormat {
    NSArray *displayFormatParameters = [displayFormat componentsSeparatedByString:@"|"];
    
    NSString *priceItemLevel = [displayFormatParameters mso_safeObjectAtIndex:0];
    self.formatterPriceItemLevel = [self returnParsedFormatter:priceItemLevel];
    
    NSString *priceTotal = [displayFormatParameters mso_safeObjectAtIndex:1];
    self.formatterPriceTotal = [self returnParsedFormatter:priceTotal];
    
    NSString *quantityItemLevel = [displayFormatParameters mso_safeObjectAtIndex:2];
    self.formatterQuantityItemLevel = [self returnParsedFormatter:quantityItemLevel];
    
    NSString *quantityTotal = [displayFormatParameters mso_safeObjectAtIndex:3];
    self.formatterQuantityTotal = [self returnParsedFormatter:quantityTotal];
    
    NSString *weightItemLevel = [displayFormatParameters mso_safeObjectAtIndex:4];
    self.formatterWeightItemLevel = [self returnParsedFormatter:weightItemLevel];
    
    NSString *weightTotal = [displayFormatParameters mso_safeObjectAtIndex:5];
    self.formatterWeightTotal = [self returnParsedFormatter:weightTotal];
    
    NSString *volumeItemLevel = [displayFormatParameters mso_safeObjectAtIndex:6];
    self.formatterVolumeItemLevel = [self returnParsedFormatter:volumeItemLevel];
    
    NSString *volumeTotal = [displayFormatParameters mso_safeObjectAtIndex:7];
    self.formatterVolumeTotal = [self returnParsedFormatter:volumeTotal];
    
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
    
    self.scannerSetupReadCountryCode = @([[scannerSetupParameters mso_safeObjectAtIndex:0] doubleValue]);
    self.scannerSetupReadSystemCodePrefix = @([[scannerSetupParameters mso_safeObjectAtIndex:1] doubleValue]);
    self.scannerSetupReadChecksumDigit = @([[scannerSetupParameters mso_safeObjectAtIndex:2] doubleValue]);
}

- (void)parsePrintOut:(NSString *)printOut {
    NSArray *printOutParameters = [printOut componentsSeparatedByString:@"|"];
    
    NSString *showQuantityPriceWhenSellingBulk = [printOutParameters mso_safeObjectAtIndex:0];
    if ([showQuantityPriceWhenSellingBulk isEqualToString:@"B"]) {
        self.printIfBulkSellingShowPrice = @1;
        self.printIfBulkSellingShowQuantity = @0;
    } else if ([showQuantityPriceWhenSellingBulk isEqualToString:@"C"]) {
        self.printIfBulkSellingShowPrice = @0;
        self.printIfBulkSellingShowQuantity = @1;
    } else {
        self.printIfBulkSellingShowPrice = @0;
        self.printIfBulkSellingShowQuantity = @0;
    }
    
    self.printCustomerRep       = @([[printOutParameters mso_safeObjectAtIndex:1] boolValue]);
    self.printUPC               = @([[printOutParameters mso_safeObjectAtIndex:3] boolValue]);
    self.printItemDescription2  = @([[printOutParameters mso_safeObjectAtIndex:2] boolValue]);
    self.printItemVendorName    = @([[printOutParameters mso_safeObjectAtIndex:9] boolValue]);
    self.printManufacturerName  = @([[printOutParameters mso_safeObjectAtIndex:10] boolValue]);
    self.printShowOrderTotal    = @(![[printOutParameters mso_safeObjectAtIndex:6] boolValue]);
    
    self.printMSRP                          = @([[printOutParameters mso_safeObjectAtIndex:11] boolValue]);
    self.printPrice                         = @([[printOutParameters mso_safeObjectAtIndex:12] boolValue]);
    self.printItemColorSizeAbbreviation     = @([[printOutParameters mso_safeObjectAtIndex:13] boolValue]);
    self.printItemWeight                    = @([[printOutParameters mso_safeObjectAtIndex:14] boolValue]);
    self.printTotalWeight                   = @([[printOutParameters mso_safeObjectAtIndex:4] boolValue]);
    self.printItemVolume                    = @([[printOutParameters mso_safeObjectAtIndex:15] boolValue]);
    self.printTotalVolume                   = @([[printOutParameters mso_safeObjectAtIndex:5] boolValue]);
    
    self.printItemDiscountIfDiscounted      = @([[printOutParameters mso_safeObjectAtIndex:7] boolValue]);
    
    self.printSortByItemNumber              = @([[printOutParameters mso_safeObjectAtIndex:8] boolValue]);
}

- (void)parsePDAConfigurationII:(NSString *)salesOrderRequirements eventDefaultTitles:(NSString *)eventDefaultTitles {
    NSArray *salesOrderRequirementsParameters = [salesOrderRequirements componentsSeparatedByString:@"|"];
    
    self.orderRequiresAddress       = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:0] boolValue]);
    self.orderRequiresPhone         = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:1] boolValue]);
    self.orderRequiresEmail         = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:2] boolValue]);
    self.orderRequiresShipDate      = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:3] boolValue]);
    self.orderRequiresCancelDate    = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:4] boolValue]);
    self.orderRequiresPONumber      = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:5] boolValue]);
    
    self.orderRequiresBuyerName     = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:6] boolValue]);
    self.orderRequiresFOB           = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:7] boolValue]);
    self.orderRequiresWarehouse     = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:8] boolValue]);
    self.orderRequiresCreditCard    = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:9] boolValue]);
    self.orderRequiresPaymentTerms  = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:10] boolValue]);
    
    self.staticCreditCard           = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:11] boolValue]);
    self.staticPaymentTerms         = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:12] boolValue]);
    
    self.orderRequiredMinimumOrderAmountForMasterOrder = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:13] boolValue]);
    self.allowCustomTermsShipViaFOB                    = @(![[salesOrderRequirementsParameters mso_safeObjectAtIndex:14] boolValue]);
    self.orderRequiredMinimumOrderAmountForEachCompany = @([[salesOrderRequirementsParameters mso_safeObjectAtIndex:15] boolValue]);
    
    NSArray *eventDefaultTitlesParameters = [eventDefaultTitles componentsSeparatedByString:@"|"];
    
    self.userDefinedProductLine = [eventDefaultTitlesParameters mso_safeObjectAtIndex:0];
    self.userDefinedCategory = [eventDefaultTitlesParameters mso_safeObjectAtIndex:1];
    self.userDefinedSeason = [eventDefaultTitlesParameters mso_safeObjectAtIndex:2];
}

@end
