//
//  LJBaseAPI.h
//  NetworkingTest
//
//  Created by ljcoder on 17/2/7.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LJBaseAPI;

@protocol LJRequestDelegate <NSObject>

@required

/**
 请求方式

 @return GET/POST
 */
- (NSString *)requestMethod;

/**
 路由地址

 @return 返回路由地址
 */
- (NSString *)route;
@end

/********************** 请求参数 ************************/
@protocol LJRequestParametersDataSource <NSObject>

@required

/**
 请求参数

 @return 返回请求参数
 */
- (NSDictionary *)requestParametersWithManager:(LJBaseAPI *)manager;
@end

/********************** 请求回调 ************************/
@protocol LJRequestCallBackDelegate <NSObject>

- (void)manager:(LJBaseAPI *)manager requestCallBackSuccess:(id)responseObject;

@optional
- (void)manager:(LJBaseAPI *)manager requestCallBackFailed:(NSError *)error;

@end

@interface LJBaseAPI : NSObject <LJRequestDelegate>

@property (weak, nonatomic) id<LJRequestDelegate> requestDelegate;
@property (weak, nonatomic) id<LJRequestParametersDataSource> parametersDataSource;
@property (weak, nonatomic) id<LJRequestCallBackDelegate> callBackDelegate;

- (NSInteger)loadData;

- (void)uploadImage:(NSData *)imageData;

@end
