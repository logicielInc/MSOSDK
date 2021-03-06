//
//  MSOSDKNetserverTests.m
//  iMobileRep
//
//  Created by John Setting on 2/16/17.
//  Copyright © 2017 John Setting. All rights reserved.
//

#import "MSOTestCase.h"

@interface MSOSDKNetserverTests : MSOTestCase

@end

@implementation MSOSDKNetserverTests

- (void)setUp {
    [super setUp];

    NSString *eventId;
#if test == 1
    eventId = @"1301H";
#elif test == 2
    eventId = @"1403H";
#elif test == 3
    eventId = @"1217H";
#endif
    
    [MSOSDK setMSONetserverIpAddress:@"192.168.1.100"
                       msoDeviceName:@"MSOTests"
                  msoDeviceIpAddress:@"72.242.241.52"
                          msoEventId:eventId
                         msoPassword:@"logic99"];
    
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_msoNetserverStatus {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverPing *command = nil;
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverPing:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        command = responseObject;
        [expectation fulfill];
        
    } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    }];
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(command);
    XCTAssertTrue([command.status isEqualToString:@"OK"]);
}

- (void)test_msoNetserverStatus1 {
    
    // Need to check if the response from a mismatch eventId causes issues

    NSString *eventId;
#if test == 1
    eventId = @"1302H";
#elif test == 2
    eventId = @"1404H";
#elif test == 3
    eventId = @"1218H";
#endif
    
    [MSOSDK setMSONetserverIpAddress:@"192.168.1.100"
                       msoDeviceName:@"MSOTests"
                  msoDeviceIpAddress:@"72.242.241.52"
                          msoEventId:eventId
                         msoPassword:@"logic99"];
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverPing *command = nil;
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverPing:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         command = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(command);
    XCTAssertTrue([command.status isEqualToString:@"OK"]);
}

- (void)test_msoNetserverLogin {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverLogin *command = nil;
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverLogin:@"john"
     password:@""
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        command = responseObject;
        [expectation fulfill];
        
    } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    }];
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(command);
    XCTAssertTrue([command.status isEqualToString:@"OK"]);
}

- (void)test_msoNetserverLogin_fail_invalidcredentials {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverLogin *command = nil;
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverLogin:@"John"
     password:@"football33"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         command = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(command);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);

}

- (void)test_msoNetserverFetchInitialSettings {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSettings *command = nil;
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverFetchInitialSettings:@"John"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        command = responseObject;
        [expectation fulfill];
        
    } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    }];
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(command);
    XCTAssertTrue([command.status isEqualToString:@"OK"]);
}

- (void)test_msoNetserverFetchInitialSettings_retrieve {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSettings *command = nil;
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverFetchInitialSettings:@"John"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         command = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(command);
    XCTAssertTrue(command.optionsIfOrderQuantityGreaterThanOnHandQuantity == kMSOSDKResponseNetserverSettingsRedAlertIfOrderQuantityGreaterThanOnHandBackOrder);
    XCTAssertTrue(command.behaviorWhenEnteringItem == kMSOSDKResponseNetserverSettingsBehaviorWhenEnteringItemAlwaysRetrieve);
//    XCTAssertTrue([command.status isEqualToString:@"OK"]);
}

- (void)test_msoNetserverFetchInitialSettings_invalid_event {
    
    // Need to check if the response from a mismatch eventId causes issues
    
    NSString *eventId;
#if test == 1
    eventId = @"1302H";
#elif test == 2
    eventId = @"1404H";
#elif test == 2
    eventId = @"1218H";
#endif

    [MSOSDK setMSONetserverIpAddress:@"192.168.1.100"
                       msoDeviceName:@"MSOTests"
                  msoDeviceIpAddress:@"72.242.241.52"
                          msoEventId:eventId
                         msoPassword:@"logic99"];
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSettings *command = nil;
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverFetchInitialSettings:@"John"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         command = responseObject;
         [expectation fulfill];
         
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(command);
    XCTAssertTrue([command.status isEqualToString:@"OK"]);
}

- (void)test_msoNetserverLogout {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSError *err = nil;
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverLogout:^(NSURLResponse * _Nonnull response, BOOL responseObject) {
         [expectation fulfill];
     } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         err = error;
         [expectation fulfill];
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNil(err);
}

/*
- (void)test_msoNetserverDownloadAllSettings {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncSettings *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadAllSettings:@"John"
     command:nil
     completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        mso_response = responseObject;
        SMXMLDocument *doc = [Utility importDataChecker:mso_response.data error:error];
        XCTAssertNotNil(doc);
        err = *error;
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}
*/

- (void)test_msoNetserverDownloadSettings_fail_credentials {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncSettings *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadAllSettings:@"Johnasd"
     nextId:@""
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        mso_response = responseObject;
        NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
        SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:error];
        XCTAssertNotNil(doc);
        err = *error;
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
    XCTAssertNil(mso_response);
}

/*
- (void)test_msoNetserverDownloadAllCustomers {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncSettings *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk _msoNetserverDownloadAllCustomers:@"John" command:nil completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        mso_response = responseObject;
        SMXMLDocument *doc = [Utility importDataChecker:mso_response.data error:error];
        XCTAssertNotNil(doc);
        err = *error;
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}
*/

- (void)test_msoNetserverDownloadAllCustomers_fail_credentials {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncCustomers *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadAllCustomers:@"Johndsad"
     nextId:@""
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        mso_response = responseObject;
        
        NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
        SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:error];
        XCTAssertNotNil(doc);
        err = *error;
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
    XCTAssertNil(mso_response);
}

- (void)test_msoNetserverDownloadCustomers_singlepage {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryCustomers *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *account_no;
#if test == 1
    account_no = @"BAC";
#elif test == 2
    account_no = @"0016";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadCustomers:@"John"
     accountnumber:account_no
     name:@""
     phone:@""
     city:@""
     state:@""
     zip:@""
     billing:YES
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {

         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
    SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:&err];
    XCTAssertNotNil(doc);
    XCTAssertNil(err);
}

- (void)test_msoNetserverDownloadCustomers_fail_exceededlimit {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryCustomers *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *account_no;
#if test == 1
    account_no = @"B";
#elif test == 2
    account_no = @"0";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadCustomers:@"John"
     accountnumber:account_no
     name:@""
     phone:@""
     city:@""
     state:@""
     zip:@""
     billing:YES
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_customer_query_exceeded_limit_error]]);
    XCTAssertNil(mso_response);
    
}

/*
- (void)test_msoNetserverDownloadAllProducts {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncProducts *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk _msoNetserverDownloadAllProducts:@"John" nextId:nil companyId:nil completion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        mso_response = responseObject;
        err = *error;
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    SMXMLDocument *doc = [Utility importDataChecker:mso_response.data error:nil];
    XCTAssertNotNil(doc);
}
*/

- (void)test_msoNetserverDownloadAllProducts_fail_credentials {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncProducts *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadAllProducts:@"Johndasd"
     nextId:nil
     companyId:nil
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
         mso_response = responseObject;
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        mso_response = responseObject;
        err = *error;
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
    XCTAssertNil(mso_response);
}

- (void)test_msoNetserverDownloadProducts_singlepage {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryProducts *mso_response = nil;
    __block NSError *err = nil;

    NSString *search_term;
#if test == 1
    search_term = @"B00001";
#elif test == 2
    search_term = @"AL";
#endif

    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadProducts:@"John"
     searchTerm:search_term
     companyId:@"1"
     searchType:kMSOProductSearchTypeItemNumber
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
    NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
    SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:&err];
    XCTAssertNotNil(doc);
    XCTAssertNil(err);
}


- (void)test_msoNetserverDownloadProducts_multiplepages {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryProducts *mso_response = nil;
    __block NSError *err = nil;

    NSString *search_term;
#if test == 1
    search_term = @"B0";
#elif test == 2
    search_term = @"LAS";
#endif

    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadProducts:@"John"
     searchTerm:search_term
     companyId:@"1"
     searchType:kMSOProductSearchTypeItemNumber
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
    NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
    SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:&err];
    XCTAssertNotNil(doc);
    XCTAssertNil(err);
}


- (void)test_msoNetserverDownloadProducts_fail_empty {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQuery *mso_response = nil;
    __block NSError *err = nil;

    NSString *search_term;
#if test == 1
    search_term = @"ADORF01MDBLsKAC";
#elif test == 2
    search_term = @"LAS-811132";
#endif

    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadProducts:@"John"
     searchTerm:search_term
     companyId:@"1"
     searchType:kMSOProductSearchTypeItemNumber
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        mso_response = responseObject;
        [expectation fulfill];
        
    } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_product_fetch_empty_result]]);
    XCTAssertNil(mso_response);

}

- (void)test_msoNetserverDownloadProducts_fail_credentials {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQuery *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadProducts:@"Johnds"
     searchTerm:@"ADORF01MDBLKAC"
     companyId:@"1"
     searchType:kMSOProductSearchTypeItemNumber
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        mso_response = responseObject;
        [expectation fulfill];
        
    } failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];
        
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
    XCTAssertNil(mso_response);
    
}

- (void)test_msoNetserverFetchAllProductImageReferences {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryImages *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverFetchAllImageReferences:@"john"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
     
         mso_response = responseObject;
         [expectation fulfill];
     
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
     
         err = error;
         [expectation fulfill];

     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response.images count] > 0);
}

- (void)test_msoNetserverFetchAllProductImageReferences_toms_database {

    [MSOSDK setMSONetserverIpAddress:@"192.168.1.206"
                       msoDeviceName:@"MSOTests"
                  msoDeviceIpAddress:@"72.242.241.52"
                          msoEventId:@"1217H"
                         msoPassword:@"logic99"];
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block NSError *err = nil;
    __block UIImage *image = nil;
    
    NSURLSessionTask *task =
    [sdk
     _msoNetserverDownloadProductImage:@"86663"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         NSData* data = [[NSData alloc] initWithBase64EncodedString:responseObject options:kNilOptions];
         image = [UIImage imageWithData:data];
         
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(image);
    XCTAssertNotNil(err);
    
}

- (void)test_msoNetserverDownloadProductImage {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *item;
#if test == 1
    item = @"ADORF01MDBLKAC3";
#elif test == 2
    item = @"USA-99893";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadProductImage:item
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {

         mso_response = responseObject;
         [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        
        err = error;
        [expectation fulfill];

    }];

     
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}

- (void)test_msoNetserverDownloadProductImage_fail {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *item;
#if test == 1
    item = @"ADORF01MDBLKAC3";
#elif test == 2
    item = @"USA-99893";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadProductImage:item
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}

- (void)test_msoNetserverDownloadProductImage_fail_notfound {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block UIImage *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *item;
#if test == 1
    item = @"ADORF01MDBLKAC32";
#elif test == 2
    item = @"USA-998932";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadProductImage:item
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         err = error;
         [expectation fulfill];
         
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_image_not_found_error]]);
    XCTAssertNil(mso_response);
}

- (void)test_msoNetserverDownloadNumberOfProducts {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverProductsCount *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadNumberOfProducts:@"john"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        mso_response = responseObject;
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        err = error;
        [expectation fulfill];
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    
    NSNumber *count;
#if test == 1
    count = @46622;
#elif test == 2
    count = @3329;
#endif
    
    XCTAssertTrue([mso_response.productCount isEqualToNumber:count]);
}

- (void)test_msoNetserverDownloadNumberOfProducts_invalidLogin {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverProductsCount *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadNumberOfProducts:@"johndasd"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
        mso_response = responseObject;
        [expectation fulfill];
        
    } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
        err = error;
        [expectation fulfill];
    }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
}

- (void)test_msoNetserverSaveCustomer {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSaveCustomer *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverSaveCustomer:@"john"
     customerName:@"johns test customer"
     contactName:@"John Setting"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}

- (void)test_msoNetserverSaveCustomer_fail_invalidlogin {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSaveCustomer *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverSaveCustomer:@"johndsad"
     customerName:@"johns test customer"
     contactName:@"John Setting"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
}

- (void)test_msoNetserverAddCustomerShippingAddress {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSaveCustomer *mso_response = nil;
    __block NSError *err = nil;

    NSString *account_no;
#if test == 1
    account_no = @"1301H0127";
#elif test == 2
    account_no = @"1403H0037";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverSaveCustomerShippingAddress:@"john"
     accountNumber:account_no
     mainstoreNumber:account_no
     customerName:@"johns test customer"
     contactName:@"John Setting"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertFalse([mso_response.accountNumber isEqualToString:mso_response.mainstoreNumber]);
}

- (void)test_msoNetserverAddCustomerShippingAddress_fail_invalidlogin {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSaveCustomer *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverSaveCustomerShippingAddress:@"johndsad"
     accountNumber:@"1301H0127"
     mainstoreNumber:@"1301H0127"
     customerName:@"johns test customer"
     contactName:@"John Setting"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
}

- (void)test_msoNetserverUpdateCustomerAddress {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverUpdateCustomer *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *account_no;
#if test == 1
    account_no = @"1301H0127";
#elif test == 2
    account_no = @"1403H0037";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverUpdateCustomerAddress:@"john"
     companyID:@"Default Company"
     accountNumber:account_no
     name:@"johns test customer"
     contactName:@"John Setting Update"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     rep:@"Updated Rep"
     discount:@1
     priceLevel:@5
     billing:true
     success:^(NSURLResponse * _Nonnull response, MSOSDKResponseNetserverUpdateCustomer * _Nonnull responseObject) {

       mso_response = responseObject;
       [expectation fulfill];

     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
       err = error;
       [expectation fulfill];

     }];

    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    XCTAssertTrue([mso_response.status isEqualToString:@"OK"]);

}

- (void)test_msoNetserverUpdateCustomerAddress_fail_nocustomerfound {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSaveCustomer *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    
    [sdk
     _msoNetserverUpdateCustomerAddress:@"john"
     companyID:@"Default Company"
     accountNumber:@"1301H0127as"
     name:@"johns test customer"
     contactName:@"John Setting Update"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     rep:@"Updated Rep"
     discount:@1
     priceLevel:@5
     billing:YES
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_customer_query_not_found_error]]);
    
}

- (void)test_msoNetserverUpdateCustomerShippingAddress {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSaveCustomer *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *account_no;
#if test == 1
    account_no = @"1301H0127-001";
#elif test == 2
    account_no = @"1403H0037-001";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverUpdateCustomerAddress:@"john"
     companyID:@"Default Company"
     accountNumber:account_no
     name:@"johns test customer"
     contactName:@"John Setting Update (w123)"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     rep:@"Updated Rep"
     discount:@1
     priceLevel:@5
     billing:NO
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    
}

- (void)test_msoNetserverUpdateCustomerShippingAddress_fail_notfound {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSaveCustomer *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    
    [sdk
     _msoNetserverUpdateCustomerAddress:@"john"
     companyID:@"Default Company"
     accountNumber:@"1301H0127asd-1"
     name:@"johns test customer"
     contactName:@"John Setting Update"
     address1:@"123 Livingston St."
     address2:@"456 San Francisco Ave."
     city:@"Oakland"
     state:@"California"
     zip:@"94947"
     country:@"United States"
     phone:@"+1 415-246-9016"
     fax:@"+1 425-215-2151"
     email:@"john@logiciel.com"
     terms:@"some terms"
     rep:@"Updated Rep"
     discount:@1
     priceLevel:@5
     billing:NO
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_customer_query_not_found_error]]);
    
}

- (void)test_msoNetserverRetrieveSalesOrders {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryCustomerSalesOrders *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *account_no;
#if test == 1
    account_no = @"SOL14741";
#elif test == 2
    account_no = @"25111";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverRetrieveOrders:@"john"
     customerName:@""
     customerAccountNumber:account_no
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
    SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:&err];
    XCTAssertNotNil(doc);
    XCTAssertNil(err);

}

- (void)test_msoNetserverRetrieveSalesOrders_fail_noordersfound {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryCustomerSalesOrders *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverRetrieveOrders:@"john"
     customerName:@""
     customerAccountNumber:@"SOL141741"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_order_retrieval_no_orders]]);
    
}

- (void)test_msoNetserverRetrieveSalesOrder {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQuerySalesOrder *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *order_no;
#if test == 1
    order_no = @"JohnP0206";
#elif test == 2
    order_no = @"007P0128";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverRetrieveOrder:@"john"
     orderNumber:order_no
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
    SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:&err];
    XCTAssertNotNil(doc);
    XCTAssertNil(err);
}

- (void)test_msoNetserverRetrieveSalesOrder_fail_not_found {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserver *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverRetrieveOrder:@"john"
     orderNumber:@"JohnP02573213"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_order_retrieval_order_not_found]]);
    
}

- (void)test_msoNetserverRetrieveMultiPageSalesOrder {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQuerySalesOrder *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *order_no;
#if test == 1
    order_no = @"JohnP0218";
#elif test == 2
    order_no = @"P0052";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverRetrieveOrder:@"john"
     orderNumber:order_no
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    
    NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
    SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:&err];
    XCTAssertNotNil(doc);
    XCTAssertNil(err);

    data = [mso_response.itemSet dataUsingEncoding:NSUTF8StringEncoding];
    doc = [SMXMLDocument documentWithData:data error:&err];
    XCTAssertNotNil(doc);
    XCTAssertNil(err);
    
}

- (void)test_msoNetserverRetrieveMultiPageSalesOrder_fail_invalid_login {
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQuerySalesOrder *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverRetrieveOrder:@"johnasd"
     orderNumber:@"JohnP0218"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertNil(mso_response);
    XCTAssertTrue([err isEqual:[NSError mso_internet_login_credientials_invalid]]);
}

- (void)test_msoNetserverDownloadAllPurchaseHistory {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncPurchaseHistory *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadAllPurchaseHistory:@"john"
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
       
         mso_response = responseObject;
         NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
         SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:error];
         XCTAssertNotNil(doc);
         XCTAssertNil(err);
         
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}

- (void)test_msoNetserverDownloadCustomerPurchaseHistory {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncPurchaseHistory *mso_response = nil;
    __block NSError *err = nil;
    
    NSString *customer_zip;
#if test == 1
    customer_zip = @"90210";
#elif test == 2
    customer_zip = @"25586";
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverDownloadPurchaseHistory:@"john"
     customerName:@""
     customerZip:customer_zip
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     } handler:^(NSURLResponse * _Nonnull response, __kindof MSOSDKResponseNetserverSync * _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
         
         mso_response = responseObject;
         NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
         SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:error];
         XCTAssertNotNil(doc);
         XCTAssertNil(err);
         
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}

- (void)test_msoNetserverSubmitOrder_xml_escaping_issue {
    
    NSError *error = nil;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"passed_xml_order_escaping" ofType:@"xml"];
    XCTAssert(path, @"Path is NULL. This file was not found");
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    XCTAssert(content && [content length] > 0, @"There is currently no content in the txt File :%@", [error localizedDescription]);
    if (!content || [content length] == 0) {
        XCTFail(@"No content found");
    }
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSubmitSalesOrder *mso_response = nil;
    __block NSError *err = nil;

    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverSubmitOrder:@"john"
     orderNumber:@""
     orderString:content
     update:NO
     imageNotes:NO
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         mso_response = responseObject;
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nullable error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
}

- (void)test_msoNetserverFetchProductList {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverQueryProducts *mso_response = nil;
    __block NSError *err = nil;
    
    NSArray <NSString *> *item_list;
#if test == 1
    item_list = @[@"ADORF01MDBLKAC3"];
#elif test == 2
    item_list = @[@"MGD-60014", @"MGD-60015", @"MGD-60016", @"MGD-60017"];
#endif
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverFetchItemList:@"john"
     companyId:@"1"
     itemList:item_list
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         [expectation fulfill];

     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nonnull error) {

         err = error;
         [expectation fulfill];

     } handler:^(NSURLResponse * _Nonnull response, id  _Nonnull responseObject, NSError * _Nullable __autoreleasing * _Nullable error) {
     
         mso_response = responseObject;
         NSData *data = [mso_response.data dataUsingEncoding:NSUTF8StringEncoding];
         SMXMLDocument *doc = [SMXMLDocument documentWithData:data error:error];
         XCTAssertNotNil(doc);
         XCTAssertNil(err);
     
     }];
    
    [task resume];
    
    [self waitForExpectationsWithLongTimeout];
    
    XCTAssertNil(err);
    XCTAssertNotNil(mso_response);
    
}

- (void)test_msoNetserverSaveMapping_error {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncPurchaseHistory *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverSaveCustomerMappingScheme:@"john"
     mappingScheme:@""
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
        
         [expectation fulfill];
        
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nonnull error) {

         err = error;
         [expectation fulfill];
     
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_auto_mapping_not_created_error]]);
    XCTAssertNil(mso_response);
    
}

- (void)test_msoNetserverUpdateMapping_error {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    MSOSDK *sdk = [MSOSDK sharedSession];
    
    __block MSOSDKResponseNetserverSyncPurchaseHistory *mso_response = nil;
    __block NSError *err = nil;
    
    NSURLSessionDataTask *task =
    [sdk
     _msoNetserverUpdateCustomerMappingScheme:@"john"
     mappingScheme:@""
     mappingSchemeData:@""
     success:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject) {
         
         [expectation fulfill];
         
     } progress:nil failure:^(NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
         
         err = error;
         [expectation fulfill];
         
     }];
    
    [task resume];
    
    [self waitForExpectationsWithCommonTimeout];
    
    XCTAssertNotNil(err);
    XCTAssertTrue([err isEqual:[NSError mso_netserver_auto_mapping_update_error]]);
    XCTAssertNil(mso_response);
    
}

@end
