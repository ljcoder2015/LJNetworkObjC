//
//  ViewController.m
//  LJNetwork-OC
//
//  Created by ljcoder on 17/3/13.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import "ViewController.h"
#import "LJTestAPI.h"

@interface ViewController () <LJRequestParametersDataSource, LJRequestCallBackDelegate>

@property (strong, nonatomic) LJTestAPI *testAPI;

@end

@implementation ViewController

#pragma mark- setter & getter
- (LJTestAPI *)testAPI {
    if (!_testAPI) {
        _testAPI = [[LJTestAPI alloc] init];
        _testAPI.parametersDataSource = self;
        _testAPI.callBackDelegate = self;
    }
    return _testAPI;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LJRequestParametersDataSource
- (NSDictionary *)requestParametersWithManager:(LJBaseAPI *)manager {
    
    if (manager == self.testAPI) {
        return @{};
    }
    return @{};
}

#pragma mark - LJRequestCallBackDelegate
- (void)manager:(LJBaseAPI *)manager requestCallBackSuccess:(id)responseObject {
    
    if (manager == self.testAPI) {
        
        NSLog(@"%@", responseObject);
    }
}

@end
