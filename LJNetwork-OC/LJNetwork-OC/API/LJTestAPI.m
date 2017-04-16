//
//  LJTestAPI.m
//  LJNetwork-OC
//
//  Created by ljcoder on 17/3/13.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import "LJTestAPI.h"

@implementation LJTestAPI

#pragma mark - LJRequestDelegate
- (NSString *)requestMethod {
    return @"GET";
}

- (NSString *)route {
    return @"geocode/regeo";
}

@end
