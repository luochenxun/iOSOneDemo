//
// XXXXSwitch.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

//Switch 开关控件
//
//  Usage：
//    XXXXSwitch *jtSwitch = [[XXXXSwitch alloc] init];
//    [jtSwitch onSwitchPress:^(BOOL isOn) {
//        [XXXXAlertView showAlertWithTitle:nil
//                                message:isOn?@"开":@"关"
//                               duration:2];
//    }];

#import <UIKit/UIKit.h>

typedef void (^XXXXSwitchBlock)(BOOL isOn);

@interface XXXXSwitch : UISwitch


@property (nonatomic, copy) XXXXSwitchBlock block;


- (void)onSwitchPress:(XXXXSwitchBlock)block;

@end
