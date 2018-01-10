//
//  XXXXBaseViewController.m
//  XXXX
//
//  Created by luochenxun on 15/12/9.
//  Copyright © 2015年 Kacha-Mobile. All rights reserved.
//

#import "XXXXBaseViewController.h"

@interface XXXXBaseViewController ()

@end

@implementation XXXXBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 下一个界面的返回按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"返回";
    backBtn.target = self;
    backBtn.action = @selector(back:);
    self.navigationItem.backBarButtonItem = backBtn;
}

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
