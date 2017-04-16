# LJNetwork 使用说明

## 关于 LJNetwork
LJNetwork 是一个网络请求的封装库，是对AFNetworking和ReactiveObjC的高级封装，可以更好的结合MVVM设计模式。

## 使用方法
1. 所有请求都需要新建一个类，继承自`LJBaseAPI`
```objectivec
@interface LJTestAPI : LJBaseAPI
```
2. 请求类需要实现`LJRequestDelegate`,告诉请求的方式和路由

```objectivec
#pragma mark - LJRequestDelegate
- (NSString *)requestMethod {

    return @"GET";
}

- (NSString *)route {

    return @"geocode/regeo";
}
```

3. 请求数据时，需要创建一个实例
```objectivec
#pragma mark- setter & getter
- (LJTestAPI *)testAPI {

    if (!_testAPI) {
        _testAPI = [[LJTestAPI alloc] init];
        _testAPI.parametersDataSource = self;
        _testAPI.callBackDelegate = self;
    }
    return _testAPI;
}
```
4. 实现参数代理
```objectivec
#pragma mark - LJRequestParametersDataSource
- (NSDictionary *)requestParametersWithManager:(LJBaseAPI *)manager {

    if (manager == self.testAPI) {
        return @{@"key": @"374910422", @"location": @"121.45429%2C31.228", @"output": @"json"};
    }
    return @{};
}

```
5. 普通请求和使用信号来请求
- 普通请求
    ```objectivec
    [self.testAPI loadData];
    ```
- 使用信号，使用信号时是创建的冷信号，你还需要订阅信号，让其变成一个热信号才会执行请求。
    ```objectivec
    [[self.testAPI rac_loadData] subscribeNext:^(id  _Nullable x) {

        NSLog(@"%@", x);
    }];
    ```

6. 成功回调
```objectivec
#pragma mark - LJRequestCallBackDelegate
- (void)manager:(LJBaseAPI *)manager requestCallBackSuccess:(id)responseObject {

    if (manager == self.testAPI) {

        // 处理请求成功后的处理逻辑
    }
}

- (void)manager:(LJBaseAPI *)manager requestCallBackFailed:(NSError *)error {

    if (manager == self.testAPI) {

        // 请求出错后的处理逻辑
    }
}
```

## 结合RAC+MVVM
待完善

## 联系我
email：ljcoder@163.com




