//
//  LJBaseAPI.h
//  NetworkingTest
//
//  Created by ljcoder on 17/2/7.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class LJBaseAPI;

@protocol LJRequestDelegate <NSObject>

@required

/**
 设置请求方式(暂时只实现了GET和POST)

 @return GET/POST
 */
- (NSString *)requestMethod;

/**
 设置请求路由地址

 @return 返回路由地址
 */
- (NSString *)route;
@end

/********************** 请求参数 ************************/
@protocol LJRequestParametersDataSource <NSObject>

@required

/**
 设置请求参数

 @return 返回请求参数
 */
- (NSDictionary *)requestParametersWithManager:(LJBaseAPI *)manager;
@end

/********************** 请求回调 ************************/
@protocol LJRequestCallBackDelegate <NSObject>

@optional

/**
 请求成功回调代理

 @param manager 当前请求对象
 @param responseObject 响应数据，已做json解析
 */
- (void)manager:(LJBaseAPI *)manager requestCallBackSuccess:(id)responseObject;

    
/**
 请求失败回调代理

 @param manager 当前请求对象
 @param error 错误信息
 */
- (void)manager:(LJBaseAPI *)manager requestCallBackFailed:(NSError *)error;

@end

@interface LJBaseAPI : NSObject <LJRequestDelegate>

@property (weak, nonatomic) id<LJRequestDelegate> requestDelegate;
@property (weak, nonatomic) id<LJRequestParametersDataSource> parametersDataSource;
@property (weak, nonatomic) id<LJRequestCallBackDelegate> callBackDelegate;

/********************** 发起请求 ************************/
    
/**
 请求数据

 @return 请求ID
 */
- (NSInteger)loadData;
    
/**
 上传图片

 @param imageData 图片数据流
 @param name 指定数据的名字，不能为空
 @return 请求ID
 */
- (NSInteger)uploadImage:(NSData *)imageData name:(NSString *)name;

    
/**
 请求数据，并生成一个请求信号

 @return 请求信号
 */
- (RACSignal *)rac_loadData;
    
- (RACSignal *)rac_uploadImage:(NSData *)imageData name:(NSString *)name;
    

@end
