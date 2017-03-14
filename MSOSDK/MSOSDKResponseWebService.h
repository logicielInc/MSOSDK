//
//  MSOSDKResponseWebService.h
//  iMobileRep
//
//  Created by John Setting on 2/14/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSOSDKConstants.h"

@interface MSOSDKResponseWebService : NSObject
+ (nullable instancetype)msosdk_commandWithResponse:(nullable id)response;
@property (strong, nonatomic, nullable) NSString *command;
+ (kMSOSDKResponseWebServiceStatus)status:(nullable NSString *)status;
+ (nullable NSError *)errorFromStatus:(kMSOSDKResponseWebServiceStatus)status;
@end

@interface MSOSDKResponseWebServiceCredentials : MSOSDKResponseWebService
@property (assign, nonatomic) kMSOSDKResponseWebServiceStatus status;
@property (strong, nonatomic, nullable) NSDate *dateCreated;
@end

@interface MSOSDKResponseWebServiceRegister : MSOSDKResponseWebService
@property (strong, nonatomic, nullable) NSString *rep;
@property (strong, nonatomic, nullable) NSString *key;
@property (strong, nonatomic, nullable) NSString *pin;
@property (strong, nonatomic, nullable) NSString *code;
@property (strong, nonatomic, nullable) NSString *type;
@property (strong, nonatomic, nullable) NSString *company;
@property (strong, nonatomic, nullable) NSString *cds;
@end

@interface MSOSDKResponseWebServiceRequestData : MSOSDKResponseWebService
@property (strong, nonatomic, nullable) NSNumber *status;
@end

@interface MSOSDKResponseWebServiceFilesToDownload : MSOSDKResponseWebService
@property (strong, nonatomic, nullable) NSArray <NSString *> *files;
@property (strong, nonatomic, nullable) NSDate *dateUpdated;
@end

@interface MSOSDKResponseWebServiceDownloadHistory : MSOSDKResponseWebService
@property (strong, nonatomic, nullable) NSNumber *resultCount;
@property (strong, nonatomic, nullable) NSString *data;
@end

@interface MSOSDKResponseWebServiceCatalog : MSOSDKResponseWebService;
@property (strong, nonatomic, nullable) NSString *filename;
@property (strong, nonatomic, nullable) NSDate *dateUpdated;
@property (strong, nonatomic, nullable) NSNumber *filesize;
@end

@interface MSOSDKResponseWebServicePhotoDetails : NSObject
@property (strong, nonatomic, nullable) NSString *filename;
@property (strong, nonatomic, nullable) NSDate *dateUploaded;
@property (strong, nonatomic, nullable) NSString *id;
+ (nullable instancetype)detailsWithValue:(nullable NSString *)value;
@end
