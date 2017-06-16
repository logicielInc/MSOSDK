//
//  MSOSDKResponseNetserver.h
//  iMobileRep
//
//  Created by John Setting on 2/14/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSError+MSOSDKAdditions.h"

/**
 `MSOSDKResponseNetserver` adopts `NSObject` and is the general response object that all Netserver response objects adopt.
 */
@interface MSOSDKResponseNetserver : NSObject

- (nullable instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithResponseObject:(nonnull MSOSDKResponseNetserver *)responseObject error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 The general initializer for an `MSOSDKResponseNetserver` object.

 @param response A `^` seperated response. Some responses contain `^` in the XML so this may be bad practice
 @return `MSOSDKResponseNetserver` object
 */
+ (nullable instancetype)msosdk_commandWithResponse:(nullable NSString *)response error:(NSError * _Nullable __autoreleasing * _Nullable)error;

+ (nullable instancetype)msosdk_commandWithResponseObject:(nonnull MSOSDKResponseNetserver *)responseObject error:(NSError * _Nullable __autoreleasing * _Nullable)error;


/**
 The command of the request made (e.g _P001). If there are multiple pages to further append to this request, the command will result in _X001. Which means there are more requests to be made to complete the xml response
 */
@property (copy, nonatomic, nullable) NSString *command;

/**
 The status either results in NO, OK, or nil
 */
@property (copy, nonatomic, nullable) NSString *status;

@property (copy, nonatomic, nullable) NSArray <NSString *> *trailingResponse;
@end



@interface MSOSDKResponseNetserverProductsCount : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSNumber *productCount;
@end

// Need to find out why 2 account numbers and other responses that can occur
@interface MSOSDKResponseNetserverSaveCustomer : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSNumber *objectsSavedCount;
@property (strong, nonatomic, nullable) NSString *mainstoreNumber;
@property (strong, nonatomic, nullable) NSString *accountNumber;
@property (strong, nonatomic, nullable) NSString *terms;
@property (strong, nonatomic, nullable) NSNumber *priceLevel;
@end

@interface MSOSDKResponseNetserverUpdateCustomer : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSNumber *objectsSavedCount;
@property (strong, nonatomic, nullable) NSString *message;
@end

@interface MSOSDKResponseNetserverSaveCustomerShippingAddress : MSOSDKResponseNetserverSaveCustomer
@property (strong, nonatomic, nullable) NSString *customerName;
@property (strong, nonatomic, nullable) NSString *contactName;
@property (strong, nonatomic, nullable) NSString *address1;
@property (strong, nonatomic, nullable) NSString *address2;
@property (strong, nonatomic, nullable) NSString *city;
@property (strong, nonatomic, nullable) NSString *state;
@property (strong, nonatomic, nullable) NSString *zip;
@property (strong, nonatomic, nullable) NSString *country;
@property (strong, nonatomic, nullable) NSString *phone;
@property (strong, nonatomic, nullable) NSString *fax;
@property (strong, nonatomic, nullable) NSString *email;

@end

@interface MSOSDKResponseNetserverSync : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSNumber *objectCount;
@property (strong, nonatomic, nullable) NSString *nextIndex;
@property (strong, nonatomic, nullable) NSString *data;
@end

@interface MSOSDKResponseNetserverSyncSettings : MSOSDKResponseNetserverSync
@end

@interface MSOSDKResponseNetserverSyncCustomers : MSOSDKResponseNetserverSync
@end

@interface MSOSDKResponseNetserverSyncSaveCustomerMapping : MSOSDKResponseNetserverSync
@end

@interface MSOSDKResponseNetserverSyncUpdateCustomerMapping : MSOSDKResponseNetserverSync
@end

@interface MSOSDKResponseNetserverSyncProducts : MSOSDKResponseNetserverSync
@property (strong, nonatomic, nullable) NSString *companyId;
@end


@interface MSOSDKResponseNetserverSyncPurchaseHistory : MSOSDKResponseNetserverSync
- (void)mso_appendResponseObject:(nullable MSOSDKResponseNetserverSyncPurchaseHistory *)responseObject;
@property (strong, nonatomic, nullable) NSString *nextId;
@property (strong, nonatomic, nullable) NSNumber *detailLoop;
@end

@interface MSOSDKResponseNetserverQuery : MSOSDKResponseNetserver
- (void)mso_appendResponseObject:(nullable MSOSDKResponseNetserverQuery *)responseObject;
@property (strong, nonatomic, nullable) NSString *data;
@property (strong, nonatomic, nullable) NSString *pages;
@end

@interface MSOSDKResponseNetserverQueryProducts : MSOSDKResponseNetserverQuery
@end

@interface MSOSDKResponseNetserverQueryCustomers : MSOSDKResponseNetserverQuery
@end

@interface MSOSDKResponseNetserverQueryCustomerSalesOrders : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSNumber *objectCount;
@property (strong, nonatomic, nullable) NSString *data;
@end

@interface MSOSDKResponseNetserverQuerySalesOrder : MSOSDKResponseNetserver
- (void)mso_appendResponseObject:(nullable MSOSDKResponseNetserverQuerySalesOrder *)responseObject;
@property (assign, nonatomic) BOOL itemSetRemaining;
@property (strong, nonatomic, nullable) NSNumber *objectCount;
@property (strong, nonatomic, nullable) NSString *data;
@property (strong, nonatomic, nullable) NSString *itemSet;
@end

@interface MSOSDKResponseNetserverQueryImages : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSNumber *objectCount;
@property (strong, nonatomic, nullable) NSArray <NSString *> *images;
@end

@interface MSOSDKResponseNetserverSaveImage : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSString *identifier;
@property (strong, nonatomic, nullable) NSString *message;
@end

@interface MSOSDKResponseNetserverSubmitSalesOrder : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSNumber *objectCount;
@property (strong, nonatomic, nullable) NSString *orderNumber;
@property (strong, nonatomic, nullable) NSString *customerName;
@property (strong, nonatomic, nullable) NSString *customerAccountNumber;

/*
@property (strong, nonatomic, nullable) NSString *identifier;
@property (strong, nonatomic, nullable) NSString *identifier;
@property (strong, nonatomic, nullable) NSString *identifier;
*/
@end


@interface MSOSDKResponseNetserverPing : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSString *extendedCommand;
@property (strong, nonatomic, nullable) NSString *eventId;
@property (strong, nonatomic, nullable) NSString *eventName;
@end

@interface MSOSDKResponseNetserverLogin : MSOSDKResponseNetserver
@property (strong, nonatomic, nullable) NSString *response;

@property (strong, nonatomic, nullable) NSString *userId;
@property (strong, nonatomic, nullable) NSNumber *manager;
@property (strong, nonatomic, nullable) NSNumber *foundPriceLevels;
@property (strong, nonatomic, nullable) NSNumber *priceLevelAllow1;
@property (strong, nonatomic, nullable) NSNumber *priceLevelAllow2;
@property (strong, nonatomic, nullable) NSNumber *priceLevelAllow3;
@property (strong, nonatomic, nullable) NSNumber *priceLevelAllow4;
@property (strong, nonatomic, nullable) NSNumber *priceLevelAllow5;
@property (strong, nonatomic, nullable) NSNumber *allowUserDefinedPriceLevel;
@end

typedef NS_ENUM(NSInteger, kMSOSDKResponseNetserverSettingsRedAlertIfOrderQuantityGreaterThanOnHand) {
    kMSOSDKResponseNetserverSettingsRedAlertIfOrderQuantityGreaterThanOnHandItemSetup      = 0,
    kMSOSDKResponseNetserverSettingsRedAlertIfOrderQuantityGreaterThanOnHandBackOrder,
    kMSOSDKResponseNetserverSettingsRedAlertIfOrderQuantityGreaterThanOnHandOfferChoice,
};

typedef NS_ENUM(NSInteger, kMSOSDKResponseNetserverSettingsBehaviorWhenEnteringItem) {
    kMSOSDKResponseNetserverSettingsBehaviorWhenEnteringItemAlwaysAppend        = 0,
    kMSOSDKResponseNetserverSettingsBehaviorWhenEnteringItemAlwaysRetrieve,
    kMSOSDKResponseNetserverSettingsBehaviorWhenEnteringItemOfferChoice,
};

@interface MSOSDKResponseNetserverSettings : MSOSDKResponseNetserver

@property (strong, nonatomic, nullable) NSNumber *companyPriceLevel;
@property (strong, nonatomic, nullable) NSNumber *workPeriodControl;
@property (strong, nonatomic, nullable) NSString *eventInterval;
@property (strong, nonatomic, nullable) NSString *oneCustomerListInfo;

/// if yes, multiple companies, else, single company
@property (strong, nonatomic, nullable) NSNumber *multipleCompanies;
@property (strong, nonatomic, nullable) NSNumber *allowCustomAssortment;

@property (strong, nonatomic, nullable) NSString *eventName;
@property (strong, nonatomic, nullable) NSString *eventId;
@property (strong, nonatomic, nullable) NSString *backupOrder;
@property (strong, nonatomic, nullable) NSNumber *keepSubmittedOrderCopy;
@property (strong, nonatomic, nullable) NSString *terms;
@property (strong, nonatomic, nullable) NSString *shipTo;

@property (strong, nonatomic, nullable) NSString *companyName;
@property (strong, nonatomic, nullable) NSString *email;
@property (strong, nonatomic, nullable) NSString *website;
@property (strong, nonatomic, nullable) NSString *pin;
@property (strong, nonatomic, nullable) NSString *address1;
@property (strong, nonatomic, nullable) NSString *address2;
@property (strong, nonatomic, nullable) NSString *city;
@property (strong, nonatomic, nullable) NSString *phone1;
@property (strong, nonatomic, nullable) NSString *phone2;
@property (strong, nonatomic, nullable) NSString *state;
@property (strong, nonatomic, nullable) NSString *country;
@property (strong, nonatomic, nullable) NSString *zip;
@property (strong, nonatomic, nullable) NSString *fax;

@property (strong, nonatomic, nullable) NSString *bulkSellingDescription;

#pragma mark - Customer
@property (strong, nonatomic, nullable) NSNumber *lastPurchasePricePriority;

#pragma mark - Event Settings

#pragma mark S.O. Message
@property (strong, nonatomic, nullable) NSString *messageCompanyPolicy;
@property (strong, nonatomic, nullable) NSString *messageCustomerGreeting;
@property (strong, nonatomic, nullable) NSString *messagePayment;

#pragma mark Customized S.O.
/**
 NOTE : 17 Elements (first and last can be empty strings)
 NOTE : Unsent fields
 - Print Photo on Customer Copy
 - Print Photo on Merchant Copy
 - Print Barcode on Customer Copy
 - Print Barcode on Merchant Copy
 - Mask Credit Card Info On Merchant Copy
 - Suppress C/P
 - For Tag Along/Set Items, Show Basic Info Only
 - Print Total Items and Units
 - Print Order Log
 - Suppress Price when Price = 0
 - Show Item# & Description only when Price = 0
 */
@property (strong, nonatomic, nullable) NSNumber *printUPC;
@property (strong, nonatomic, nullable) NSNumber *printItemDescription2;
@property (strong, nonatomic, nullable) NSNumber *printItemVendorName;
@property (strong, nonatomic, nullable) NSNumber *printManufacturerName;
@property (strong, nonatomic, nullable) NSNumber *printShowOrderTotal;
@property (strong, nonatomic, nullable) NSNumber *printSortByItemNumber;
@property (strong, nonatomic, nullable) NSNumber *printMSRP;
@property (strong, nonatomic, nullable) NSNumber *printPrice;
@property (strong, nonatomic, nullable) NSNumber *printItemColorSizeAbbreviation;
@property (strong, nonatomic, nullable) NSNumber *printItemWeight;
@property (strong, nonatomic, nullable) NSNumber *printTotalWeight;
@property (strong, nonatomic, nullable) NSNumber *printItemVolume;
@property (strong, nonatomic, nullable) NSNumber *printTotalVolume;
@property (strong, nonatomic, nullable) NSNumber *printItemDiscountIfDiscounted;
@property (strong, nonatomic, nullable) NSNumber *printIfBulkSellingShowQuantity;
@property (strong, nonatomic, nullable) NSNumber *printIfBulkSellingShowPrice;

// This is shown in Event -> Setup -> Information -> Under Source Code (Use Customer's Sales Rep. on Sales Order)
@property (strong, nonatomic, nullable) NSNumber *printCustomerRep;


#pragma mark Configuration I
@property (strong, nonatomic, nullable) NSNumber *salesTax;
@property (strong, nonatomic, nullable) NSNumber *salesTaxForSampleSales;
@property (strong, nonatomic, nullable) NSNumber *minimumOrderAmount;
@property (strong, nonatomic, nullable) NSString *orderDefaultTerms;
@property (strong, nonatomic, nullable) NSString *orderDefaultShipVia;
@property (strong, nonatomic, nullable) NSNumber *orderSortByItemNumber;
@property (strong, nonatomic, nullable) NSString *pricingStructure;

@property (strong, nonatomic, nullable) NSNumber *discountRule;
@property (strong, nonatomic, nullable) NSNumber *discountRuleSubtotal;

@property (strong, nonatomic, nullable) NSNumber *discountRuleShippingChoice;
@property (strong, nonatomic, nullable) NSNumber *discountRuleAllowShipping;

#pragma mark Configuration II
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterPriceItemLevel;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterPriceTotal;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterQuantityItemLevel;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterQuantityTotal;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterWeightItemLevel;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterWeightTotal;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterVolumeItemLevel;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatterVolumeTotal;

/**
 @brief MSO will return back 3 results: Always Append, Always Retrieve, Offer Choice
 */
@property (assign, nonatomic) kMSOSDKResponseNetserverSettingsBehaviorWhenEnteringItem behaviorWhenEnteringItem;
@property (strong, nonatomic, nullable) NSNumber *recalculateSet;
@property (strong, nonatomic, nullable) NSNumber *recalculatePriceTagAlong;
@property (strong, nonatomic, nullable) NSNumber *alertIfOrderQuantityMoreThanOnHandQuantity;
/**
 @brief MSO will return back 3 results: Item Setup, Back Order, Offer Choice
 */
@property (assign, nonatomic) kMSOSDKResponseNetserverSettingsRedAlertIfOrderQuantityGreaterThanOnHand optionsIfOrderQuantityGreaterThanOnHandQuantity;
@property (strong, nonatomic, nullable) NSNumber *alertBelowMinimumPrice;
@property (strong, nonatomic, nullable) NSNumber *applyCustomerDiscountAsOrderDiscount;
@property (strong, nonatomic, nullable) NSNumber *defaultQuantityToPreviousEntry;
@property (strong, nonatomic, nullable) NSNumber *defaultShipDateToPreviousEntry;

#pragma mark PDA Configuration I

/**
 NOTE : Unsent fields
 - Scan Swipe Badge Mapping
 */

@property (strong, nonatomic, nullable) NSNumber *keyboardControl;
@property (strong, nonatomic, nullable) NSNumber *productPhotoSaveOption;

@property (strong, nonatomic, nullable) NSNumber *scannerSetupReadCountryCode;
@property (strong, nonatomic, nullable) NSNumber *scannerSetupReadSystemCodePrefix;
@property (strong, nonatomic, nullable) NSNumber *scannerSetupReadChecksumDigit;

@property (strong, nonatomic, nullable) NSNumber *scanSwipeBadgeMapping;

#pragma mark PDA Configuration II

/**
 NOTE : Unsent fields
 - Initiate Sales Order Printing from Host PC Only
 - Bill Date = Ship Date (Days)
 */
@property (strong, nonatomic, nullable) NSNumber *orderRequiresAddress;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresPhone;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresEmail;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresShipDate;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresCancelDate;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresPONumber;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresBuyerName;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresFOB;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresWarehouse;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresCreditCard;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresPaymentTerms;
@property (strong, nonatomic, nullable) NSNumber *orderRequiredMinimumOrderAmountForMasterOrder;
@property (strong, nonatomic, nullable) NSNumber *orderRequiredMinimumOrderAmountForEachCompany;
@property (strong, nonatomic, nullable) NSNumber *staticCreditCard;
@property (strong, nonatomic, nullable) NSNumber *staticPaymentTerms;
@property (strong, nonatomic, nullable) NSNumber *allowCustomTermsShipViaFOB;
@property (strong, nonatomic, nullable) NSNumber *orderRequiresMinimumItemQuantity;
@property (strong, nonatomic, nullable) NSNumber *salesManagerPrivilegeInTradeshow;
@property (strong, nonatomic, nullable) NSString *userDefinedProductLine;
@property (strong, nonatomic, nullable) NSString *userDefinedCategory;
@property (strong, nonatomic, nullable) NSString *userDefinedSeason;

- (BOOL)productPricing;
- (nullable NSString *)formattedCompanyAddress;
- (nullable NSString *)formattedEventName;

@end
