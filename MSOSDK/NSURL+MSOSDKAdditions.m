//
//  NSURL+MSOSDKAdditions.m
//  Pods
//
//  Created by John Setting on 3/24/17.
//
//

#import "NSURL+MSOSDKAdditions.h"

@implementation NSURL (MSOSDKAdditions)

+ (instancetype)logicielCustomerURL {
    static NSURL *url = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        url = [NSURL URLWithString:mso_endpoint_logicielIncUrl];
        url = [url URLByAppendingPathComponent:[mso_endpoint_logicielUpdateEndpoint stringByAppendingPathComponent:mso_endpoint_logicielCustomerASMX]];
    });
    return url;
}

+ (instancetype)logicielFTPServiceURL {
    static NSURL *url = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        url = [NSURL URLWithString:mso_endpoint_logicielIncUrl];
        url = [url URLByAppendingPathComponent:[mso_endpoint_logicielFTPWSEndpoint stringByAppendingPathComponent:mso_endpoint_logicielFTPServiceASMX]];
    });
    return url;
}

@end
