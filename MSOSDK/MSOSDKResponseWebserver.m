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

- (instancetype)initWithCommand:(NSString *)command {

    NSAssert(command, @"There must be a command passed into this function: %s for class %@", __PRETTY_FUNCTION__, NSStringFromClass([self class]));

    self = [super init];
    if (self) {
        _command = command;
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
    
    self = [super initWithCommand:command];
    if (self) {
        
        NSString *between =
        [self.command
         isEqualToString:mso_soap_function_iCheckMobileUser] ? @"iCheckMobileUserResult" : @"iCheckMobileDeviceResult";
        
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

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    self = [super initWithCommand:command];
    
    if (self) {
        
        NSString *parsed =
        [response
         mso_stringBetweenString:@"<iRegisterShortKeyResult>"
         andString:@"</iRegisterShortKeyResult>"];
        
        if (!parsed) {
            *error = [NSError mso_internet_registration_key_invalid];
            return nil;
        }
        
        NSArray *components = [parsed componentsSeparatedByString:@","];
        NSString *type = @"";
        if ([components count] >= 1) {
            type = [components objectAtIndex:0];
        }
        
        // Account Not Found
        if ([type isEqualToString:@""]) {
            *error = [NSError mso_internet_registration_key_not_found];
            return nil;
        }
        
        // Account In Use
        if ([type isEqualToString:@"1"]) {
            *error = [NSError mso_internet_registration_key_in_use];
            return nil;
        }
        
        // Account Already Registered with Same Company
        if ([type isEqualToString:@"2"]) {
            *error = [NSError mso_internet_registration_key_same_company_use];
            return nil;
        }
        
        // Account Not Ready For Use
        if ([type isEqualToString:@"3"]) {
            *error = [NSError mso_internet_registration_key_not_ready];
            return nil;
        }
        
        components = [parsed componentsSeparatedByString:@"-"];
        
        // Typical Format
        // unlockcode-showType-pin-[companyName, inc.],[john],[accesskey]
        if ([components count] > 2) {
            
            _code = [components mso_safeObjectAtIndex:0];
            _type = [components mso_safeObjectAtIndex:1];
            _pin = [components mso_safeObjectAtIndex:2];
            
            NSString *stringToRemove = [NSString stringWithFormat:@"%@-%@-%@-", _code, _type, _pin];
            NSString *removed = [parsed stringByReplacingOccurrencesOfString:stringToRemove withString:@""];
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

@implementation MSOSDKResponseWebserverRegisterCode

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithCommand:command];
    if (self) {
        
        NSString *parsed =
        [response
         mso_stringBetweenString:@"<iRegisterCodeResult>"
         andString:@"</iRegisterCodeResult>"];
        
        NSString *pin = nil;
        
        if ([parsed isEqualToString:@""] || !parsed) {
            *error = [NSError mso_internet_registration_key_unlock_code_error];
            return nil;
        }
        
        if ([parsed isEqualToString:@"1"]) {
            *error = [NSError mso_internet_registration_key_disabled_or_inuse];
            return nil;
        }
        
        //will return fullCDS instead if ([returnFromService isEqualToString:@"2"]) {
        _pin = [[parsed componentsSeparatedByString:@"-"] objectAtIndex:2];
        
    }
    return self;
}

@end

@implementation MSOSDKResponseWebserverRequestData

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithCommand:command];
    if (self) {
        
        NSString *between;
        if ([self.command isEqualToString:mso_soap_function_updateDownloadInfo]) {
            between = @"_UpdateDownloadInfoResult";
        } else if ([self.command isEqualToString:mso_soap_function_updateUploadInfo]) {
            between = @"_UpdateUploadInfoResult";
        } else {
            between = @"_UploadFileResult";
        }
        
        NSString *parsed =
        [response
         mso_stringBetweenString:[NSString stringWithFormat:@"<%@>", between]
         andString:[NSString stringWithFormat:@"</%@>", between]];
        
        if ([self.command isEqualToString:mso_soap_function_uploadFile]) {

            if (![parsed boolValue]) {
                *error = [NSError mso_internet_upload_processing_error];
                return nil;
            }
                
        } else {

            if (![parsed isEqualToString:@"2"]) {
                
                if ([self.command isEqualToString:mso_soap_function_updateDownloadInfo]) {
                    *error = [NSError mso_internet_request_data_error];
                } else {
                    *error = [NSError mso_internet_upload_processing_error];
                }
                return nil;
            }

        }

        _status = @([parsed integerValue]);

    }
    return self;
}


@end

@implementation MSOSDKResponseWebserverFilesToDownload

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithCommand:command];
    if (self) {
        
        NSString *date =
        [response
         mso_stringBetweenString:@"<sLastUpdateDate>"
         andString:@"</sLastUpdateDate>"];
        
        _dateUpdated = [date mso_dateFromString];
        
        NSString *parsed =
        [response
         mso_stringBetweenString:@"<_iCheckMobileFileForDownloadingResult>"
         andString:@"</_iCheckMobileFileForDownloadingResult>"];
        
        if (parsed) {
            
            NSArray <NSString *> *components = [parsed componentsSeparatedByString:@"</string>"];
            NSMutableArray *files = [NSMutableArray arrayWithCapacity:[components count]];
            
            for (NSString *component in components) {

                if ([component length] == 0) {
                    continue;
                }

                NSString *file = [component stringByReplacingOccurrencesOfString:@"<string>" withString:@""];
                [files addObject:file];
                
            }
            
            _files = [files copy];
        }

    }
    return self;
}

@end

@implementation MSOSDKResponseWebserverDownloadHistory

@end

@implementation MSOSDKResponseWebserverCatalogDetails

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithCommand:command];
    if (self) {
        
        NSArray <NSString *> *components = [response componentsSeparatedByString:@"]["];
        if ([components count] <= 2) {
            *error = [NSError mso_internet_catalog_no_content];
            return nil;
        }
        
        NSString* filename     = [[components objectAtIndex:0] stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSString* lastUpdate   = [components objectAtIndex:1];
        NSString* filesize     = [[components objectAtIndex:2] stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        _filename = filename;
        _filesize = @([filesize longLongValue]);
        _dateUpdated = [lastUpdate mso_dateFromString];
        
    }
    return self;
    
}

@end

@implementation MSOSDKResponseWebserverCatalogResponse

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithCommand:command];
    if (self) {
        
        NSString *parsed =
        [response
         mso_stringBetweenString:@"<_CheckCatalogFileStatusResult>"
         andString:@"</_CheckCatalogFileStatusResult>"];
        
        if (!parsed) {
            *error = [NSError mso_internet_catalog_no_content];
            return nil;
        }
        
        NSArray <NSString *> *components = [parsed componentsSeparatedByString:@"</string>"];
        NSMutableArray <MSOSDKResponseWebserverCatalogDetails *> *catalogs = [NSMutableArray arrayWithCapacity:[components count]];

        for (NSString *component in components) {
            if ([component length] == 0) {
                continue;
            }
            
            NSString *catalog = [component stringByReplacingOccurrencesOfString:@"<string>" withString:@""];
            MSOSDKResponseWebserverCatalogDetails *catalogObject =
            [MSOSDKResponseWebserverCatalogDetails
             msosdk_commandWithResponse:catalog
             command:self.command
             error:&error];

            if (!catalogObject) {
                return nil;
            }

            [catalogs addObject:catalogObject];
        }
        
        _catalogDetails = [catalogs copy];

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

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithCommand:command];
    if (self) {
        response = [response stringByReplacingOccurrencesOfString:@"<string>" withString:@""];
        NSArray *components = [response componentsSeparatedByString:@"]["];
        NSString *filename = [components objectAtIndex:0];
        NSString *dateUploaded = [components objectAtIndex:1];
        NSString *identifier = [components objectAtIndex:2];
        
        filename = [filename stringByReplacingOccurrencesOfString:@"[" withString:@""];
        identifier = [identifier stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        _filename = filename;
        _dateUploaded = [[MSOSDKResponseWebserverPhotoDetails formatter] dateFromString:dateUploaded];
        _filesize = @([identifier longLongValue]);
        
    }
    
    return self;
}

@end

@implementation MSOSDKResponseWebserverPhotoResponse

- (instancetype)initWithResponse:(NSString *)response command:(NSString *)command error:(NSError *__autoreleasing  _Nullable *)error {
    self = [super initWithCommand:command];
    if (self) {

        NSString *parsed =
        [response
         mso_stringBetweenString:@"<_CheckPhotoFileStatusResult>"
         andString:@"</_CheckPhotoFileStatusResult>"];
        
        if (parsed) {
            
            NSArray <NSString *> *components = [parsed componentsSeparatedByString:@"</string>"];
            
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:[components count]];
            for (NSString *component in components) {

                if ([component length] == 0) continue;
                
                MSOSDKResponseWebserverPhotoDetails *details =
                [MSOSDKResponseWebserverPhotoDetails
                 msosdk_commandWithResponse:component
                 command:mso_soap_function_checkPhotoFileStatus
                 error:&error];

                if (!details) {
                    return nil;
                }
                
                [array addObject:details];
                
            }
            
            _responseData = [array copy];
        }
        
    }
    return self;
}

@end

