//
//  lanyaTests.m
//  lanyaTests
//
//  Created by apple on 2020/3/20.
//  Copyright © 2020 ronglian. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface lanyaTests : XCTestCase

@end

@implementation lanyaTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    [lanyaTests floatHeight:26.67];
    
    NSLog(@"---- %@", [lanyaTests toHexData:4000]);
    
    NSAssert(2 == 2, @"xxxx");
}

+ (NSString *)floatHeight:(CGFloat)height {
    NSString *reStr = [NSString stringWithFormat:@"%f", height];
    NSArray<NSString *> *reArray = [reStr componentsSeparatedByString:@"."];

    NSString *result;
    if (reArray.count == 1) {
       result = [NSString stringWithFormat:@"%@.%@", reArray[0], @"0"];
    }else {
       NSString *pStr = reArray[0];
       NSString *sStr = [reArray[1] substringToIndex:1];
       result = [NSString stringWithFormat:@"%@.%@", pStr, sStr];
    }
    NSLog(@"result %f -> %@", height, result);
    return result;
}

+ (NSString *)toHexData:(int)num {
    NSString *hex = [[self ToHex:num] uppercaseString];
    if(hex.length == 1){
        hex = [NSString stringWithFormat:@"000%@",hex];
    }else if (hex.length == 2){
        hex = [NSString stringWithFormat:@"00%@",hex];
    }else if (hex.length == 3){
        hex = [NSString stringWithFormat:@"0%@",hex];
    }
    return hex;
}

//十进制转十六进制
+ (NSString *)ToHex:(uint16_t)tmpid {
    NSString *nLetterValue;
    NSString *str = @"";
    uint16_t ttmpig;
    for (int i = 0; i < 9; i++) {
        ttmpig = tmpid % 16;
        tmpid = tmpid / 16;
        switch (ttmpig) {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
