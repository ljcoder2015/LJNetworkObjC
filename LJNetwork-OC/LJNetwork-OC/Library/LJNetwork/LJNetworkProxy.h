//
//  LJNetworkProxy.h
//  NetworkingTest
//
//  Created by ljcoder on 17/2/24.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LJCallBack)(id responseObject, NSError *error);

@interface LJNetworkProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithPath:(NSString *)path Params:(NSDictionary *)params success:(LJCallBack)sucess failed:(LJCallBack)failed;
- (NSInteger)callPOSTWithPath:(NSString *)path Params:(NSDictionary *)params success:(LJCallBack)sucess failed:(LJCallBack)failed;

- (NSNumber *)uploadImage:(NSData *)imageData path:(NSString *)path params:(NSDictionary *)params name:(NSString *)name success:(LJCallBack)sucess failed:(LJCallBack)failed;
- (void)uploadImage:(NSData *)imageData urlString:(NSString *)urlString name:(NSString *)name params:(id)params callback:(void(^)(id response, NSError *error))complete;

- (void)cancelTaskWithTaskID:(NSNumber *)taskID;
- (void)cancelTaskWithTaskList:(NSArray *)taskList;

@end
