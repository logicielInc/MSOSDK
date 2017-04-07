//
//  MSOSDKResponseWebserver.m
//  iMobileRep
//
//  Created by John Setting on 2/14/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOSDKResponseWebserver.h"

@implementation MSOSDKResponseWebserver

+ (instancetype)msosdk_commandWithResponse:(NSString *)response command:(NSString *)command error:(NSError * _Nullable __autoreleasing *)error {
    return [[self alloc] initWithResponse:response command:command error:error];
}

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError * _Nullable __autoreleasing *)error {
    [[NSException
      exceptionWithName:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]
      reason:@"This method needs to be overriden"
      userInfo:nil]
     raise];
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

+ (kMSOSDKResponseWebserverStatus)status:(NSString *)status {
    
    if ([status isEqualToString:@"0"]) {
        return kMSOSDKResponseWebserverStatusNotFound;
    }
    
    if ([status isEqualToString:@"00"]) {
        return kMSOSDKResponseWebserverStatusUnregistered;
    }
    
    if ([status isEqualToString:@"1"]) {
        return kMSOSDKResponseWebserverStatusExpired;
    }
    
    if ([status isEqualToString:@"11"]) {
        return kMSOSDKResponseWebserverStatusDisabled;
    }
    
    if ([status isEqualToString:@"-1"]) {
        return kMSOSDKResponseWebserverStatusSuspended;
    }
    
    if ([status isEqualToString:@"-2"]) {
        return kMSOSDKResponseWebserverStatusInvalid;
    }
    
    if ([status isEqualToString:@"2"]) {
        return kMSOSDKResponseWebserverStatusSuccess;
    }

    return kMSOSDKResponseWebserverStatusUnknown;
}

+ (NSError *)errorFromStatus:(kMSOSDKResponseWebserverStatus)status {

    if (status == kMSOSDKResponseWebserverStatusNotFound) {
        return [NSError mso_internet_registration_key_not_found];
    }
    
    if (status == kMSOSDKResponseWebserverStatusUnregistered) {
        return [NSError mso_internet_registration_key_unregistered];
    }
    
    if (status == kMSOSDKResponseWebserverStatusExpired) {
        return [NSError mso_internet_registration_key_expired];
    }
    
    if (status == kMSOSDKResponseWebserverStatusDisabled) {
        return [NSError mso_internet_registration_key_disabled];
    }
    
    if (status == kMSOSDKResponseWebserverStatusSuspended) {
        return [NSError mso_internet_registration_key_suspended];
    }
    
    if (status == kMSOSDKResponseWebserverStatusInvalid) {
        return [NSError mso_internet_login_credientials_invalid];
    }
    
    if (status == kMSOSDKResponseWebserverStatusUnknown) {
        return [NSError mso_internet_login_credientials_invalid];
    }
    
    return nil;
}

@end

@implementation MSOSDKResponseWebserverCredentials

- (instancetype)initWithResponse:(NSString *)response
                         command:(nullable NSString *)command
                           error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    
    self = [super init];
    if (self) {
        
        self.command = command;
        
        NSAssert(self.command, @"There must be a command passed into this function: %s for class %@", __PRETTY_FUNCTION__, NSStringFromClass([self class]));
        
        NSString *between = [self.command isEqualToString:mso_soap_function_iCheckMobileUser] ? @"iCheckMobileUserResult" : @"iCheckMobileDeviceResult";
        
        NSString *parsed =
        [response
         mso_stringBetweenString:[NSString stringWithFormat:@"<%@>", between]
         andString:[NSString stringWithFormat:@"</%@>", between]];
        
        NSArray <NSString *> *components = [parsed componentsSeparatedByString:@","];
        NSString *status = [components mso_safeObjectAtIndex:0];
        _status = [MSOSDKResponseWebserver status:status];
        *error = [MSOSDKResponseWebserver errorFromStatus:_status];
        if (*error) {
            return nil;
        }
        
        NSString *date = [components mso_safeObjectAtIndex:1];
        NSDateFormatter *formatter = [MSOSDKResponseWebserver msosdk_webservice_dateformatter];
        _dateExpired = [formatter dateFromString:date];
        
    }
    return self;
}

@end

@implementation MSOSDKResponseWebserverRegister

- (instancetype)initWithResponse:(NSString *)response error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super init];
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

@implementation MSOSDKResponseWebserverRequestData



@end

@implementation MSOSDKResponseWebserverFilesToDownload


@end

@implementation MSOSDKResponseWebserverDownloadHistory

@end

@implementation MSOSDKResponseWebserverCatalog

- (instancetype)initWithResponse:(NSArray *)response {
    
    self = [super init];
    if (self) {
        NSString* filename     = [[response objectAtIndex:0] stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSString* lastUpdate   = [response objectAtIndex:1];
        NSString* filesize     = [[response objectAtIndex:2] stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        self.command = mso_soap_function_checkCatalogFileStatus;
        _filename = filename;
        _filesize = @([filesize longLongValue]);
        _dateUpdated = [lastUpdate mso_dateFromString];

    }
    return self;
    
}

@end

@implementation MSOSDKResponseWebserverPhotoDetails

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
        _dateUploaded = [[MSOSDKResponseWebserverPhotoDetails formatter] dateFromString:dateUploaded];
        _id = identifier;
        
    }
    
    return self;
}

@end
