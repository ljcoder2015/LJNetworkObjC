//
//  LJNetworkProxy.m
//  NetworkingTest
//
//  Created by ljcoder on 17/2/24.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import "LJNetworkProxy.h"
#import <AFNetworking/AFNetworking.h>
#import "LJNetworkConfigure.h"

@interface LJNetworkProxy ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSMutableDictionary *dispathTable;

@end

@implementation LJNetworkProxy

#pragma mark - init
+ (instancetype)sharedInstance {
    static LJNetworkProxy *networkProxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkProxy = [[LJNetworkProxy alloc] init];
    });
    return networkProxy;
}

#pragma mark - setter & getter
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}

- (NSMutableDictionary *)disapthTable {
    if (!_dispathTable) {
        _dispathTable = [[NSMutableDictionary alloc] init];
    }
    return _dispathTable;
}

#pragma mark - request
- (NSInteger)callGETWithPath:(NSString *)path Params:(NSDictionary *)params success:(LJCallBack)sucess failed:(LJCallBack)failed {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@%@", kLJNetworkDomain, path] parameters:params error:nil];
    NSNumber *taskID = [self callRequest:request success:sucess failed:failed];
    return [taskID integerValue];
}

- (NSInteger)callPOSTWithPath:(NSString *)path Params:(NSDictionary *)params success:(LJCallBack)sucess failed:(LJCallBack)failed {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@", kLJNetworkDomain, path] parameters:params error:nil];
    NSNumber *taskID = [self callRequest:request success:sucess failed:failed];
    return [taskID integerValue];
}

- (NSNumber *)callRequest:(NSMutableURLRequest *)request success:(LJCallBack)sucess failed:(LJCallBack)failed {
    
    
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        id requestBody = [[NSString alloc] initWithData:request.HTTPBody?:[NSData data] encoding:NSUTF8StringEncoding];
        
        if (error) {
            NSLog(@"\n================LJNetwork response start================\nURL: %@\nstatus code: %@\nrequest method: %@\nrequest header:\n%@\n\nrequest body:\n%@\n\nerror:\n%@\n================LJNetwork response end================\n",request.URL, @(httpResponse.statusCode), request.HTTPMethod, request.allHTTPHeaderFields, requestBody, error.localizedDescription);
            // 失败回调
            if (failed) {
                failed(nil, error);
            }
            return ;
        }
        // 打印请求信息
        id responseObj = [NSJSONSerialization JSONObjectWithData:responseObject?:[NSData data] options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"\n================LJNetwork response start================\n---URL: %@\nstatus code: %@\nrequest method: %@\nreqeust header:\n%@\n\nrequest body:\n%@\n\nresponseObject:\n%@\n================LJNetwork response end================\n",request.URL, @(httpResponse.statusCode), request.HTTPMethod, request.allHTTPHeaderFields, requestBody, responseObj);
        // 成功回调
        if (sucess) {
            sucess(responseObj, nil);
        }
    }];
    [task resume];
    
    NSNumber *requestID = @([task taskIdentifier]);
    [self.dispathTable setObject:task forKey:requestID];
    
    return requestID;
}

#pragma mark - uplaodImage
- (NSNumber *)uploadImage:(NSData *)imageData path:(NSString *)path params:(NSDictionary *)params success:(LJCallBack)sucess failed:(LJCallBack)failed {
    NSNumber *requestID = nil;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@", kLJNetworkDomain, path] parameters:params error:nil];
    requestID = [self uploadImage:imageData request:request uploadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        id requestBody = [[NSString alloc] initWithData:request.HTTPBody?:[NSData data] encoding:NSUTF8StringEncoding];
        
        if (error) {
            // 打印请求信息
            NSLog(@"\n================LJNetwork response start================\nURL: %@\nstatus code: %@\nrequest method: %@\nrequest header:\n%@\n\nrequest body:\n%@\n\nerror:\n%@\n================LJNetwork response end================\n",request.URL, @(httpResponse.statusCode), request.HTTPMethod, request.allHTTPHeaderFields, requestBody, error.localizedDescription);
            // 失败回调
            if (failed) {
                failed(nil, error);
            }
            return ;
        }
        // 打印请求信息
        id responseObj = [NSJSONSerialization JSONObjectWithData:responseObject?:[NSData data] options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"\n================LJNetwork response start================\n---URL: %@\nstatus code: %@\nrequest method: %@\nreqeust header:\n%@\n\nrequest body:\n%@\n\nresponseObject:\n%@\n================LJNetwork response end================\n",request.URL, @(httpResponse.statusCode), request.HTTPMethod, request.allHTTPHeaderFields, requestBody, responseObj);
        // 成功回调
        if (sucess) {
            sucess(responseObj, nil);
        }
        
    }];
    return requestID;
}

- (NSNumber *)uploadImage:(NSData *)imageData request:(NSMutableURLRequest *)request uploadProgress:(void(^)(NSProgress * _Nonnull uploadProgress))progress completionHandler:(void(^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))completionHandler {
    NSURLSessionUploadTask *uploadTask = [self.sessionManager uploadTaskWithRequest:request fromData:imageData progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(response, responseObject, error);
        }
    }];
    [uploadTask resume];
    
    NSNumber *requestID = @([uploadTask taskIdentifier]);
    [self.dispathTable setObject:uploadTask forKey:requestID];
    
    return requestID;
}

#pragma mark - cancel request
- (void)cancelTaskWithTaskID:(NSNumber *)taskID {
    
    if ([[self.dispathTable allKeys] containsObject:taskID]) {
        NSURLSessionTask *task = [self.dispathTable objectForKey:taskID];
        [task cancel];
        [self.dispathTable removeObjectForKey:taskID];
    }
    
}

- (void)cancelTaskWithTaskList:(NSArray *)taskList {
    for (NSNumber *taskID in taskList) {
        [self cancelTaskWithTaskID:taskID];
    }
}

@end
