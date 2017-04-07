//
//  MSOSDKWebserverTests.m
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOTestCase.h"

@interface MSOSDKWebserverTests : MSOTestCase

@end

@implementation MSOSDKWebserverTests

- (void)setUp {
    [super setUp];
    
    [MSOSDK setMSONetserverIpAddress:@"192.168.1.100"
                       msoDeviceName:@"MSOTests"
                  msoDeviceIpAddress:@"72.242.241.52"
                          msoEventId:@"1301H"
                         msoPassword:@"logic99"];
    
}

- (void)tearDown {
    
    [super tearDown];
}


- (void)test_msoWebserverForgotPassword {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverCredentials *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverForgotPassword:@"John"
     password:@""
     accesskey:@"A0010012745NODHIV3WU"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     pin:@"20010101"
     appversion:@"1.5.66"
     companyname:@"Testing1"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response.command isEqualToString:mso_soap_function_iCheckMobileDevice]);
    XCTAssertTrue(mso_response.status == kMSOSDKResponseWebserverStatusSuccess);
}

- (void)test_msoWebserverForgotPassword_fail_notfound {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverCredentials *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverForgotPassword:@"John"
     password:nil
     accesskey:@"A0010012745NODHIV3WU"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     pin:@"20010121"
     appversion:@"1.5.66"
     companyname:@"Testing1"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_registration_key_not_found]]);
    XCTAssertNil(mso_response);
}

- (void)test_msoWebserverValidUser {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverCredentials *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverValidity:@"john2"
     accesskey:@"A0020010138LA4YUKQS3"
     udid:@"7D7DE0A1-AAB2-4F14-AD8C-7C2A34FE2F20"
     pin:@"20150731"
     companyname:@"Acme Inc"
     appversion:@"1.5.64.16302"
     user:YES
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         err = error;
         [expectation fulfill];
         
     }];
    /*
     [sdk
     _msoWebserverValidity:@"John"
     accesskey:@"A0010012745NODHIV3WU"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     pin:@"20010101"
     companyname:@"Testing1"
     appversion:@"1.5.66"
     user:YES
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
     
     mso_response = responseObject;
     [expectation fulfill];
     
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
     err = error;
     [expectation fulfill];
     
     }];
     */
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue(mso_response.status == kMSOSDKResponseWebserverStatusSuccess);
}

- (void)test_msoWebserverRegister {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverRegisterRep:@"John"
     accesskey:@"IV3WU"
     email:@"john@logiciel.com"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     appversion:@"1.5.66"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    
    [task resume];
    
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response isKindOfClass:[MSOSDKResponseWebserverRegister class]]);
    XCTAssertTrue([mso_response.type isEqualToString:@"A"]);
    XCTAssertTrue([mso_response.company isEqualToString:@"Testing1"]);
    XCTAssertTrue([mso_response.rep isEqualToString:@"John"]);
    XCTAssertTrue([mso_response.key isEqualToString:@"A0010012745NODHIV3WU"]);
}

- (void)test_msoWebserverRegister_amp_company {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverRegisterRep:@"John"
     accesskey:@"G2FUV"
     email:@"john@logiciel.com"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     appversion:@"1.5.66"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    
    [task resume];
    
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response isKindOfClass:[MSOSDKResponseWebserverRegister class]]);
}

- (void)test_msoWebserverRegister_fail_invalidkey {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverRegisterRep:@"John"
     accesskey:@"IV3WQ"
     email:@"john@logiciel.com"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     appversion:@"1.5.66"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_registration_key_invalid]]);
    XCTAssertNil(mso_response);
}

- (void)test_msoWebserverRegister_fail_invalidemail {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverRegisterRep:@"John"
     accesskey:@"IV3WU"
     email:@"joh@logiciel.com"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     appversion:@"1.5.66"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_registration_key_invalid]]);
    XCTAssertNil(mso_response);
}

- (void)test_msoWebserverRegister_fail_invalidudid {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverRegisterRep:@"John"
     accesskey:@"IV3WU"
     email:@"john@logiciel.com"
     udid:@""
     appversion:@"1.5.66"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_registration_key_in_use]]);
    XCTAssertNil(mso_response);
}

- (void)test_msoWebserverPhotoFileStatus {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray <MSOSDKResponseWebserverPhotoDetails *> *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverFetchPhotoFileStatus:@"ADORF01MDBLKAC3"
     pin:@"20010101"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response count] == 1);
}

- (void)test_msoWebserverPhotoFileStatus_noresults {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray <MSOSDKResponseWebserverPhotoDetails *> *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverFetchPhotoFileStatus:@"B00121d"
     pin:@"20010101"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response count] == 0);
}

- (void)test_msoWebserverPhotoFileStatus_chineselaundry {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray <MSOSDKResponseWebserverPhotoDetails *> *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverFetchPhotoFileStatus:@"ADORF01MD_BLACK"
     pin:@"20120418"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response count] == 1);
}

- (void)test_msoWebserverDownloadPhoto {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverDownloadPhoto:@"ADORF01MDBLKAC3.jpg"
     pin:@"20010101"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertTrue([mso_response isKindOfClass:[UIImage class]]);
    XCTAssertNotNil(mso_response);
    
}

- (void)test_msoWebserverDownloadPhoto_testing_hashtags {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverDownloadPhoto:@"FKABC22FA_B#B.jpg"
     pin:@"20040201"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertTrue([mso_response isKindOfClass:[UIImage class]]);
    XCTAssertNotNil(mso_response);
    
}

/*
 - (void)test_msoWebserverDownloadPhoto_testing_no_extension {
 
 __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
 
 MSOSDK *sdk = [MSOSDK sharedSession];
 
 __block UIImage *mso_response = nil;
 __block NSError *err = nil;
 
 NSURLSessionDataTask *task =
 [sdk
 _msoWebserverDownloadPhoto:@"FKABC22FA_B"
 pin:@"20040201"
 success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
 
 mso_response = responseObject;
 [expectation fulfill];
 
 } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
 
 err = error;
 [expectation fulfill];
 
 }];
 
 [task resume];
 
 [self waitForExpectationsWithCommonTimeout];
 
 XCTAssertNil(err);
 XCTAssertTrue([mso_response isKindOfClass:[UIImage class]]);
 XCTAssertNotNil(mso_response);
 
 }
 */

- (void)test_msoWebserverDownloadPhoto_fail_noimagefound {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverDownloadPhoto:@"ADORF01MDBLKAC3ds.jpg"
     pin:@"20010101"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    
}

- (void)test_msoWebserverDownloadEventList {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray *mso_response = nil;
    __block NSError *err = nil;
    
    [sdk
     _msoWebserverDownloadEventList:@"20040201"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response count] == 1);
    
}

- (void)test_msoWebserverCheckForNumberOfFilesToDownload {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSNumber *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverCheckForNumberOfFilesToDownload:@"John"
     pin:@"20010101"
     date:[NSDate date]
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}

- (void)test_msoWebserverCheckForFilesToDownload {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserverFilesToDownload *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverCheckForFilesToDownload:@"John"
     pin:@"20010101"
     date:[NSDate date]
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response.dateUpdated isKindOfClass:[NSDate class]]);
}

- (void)test_msoWebserverSendDataRequest {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebserver *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverSendDataRequest:@"John"
     pin:@"20010101"
     udid:@"B1D2D4F5-1324-41C6-97E9-5A4ACE080499"
     companyname:@"Testing 1"
     criteria:@""
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    
}

- (void)test_msoWebserverFetchAllPhotoReferences {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray *mso_response = nil;
    __block NSError *err = nil;
    
    [sdk
     _msoWebserverFetchAllPhotoReferences:@"20010101"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:^(NSProgress * _Nonnull progress) {
         
         NSLog(@"%@", progress);
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         err = error;
         [expectation fulfill];
     }];
    
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    
}

- (void)test_msoWebserverCheckPDAHistoryForDownloading {
    
    [MSOSDK setMSONetserverIpAddress:@"192.168.1.206"
                       msoDeviceName:@"MSOTests"
                  msoDeviceIpAddress:@"72.242.241.52"
                          msoEventId:@"1217H"
                         msoPassword:@"logic99"];
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebserverCheckPDAHistoryForDownloading:@"010"
     pin:@"20040201"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
         
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    
}

@end
