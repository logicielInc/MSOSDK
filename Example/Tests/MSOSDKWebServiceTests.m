//
//  MSOSDKWebServiceTests.m
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOTestCase.h"

@interface MSOSDKWebServiceTests : MSOTestCase

@end

@implementation MSOSDKWebServiceTests

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


- (void)test_msoWebServiceForgotPassword {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebServiceCredentials *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceForgotPassword:@"John"
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
    XCTAssertTrue(mso_response.status == kMSOSDKResponseWebServiceStatusSuccess);
}

- (void)test_msoWebServiceForgotPassword_fail_notfound {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebServiceCredentials *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceForgotPassword:@"John"
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

- (void)test_msoWebServiceValidUser {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebServiceCredentials *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceValidity:@"John"
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
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue(mso_response.status == kMSOSDKResponseWebServiceStatusSuccess);
}

- (void)test_msoWebServiceRegister {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebServiceRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceRegisterRep:@"John"
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
    XCTAssertTrue([mso_response isKindOfClass:[MSOSDKResponseWebServiceRegister class]]);
    XCTAssertTrue([mso_response.type isEqualToString:@"A"]);
    XCTAssertTrue([mso_response.company isEqualToString:@"Testing1"]);
    XCTAssertTrue([mso_response.rep isEqualToString:@"John"]);
    XCTAssertTrue([mso_response.key isEqualToString:@"A0010012745NODHIV3WU"]);
}

- (void)test_msoWebServiceRegister_fail_invalidkey {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];

    __block MSOSDKResponseWebServiceRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceRegisterRep:@"John"
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

- (void)test_msoWebServiceRegister_fail_invalidemail {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];

    __block MSOSDKResponseWebServiceRegister *mso_response = nil;
    __block NSError *err = nil;
   
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceRegisterRep:@"John"
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

- (void)test_msoWebServiceRegister_fail_invalidudid {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebServiceRegister *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceRegisterRep:@"John"
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

- (void)test_msoWebServicePhotoFileStatus {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray <MSOSDKResponseWebServicePhotoDetails *> *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceFetchPhotoFileStatus:@"ADORF01MDBLKAC3"
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

- (void)test_msoWebServicePhotoFileStatus_noresults {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray <MSOSDKResponseWebServicePhotoDetails *> *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceFetchPhotoFileStatus:@"B00121d"
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

- (void)test_msoWebServicePhotoFileStatus_chineselaundry {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray <MSOSDKResponseWebServicePhotoDetails *> *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceFetchPhotoFileStatus:@"ADORF01MD_BLACK"
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

- (void)test_msoWebServiceDownloadPhoto {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];

    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;

    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceDownloadPhoto:@"ADORF01MDBLKAC3.jpg"
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

- (void)test_msoWebServiceDownloadPhoto_testing_hashtags {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceDownloadPhoto:@"FKABC22FA_B#B.jpg"
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
- (void)test_msoWebServiceDownloadPhoto_testing_no_extension {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceDownloadPhoto:@"FKABC22FA_B"
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

- (void)test_msoWebServiceDownloadPhoto_fail_noimagefound {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceDownloadPhoto:@"ADORF01MDBLKAC3ds.jpg"
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

- (void)test_msoWebServiceDownloadEventList {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceDownloadEventList:@"20010101"
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

- (void)test_msoWebServiceCheckForNumberOfFilesToDownload {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSNumber *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceCheckForNumberOfFilesToDownload:@"John"
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

- (void)test_msoWebServiceCheckForFilesToDownload {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebServiceFilesToDownload *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceCheckForFilesToDownload:@"John"
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

- (void)test_msoWebServiceSendDataRequest {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseWebService *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoWebServiceSendDataRequest:@"John"
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

- (void)test_msoWebServiceFetchAllPhotoReferences {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSArray *mso_response = nil;
    __block NSError *err = nil;
    
    [sdk
     _msoWebServiceFetchAllPhotoReferences:@"20010101"
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

@end
