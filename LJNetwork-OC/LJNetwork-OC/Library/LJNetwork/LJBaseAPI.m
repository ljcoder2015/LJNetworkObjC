//
//  LJBaseAPI.m
//  NetworkingTest
//
//  Created by ljcoder on 17/2/7.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import "LJBaseAPI.h"
#import "LJNetworkProxy.h"

@interface LJBaseAPI ()

@property (strong, nonatomic) NSMutableArray *requestList;
@end

@implementation LJBaseAPI
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        if ([self conformsToProtocol:@protocol(LJRequestDelegate)]) {
            self.requestDelegate = (id <LJRequestDelegate>)self;
        } else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}

#pragma mark - LJRequestDelegate
- (NSString *)requestMethod {
    return @"GET";
}

- (NSString *)route {
    return @"/";
}

#pragma mark - loadData
- (NSInteger)loadData {
    NSDictionary *parames = [self.parametersDataSource requestParametersWithManager:self];
    NSInteger requestID = [self loadDataWithParames:parames];
    return requestID;
}

- (NSInteger)loadDataWithParames:(NSDictionary *)parames {
    NSString *method = [self.requestDelegate requestMethod];
    NSString *path = [self.requestDelegate route];
    NSInteger requestID = 0;
    if ([method isEqualToString:@"GET"]) {
        requestID = [[LJNetworkProxy sharedInstance] callGETWithPath:path Params:parames success:^(id responseObject, NSError *error) {
            [self.callBackDelegate manager:self requestCallBackSuccess:responseObject];
        } failed:^(id responseObject, NSError *error) {
            if ([self.callBackDelegate respondsToSelector:@selector(manager:requestCallBackFailed:)]) {
                [self.callBackDelegate manager:self requestCallBackFailed:error];
            }
        }];
        [self.requestList addObject:@(requestID)];
    }
    if ([method isEqualToString:@"POST"]) {
        requestID = [[LJNetworkProxy sharedInstance] callPOSTWithPath:path Params:parames success:^(id responseObject, NSError *error) {
            [self.callBackDelegate manager:self requestCallBackSuccess:responseObject];
        } failed:^(id responseObject, NSError *error) {
            if ([self.callBackDelegate respondsToSelector:@selector(manager:requestCallBackFailed:)]) {
                [self.callBackDelegate manager:self requestCallBackFailed:error];
            }
        }];
        [self.requestList addObject:@(requestID)];
    }
    return requestID;
}

#pragma mark - setter & getter
- (NSMutableArray *)requestList {
    if (!_requestList) {
        _requestList = [[NSMutableArray alloc] init];
    }
    return _requestList;
}

#pragma mark - cancel request
- (void)cancelAllRequest {
    [[LJNetworkProxy sharedInstance] cancelTaskWithTaskList:self.requestList];
}

#pragma mark - dealloc
- (void)dealloc {
    [self cancelAllRequest];
}

@end
