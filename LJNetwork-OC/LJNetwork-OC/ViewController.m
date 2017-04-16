//
//  ViewController.m
//  LJNetwork-OC
//
//  Created by ljcoder on 17/3/13.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import "ViewController.h"
#import "LJTestViewModel.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *requestButton;
@property (strong, nonatomic) UITextView *responsTextView;

@property (strong, nonatomic) LJTestViewModel *viewModel;

@end

@implementation ViewController

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
    
    // viewModel
    [self bindViewModel];
    
}

- (void)bindViewModel {
    self.viewModel = [[LJTestViewModel alloc] init];
    
    [self.viewModel.dataCommand.executionSignals subscribeNext:^(RACSignal *signal) {
       [signal subscribeCompleted:^{
           NSLog(@"请求完成");
       }];
    }];
    
    RAC(self.responsTextView, text) = RACObserve(self.viewModel, text);

}

- (void)reqeust:(UIButton *)button {
    self.responsTextView.text = @"";
    [self.viewModel.dataCommand execute:nil];
}

@end
