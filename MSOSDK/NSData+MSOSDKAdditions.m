//
//  NSData+MSOSDKAdditions.m
//  Pods
//
//  Created by John Setting on 4/6/17.
//
//

#import "NSData+MSOSDKAdditions.h"

@implementation NSData (MSOSDKAdditions)

- (NSString *)sanatizeDataForRequestType:(kMSOSDKRequestType)type {
    
    NSString *unsanitizedData = [[NSString alloc] initWithData:self encoding:stringEncoding];
    
    if (type == kMSOSDKRequestTypeNetserver) {

        NSString *parsedData =
        [unsanitizedData
         mso_stringBetweenString:_msoNetserverBeginEscapedCommand
         andString:_msoNetserverEndEscapedCommand];

        if (!parsedData) {

            // we can assume this is an image
            NSString *betweenString = @"DoWorkResult";
            NSString *startString = [NSString stringWithFormat:@"<%@>", betweenString];
            NSString *endString = [NSString stringWithFormat:@"</%@>", betweenString];
            
            return
            [unsanitizedData
             mso_stringBetweenString:startString
             andString:endString];
            
        } else {
            
            unsanitizedData = [parsedData stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            
        }
        
    } else if (type == kMSOSDKRequestTypeWebserver) {
        
        
        
    } else {
        
        NSAssert(NO, @"The request type must either be `kMSOSDKRequestTypeWebserver` or `kMSOSDKRequestTypeNetserver`");
        
    }
    
    NSString *command = [unsanitizedData mso_unescape];
    return command;
}

- (NSString *)sanatizeDataForWebServiceResponse {
    return [self sanatizeDataForRequestType:kMSOSDKRequestTypeWebserver];
}

- (NSString *)sanatizeDataForNetserverResponse {
    return [self sanatizeDataForRequestType:kMSOSDKRequestTypeNetserver];
}

@end
