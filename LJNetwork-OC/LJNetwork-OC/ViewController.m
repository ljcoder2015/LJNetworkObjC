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

@property (strong, nonatomic) UIButton *requestButton;
@property (strong, nonatomic) UITextView *responsTextView;

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
    self.requestButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:@"Start Request" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(reqeust:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:self.requestButton];
    
    [self.requestButton sizeToFit];
    self.requestButton.center = self.view.center;
    
    self.responsTextView = ({
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, self.view.center.y+30, self.view.bounds.size.width-20, self.view.bounds.size.height-self.view.center.y-30)];
        textView.layer.borderColor = [UIColor orangeColor].CGColor;
        textView.layer.borderWidth = 1;
        textView.editable = NO;
        textView;
    });
    [self.view addSubview:self.responsTextView];
    
}

- (void)reqeust:(UIButton *)button {
    self.responsTextView.text = @"";
    [self.testAPI loadData];
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
        
        NSLog(@"responseObject = %@", responseObject);
        self.responsTextView.text = [NSString stringWithFormat:@"%@", responseObject];
    }
}

@end
