//
//  LJTestViewModel.h
//  LJNetwork-OC
//
//  Created by 雷军 on 2017/4/16.
//  Copyright © 2017年 ljcoder. All rights reserved.
//

#import "LJBaseViewModel.h"

@interface LJTestViewModel : LJBaseViewModel

@property (strong, nonatomic) RACCommand *dataCommand;

@property (copy, nonatomic) NSString *text;

@end
