#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MSOSDK.h"
#import "NSArray+MSOSDKAdditions.h"
#import "NSArray+MSOSDKAdditions.m"
#import "NSError+MSOSDKAdditions.h"
#import "NSError+MSOSDKAdditions.m"
#import "NSString+MSOSDKAdditions.h"
#import "NSString+MSOSDKAdditions.m"
#import "NSURLRequest+MSOSDKAdditions.h"
#import "NSURLRequest+MSOSDKAdditions.m"
#import "MSOSDKConstants.h"
#import "MSOSDKConstants.m"
#import "GRCreateDirectoryRequest.h"
#import "GRCreateDirectoryRequest.m"
#import "GRDeleteRequest.h"
#import "GRDeleteRequest.m"
#import "GRDownloadRequest.h"
#import "GRDownloadRequest.m"
#import "GRError.h"
#import "GRError.m"
#import "GRListingRequest.h"
#import "GRListingRequest.m"
#import "GRQueue.h"
#import "GRQueue.m"
#import "GRRequest.h"
#import "GRRequest.m"
#import "GRRequestProtocol.h"
#import "GRRequestsManager.h"
#import "GRRequestsManager.m"
#import "GRRequestsManagerProtocol.h"
#import "GRStreamInfo.h"
#import "GRStreamInfo.m"
#import "GRUploadRequest.h"
#import "GRUploadRequest.m"
#import "MSOSDKMaster.h"
#import "MSOSDKMaster.m"
#import "MSOSDK+Netserver.h"
#import "MSOSDK+Netserver.m"
#import "MSOSDK+WebService.h"
#import "MSOSDK+WebService.m"
#import "MSOSDKResponseNetserver.h"
#import "MSOSDKResponseNetserver.m"
#import "MSOSDKResponseWebService.h"
#import "MSOSDKResponseWebService.m"

FOUNDATION_EXPORT double MSOSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char MSOSDKVersionString[];

