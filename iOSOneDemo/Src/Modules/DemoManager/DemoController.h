//
//  Demo.h
//  XXXX
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "XXXXBaseViewController.h"

@interface DemoController : XXXXBaseViewController


@property (nonatomic, strong) FlexScrollLayout *outerBox;

- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title;
- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title
                                     size:(CGSize)size;

@end
