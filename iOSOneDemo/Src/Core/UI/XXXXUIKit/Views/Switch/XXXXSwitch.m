//
//  XXXXSwitch.m
//  jiayoubao
//
//  Created by luochenxun on 2017/12/25.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXSwitch.h"

@implementation XXXXSwitch

- (instancetype)init {
    if (self = [super init]) {
        [self setFlexSize:CGSizeMake(40, 24)];
        self.transform = CGAffineTransformMakeScale(0.8, 0.77);
        self.tintColor = kAppColor.divider;
        self.onTintColor = kAppColor.main;
        
        [self addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


- (void)onSwitchPress:(XXXXSwitchBlock)block {
    _block = block;
}


- (void)switchAction:(id)sender {
    XXXXSwitch *switchButton = (XXXXSwitch*)sender;
    
    if (self.block) {
        self.block(switchButton.isOn);
    }
}

@end
