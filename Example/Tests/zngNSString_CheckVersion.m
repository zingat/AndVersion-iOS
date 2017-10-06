//
//  zngNSString_CheckVersion.m
//  AndVersion_Tests
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//  Copyright © 2017 kadirkemal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+CheckVersion.h"

@interface zngNSString_CheckVersion : XCTestCase

@end

@implementation zngNSString_CheckVersion

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSameVersions {
    NSString *version = @"1.3.2";
    NSComparisonResult result = [version compareToVersion:@"1.3.2"];
    XCTAssertEqual(result, NSOrderedSame);
}

- (void)testAscendingVersions {
    NSString *version = @"1.3.2";
    NSComparisonResult result = [version compareToVersion:@"1.2.2"];
    XCTAssertEqual(result, NSOrderedAscending);
    
    result = [version compareToVersion:@"1.3.1"];
    XCTAssertEqual(result, NSOrderedAscending);
    
    result = [version compareToVersion:@"1.2.2.4"];
    XCTAssertEqual(result, NSOrderedAscending);
    
    result = [version compareToVersion:@"1.3"];
    XCTAssertEqual(result, NSOrderedAscending);
}


- (void)testDescendingVersions {
    NSString *version = @"1.3.2";
    NSComparisonResult result = [version compareToVersion:@"1.3.2.1"];
    XCTAssertEqual(result, NSOrderedDescending);
    
    result = [version compareToVersion:@"1.4"];
    XCTAssertEqual(result, NSOrderedDescending);
    
    result = [version compareToVersion:@"1.3.3"];
    XCTAssertEqual(result, NSOrderedDescending);
    
    result = [version compareToVersion:@"2"];
    XCTAssertEqual(result, NSOrderedDescending);
}



@end
