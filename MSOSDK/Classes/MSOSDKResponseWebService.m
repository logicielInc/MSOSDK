//
//  MSOSDKResponseWebService.m
//  iMobileRep
//
//  Created by John Setting on 2/14/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDKResponseWebService.h"

#import <SMXMLDocument/SMXMLDocument.h>

#import "MSOSDK.h"
#import "NSError+MSOSDKAdditions.h"
#import "NSArray+MSOSDKAdditions.h"

@implementation MSOSDKResponseWebService

+ (instancetype)msosdk_commandWithResponse:(id)response {
    return [[self alloc] initWithResponse:response];
}

- (instancetype)initWithResponse:(id)response {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSDateFormatter *)msosdk_webservice_dateformatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    });
    return dateFormatter;
}

+ (kMSOSDKResponseWebServiceStatus)status:(NSString *)status {
    
    if ([status isEqualToString:@"0"]) {
        return kMSOSDKResponseWebServiceStatusNotFound;
    }
    
    if ([status isEqualToString:@"00"]) {
        return kMSOSDKResponseWebServiceStatusUnregistered;
    }
    
    if ([status isEqualToString:@"1"]) {
        return kMSOSDKResponseWebServiceStatusExpired;
    }
    
    if ([status isEqualToString:@"11"]) {
        return kMSOSDKResponseWebServiceStatusDisabled;
    }
    
    if ([status isEqualToString:@"-1"]) {
        return kMSOSDKResponseWebServiceStatusSuspended;
    }
    
    if ([status isEqualToString:@"-2"]) {
        return kMSOSDKResponseWebServiceStatusInvalid;
    }
    
    if ([status isEqualToString:@"2"]) {
        return kMSOSDKResponseWebServiceStatusSuccess;
    }

    return kMSOSDKResponseWebServiceStatusUnknown;
}

+ (NSError *)errorFromStatus:(kMSOSDKResponseWebServiceStatus)status {

    if (status == kMSOSDKResponseWebServiceStatusNotFound) {
        return [NSError mso_internet_registration_key_not_found];
    }
    
    if (status == kMSOSDKResponseWebServiceStatusUnregistered) {
        return [NSError mso_internet_registration_key_unregistered];
    }
    
    if (status == kMSOSDKResponseWebServiceStatusExpired) {
        return [NSError mso_internet_registration_key_expired];
    }
    
    if (status == kMSOSDKResponseWebServiceStatusDisabled) {
        return [NSError mso_internet_registration_key_disabled];
    }
    
    if (status == kMSOSDKResponseWebServiceStatusSuspended) {
        return [NSError mso_internet_registration_key_suspended];
    }
    
    if (status == kMSOSDKResponseWebServiceStatusInvalid) {
        return [NSError mso_internet_login_credientials_invalid];
    }
    
    if (status == kMSOSDKResponseWebServiceStatusUnknown) {
        return [NSError mso_internet_login_credientials_invalid];
    }
    
    return nil;
}

@end

@implementation MSOSDKResponseWebServiceCredentials

- (instancetype)initWithResponse:(NSArray *)response {
    self = [super initWithResponse:response];
    if (self) {
        NSString *status = [response mso_safeObjectAtIndex:0];
        _status = [MSOSDKResponseWebService status:status];
        NSString *date = [response mso_safeObjectAtIndex:1];
        NSDateFormatter *formatter = [MSOSDKResponseWebService msosdk_webservice_dateformatter];
        _dateCreated = [formatter dateFromString:date];
    }
    return self;
}

@end

@implementation MSOSDKResponseWebServiceRegister

- (instancetype)initWithResponse:(NSString *)response {
    self = [super initWithResponse:response];
    if (self) {
        NSArray *components = [response componentsSeparatedByString:@"-"];
        
        // Typical Format
        // unlockcode-showType-pin-[companyName, inc.],[john],[accesskey]
        if ([components count] > 2) {
            
            _code = [components mso_safeObjectAtIndex:0];
            _type = [components mso_safeObjectAtIndex:1];
            _pin = [components mso_safeObjectAtIndex:2];
            
            NSString *stringToRemove = [NSString stringWithFormat:@"%@-%@-%@-", _code, _type, _pin];
            NSString *removed = [response stringByReplacingOccurrencesOfString:stringToRemove withString:@""];
            NSArray *components = [removed componentsSeparatedByString:@"],["];

            if ([components count] > 2) {
                NSString *company = [components mso_safeObjectAtIndex:0];
                NSArray *cds = [NSArray arrayWithObjects:_code, _type, _pin, [company stringByAppendingString:@"]"], nil];
                _cds = [cds componentsJoinedByString:@"-"];
                _company = [[company stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
                _rep = [[[components mso_safeObjectAtIndex:1] stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
                _key = [[[components mso_safeObjectAtIndex:2] stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
                _key = [_key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
        }
    }
    return self;
}

@end

@implementation MSOSDKResponseWebServiceRequestData



@end

@implementation MSOSDKResponseWebServiceFilesToDownload

- (instancetype)initWithResponse:(SMXMLDocument *)response {
    self = [super initWithResponse:response];
    if (self) {

        NSArray <SMXMLElement *> *element = response.children;
        SMXMLElement *parent = [element firstObject];
        SMXMLElement *child = [parent descendantWithPath:@"_iCheckMobileFileForDownloadingResponse"];
        SMXMLElement *filesToDownload = [child descendantWithPath:@"_iCheckMobileFileForDownloadingResult"];
        NSArray <SMXMLElement *> *files = [filesToDownload children];
        SMXMLElement *updatedDate = [child descendantWithPath:@"sLastUpdateDate"];
        NSString *updatedDateFormatted = updatedDate.value;
        _files = [NSArray array];
        
        for (SMXMLElement *file in files) {
            NSString *value = file.value;
            _files = [_files arrayByAddingObject:value];
        }
        
        NSDate *dateFormatted = [MSOSDK dateFromString:updatedDateFormatted];
        _dateUpdated = dateFormatted;

        
    }
    return self;
}


@end

@implementation MSOSDKResponseWebServiceDownloadHistory

- (instancetype)initWithResponse:(SMXMLDocument *)response {
    self = [super initWithResponse:response];
    if (self) {
        
        SMXMLElement *result = [response descendantWithPath:@"Body._iCheckPDAHistoryForDownloadingResponse._iCheckPDAHistoryForDownloadingResult"];
        SMXMLElement *list = [response descendantWithPath:@"Body._iCheckPDAHistoryForDownloadingResponse.lstQuery"];

        _resultCount = @([result.value integerValue]);
        
        // If there are no results, no need to parse any further
        if ([_resultCount integerValue] == 0) {
            return self;
        }
        
        _list = list;
        
    }
    return self;
}

@end

@implementation MSOSDKResponseWebServiceCatalog

- (instancetype)initWithResponse:(NSArray *)response {
    
    self = [super init];
    if (self) {
        NSString* filename     = [[response objectAtIndex:0] stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSString* lastUpdate   = [response objectAtIndex:1];
        NSString* filesize     = [[response objectAtIndex:2] stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        self.command = _CheckCatalogFileStatus;
        _filename = filename;
        _filesize = @([filesize longLongValue]);
        _dateUpdated = [MSOSDK dateFromString:lastUpdate];

    }
    return self;
    
}

@end

@implementation MSOSDKResponseWebServicePhotoDetails

+ (NSDateFormatter *)formatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    return dateFormatter;
}

+ (instancetype)detailsWithValue:(NSString *)value {
    return [[self alloc] initWithValue:value];
}

- (instancetype)initWithValue:(NSString *)value {
    self = [super init];
    if (self) {
        NSArray *components = [value componentsSeparatedByString:@"]["];
        NSString *filename = [components objectAtIndex:0];
        NSString *dateUploaded = [components objectAtIndex:1];
        NSString *identifier = [components objectAtIndex:2];
        
        filename = [filename stringByReplacingOccurrencesOfString:@"[" withString:@""];
        identifier = [identifier stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        _filename = filename;
        _dateUploaded = [[MSOSDKResponseWebServicePhotoDetails formatter] dateFromString:dateUploaded];
        _id = identifier;
        
    }
    
    return self;
}

@end
