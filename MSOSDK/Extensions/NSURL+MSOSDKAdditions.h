//
//  NSURL+MSOSDKAdditions.h
//  Pods
//
//  Created by John Setting on 3/24/17.
//
//

#import <Foundation/Foundation.h>

#import "MSOSDKConstants.h"

@interface NSURL (MSOSDKAdditions)

/**
 An `NSURL` generated object to interact with the Logiciel Customer Web Service API
 
 @return `NSURL` object
 @see http://logicielinc.com/logicielupdatews/logicielcustomer.asmx
 */
+ (nonnull instancetype)logicielCustomerURL;

/**
 An `NSURL` generated object to interact with the Logiciel FTP Web Service API
 
 @return `NSURL` object
 @see http://logicielinc.com/logiciel_ftp_ws/FTPService.asmx
 */
+ (nonnull instancetype)logicielFTPServiceURL;

@end
