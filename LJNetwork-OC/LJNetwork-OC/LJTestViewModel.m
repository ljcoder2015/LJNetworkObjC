//
//  LJTestViewModel.m
//  LJNetwork-OC
//
//  Created by 雷军 on 2017/4/16.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import "LJTestViewModel.h"
#import "LJTestAPI.h"

@interface LJTestViewModel () <LJRequestParametersDataSource, LJRequestCallBackDelegate>

@property (strong, nonatomic) LJTestAPI *testAPI;

@end

@implementation LJTestViewModel

#pragma mark- setter & getter
- (LJTestAPI *)testAPI {
    if (!_testAPI) {
        _testAPI = [[LJTestAPI alloc] init];
        _testAPI.parametersDataSource = self;
        _testAPI.callBackDelegate = self;
    }
    return _testAPI;
}

- (void)initialize {
    
    @weakify(self);
    self.dataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [self.testAPI rac_loadData];
    }];
}
    
#pragma mark - LJRequestParametersDataSource
- (NSDictionary *)requestParametersWithManager:(LJBaseAPI *)manager {
    
    if (manager == self.testAPI) {
        return @{@"key": @"374910422", @"location": @"121.45429%2C31.228", @"output": @"json"};
    }
    return @{};
}
    
#pragma mark - LJRequestCallBackDelegate
- (void)manager:(LJBaseAPI *)manager requestCallBackSuccess:(id)responseObject {
    
    if (manager == self.testAPI) {
        
        self.text = [NSString stringWithFormat:@"%@", responseObject];
    }
}
    
@end
