//
//  XXXXViewProtocal.h
//  jiayoubao
//
//  Created by luochenxun on 2017/6/23.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#ifndef XXXXViewProtocal_h
#define XXXXViewProtocal_h

#import "XXXXAppTheme.h"

@protocol XXXXViewProtocal <NSObject>

@required

- (instancetype)initWithTheme:(XXXXAppTheme *)theme;

/** 设置控件的主题 */
- (void)setTheme:(XXXXAppTheme *)theme;

@end

#endif /* XXXXViewProtocal_h */
