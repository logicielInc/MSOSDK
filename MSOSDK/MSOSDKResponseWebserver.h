//
//  MSOSDKResponseWebserver.h
//  iMobileRep
//
//  Created by John Setting on 2/14/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MSOSDKConstants.h"

@interface MSOSDKResponseWebserver : NSObject

+ (nullable instancetype)msosdk_commandWithResponse:(nullable NSString *)response
                                            command:(nullable NSString *)command
                                              error:(NSError *__autoreleasing  _Nullable * _Nullable)error;

- (nullable instancetype)initWithResponse:(nullable NSString *)response
                                  command:(nullable NSString *)command
                                    error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@property (strong, nonatomic, nonnull) NSString *command;

+ (kMSOSDKResponseWebserverStatus)status:(nullable NSString *)status;

+ (nullable NSError *)errorFromStatus:(kMSOSDKResponseWebserverStatus)status;

@end

@interface MSOSDKResponseWebserverCredentials : MSOSDKResponseWebserver
@property (assign, nonatomic) kMSOSDKResponseWebserverStatus status;
@property (strong, nonatomic, nullable) NSDate *dateExpired;
@end

@interface MSOSDKResponseWebserverRegister : MSOSDKResponseWebserver
@property (strong, nonatomic, nullable) NSString *rep;
@property (strong, nonatomic, nullable) NSString *key;
@property (strong, nonatomic, nullable) NSString *pin;
@property (strong, nonatomic, nullable) NSString *code;
@property (strong, nonatomic, nullable) NSString *type;
@property (strong, nonatomic, nullable) NSString *company;
@property (strong, nonatomic, nullable) NSString *cds;
@end

@interface MSOSDKResponseWebserverRegisterCode : MSOSDKResponseWebserver
@property (strong, nonatomic, nullable) NSString *pin;
@end

@interface MSOSDKResponseWebserverRequestData : MSOSDKResponseWebserver
@property (strong, nonatomic, nullable) NSNumber *status;
@end

@interface MSOSDKResponseWebserverFilesToDownload : MSOSDKResponseWebserver
@property (strong, nonatomic, nullable) NSArray <NSString *> *files;
@property (strong, nonatomic, nullable) NSDate *dateUpdated;
@end

@interface MSOSDKResponseWebserverDownloadHistory : MSOSDKResponseWebserver
@property (strong, nonatomic, nullable) NSNumber *resultCount;
@property (strong, nonatomic, nullable) NSString *data;
@end

@interface MSOSDKResponseWebserverCatalogDetails : MSOSDKResponseWebserver;
@property (strong, nonatomic, nullable) NSString *filename;
@property (strong, nonatomic, nullable) NSDate *dateUpdated;
@property (strong, nonatomic, nullable) NSNumber *filesize;
@end

@interface MSOSDKResponseWebserverCatalogResponse : MSOSDKResponseWebserver;
@property (strong, nonatomic, nullable) NSArray <MSOSDKResponseWebserverCatalogDetails *> *catalogDetails;
@end

@interface MSOSDKResponseWebserverPhotoDetails : MSOSDKResponseWebserver
@property (strong, nonatomic, nullable) NSString *filename;
@property (strong, nonatomic, nullable) NSDate *dateUploaded;
@property (strong, nonatomic, nullable) NSNumber *filesize;
@end

@interface MSOSDKResponseWebserverPhotoResponse : MSOSDKResponseWebserver
@property (strong, nonatomic, nullable) NSArray <MSOSDKResponseWebserverPhotoDetails *> *responseData;
@end


