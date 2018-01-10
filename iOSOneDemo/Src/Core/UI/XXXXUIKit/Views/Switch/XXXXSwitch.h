//
//  XXXXSwitch.h
//  jiayoubao
//
//  Created by luochenxun on 2017/12/25.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

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
