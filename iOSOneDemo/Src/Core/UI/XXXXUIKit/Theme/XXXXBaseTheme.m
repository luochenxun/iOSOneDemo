//
//  XXXXBaseTheme.m
//  jiayoubao
//
//  Created by luochenxun on 2017/6/13.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXBaseTheme.h"
#import <objc/runtime.h>


@implementation UIFont (BoldFontStyle)

- (UIFont *)medium {
    return [UIFont systemFontOfSize:self.pointSize weight:UIFontWeightMedium];
}

- (UIFont *)bold {
    return [UIFont boldSystemFontOfSize:self.pointSize];
}

@end


@implementation XXXXBaseFontStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _h1 = XXXX_SYS_FONT(20);
        _h2 = XXXX_SYS_FONT(18);
        _h3 = XXXX_SYS_FONT(17);
        _h4 = XXXX_SYS_FONT(15);
        _h5 = XXXX_SYS_FONT(13);
        _h6 = XXXX_SYS_FONT(10);
    }
    return self;
}

- (UIFont *)fontOfSize:(CGFloat)size {
    return XXXX_SYS_FONT(size);
}


@end


@implementation XXXXBaseColorStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _main = XXXX_COLOR_HEX(0xff6e34);
        _disable = XXXX_COLOR_HEX(0xcccccc);
        _s1 = XXXX_COLOR_HEX(0xff3030);
        _s2 = XXXX_COLOR_HEX(0x0183ff);
        _s3 = XXXX_COLOR_HEX(0x5ccb0a);
        _bg = XXXX_COLOR_HEX(0xf5f5f5);
        _brightBg = XXXX_COLOR_HEX(0xffffff);
        _brightBgHighLight = XXXX_COLOR_HEX(0xf2f2f2);
        _divider = XXXX_COLOR_HEX(0xe6e6e6);
        _dividerDark = XXXX_COLOR_HEX(0xb6b6b6);
        _h1 = XXXX_COLOR_HEX(0x333333);
        _h2 = XXXX_COLOR_HEX(0x999999);
        _content = XXXX_COLOR_HEX(0x666666);
        _tips = XXXX_COLOR_HEX(0xcccccc);
        _navi = XXXX_COLOR_HEX(0x515151);
        _inverse = XXXX_COLOR_HEX(0xffffff);
        _shadow = XXXX_COLOR_HEX(0x393f44);
        
        // 按钮颜色
        _buttonDefault = _main;
        _buttonDefaultText = XXXX_COLOR_HEX(0xffffff);
        _buttonDefaultTextPress = XXXX_COLOR_HEX(0xD9D9D9);
        _buttonDefaultPress = XXXX_COLOR_HEX(0xd95d2c);
        _buttonLight = XXXX_COLOR_HEX(0xffffff);
        _buttonLightPress = XXXX_COLOR_HEX(0xededed);
        _buttonLightText = XXXX_COLOR_HEX(0x666666);
        _buttonLightTextPress = XXXX_COLOR_HEX(0x606060);
        _buttonDark = _buttonDefault;
        _buttonDarkText = XXXX_COLOR_HEX(0xffffff);
        _buttonDarkTextPress = _buttonDarkText;
        _buttonDarkPress = _buttonDefaultPress;
        
        // alertView
        _alertViewBg = XXXX_COLOR_HEX(0xfafafa);
        _alertMainBtnColor = XXXX_COLOR_HEX(0xfafafa);
        _alertMainBtnPreColor = XXXX_COLOR_HEX(0xededed);
        _alertMainBtnTxtColor = _main;
        _alertMainBtnTxtPreColor = XXXX_COLOR_HEX(0xf26831);
        _alertDefaultBtnColor = _alertMainBtnColor;
        _alertDefaultBtnPreColor = _alertMainBtnPreColor;
        _alertDefaultBtnTxtColor = XXXX_COLOR_HEX(0x666666);
        _alertDefaultBtnTxtPreColor = XXXX_COLOR_HEX(0x606060);
        
        _blockBgColor = XXXX_COLOR(248, 249, 250);
    }
    return self;
}

- (UIColor *)colorWithValue:(long long)value {
    return XXXX_COLOR_HEX(value);
}

@end

@implementation XXXXBaseDimensionStyle

- (instancetype)init {
    if (self = [super init]) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        _navigationBarHeight = 44;
        _tabBarHeight = 49;
        
        if (IS_IPHONE_X) {
            _indicatorHeight = 34;
        } else {
            _indicatorHeight = 0;
        }
        
        _contentHeight = _screenHeight - _statusBarHeight - _navigationBarHeight - _indicatorHeight;
        _tabbarContentHeight = _contentHeight - _tabBarHeight;
        
        _marginLeftRight = 15;
        _contentWidth = _screenWidth - 2 * _marginLeftRight;
        _cornerRadius = 3;
        _lineWidth = 1 / [UIScreen mainScreen].scale;
        
        _buttonHeight = 50;
        _bottomButtonHeight = 56;
        _listItemHeight = 52.0;
 
    }
    
    return self;
}


@end


#pragma mark - < 主类定义 >

@interface XXXXBaseTheme()
@end


@implementation XXXXBaseTheme

+ (instancetype)sharedInstance{
    id instance = objc_getAssociatedObject(self, @"instance");
    
    if (!instance) {
        instance = [[super allocWithZone:NULL] init];
        objc_setAssociatedObject(self, @"instance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone{
    Class selfClass = [self class];
    return [selfClass sharedInstance] ;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseFontStyle = [[XXXXBaseFontStyle alloc] init];
        _baseColorStyle = [[XXXXBaseColorStyle alloc] init];
        _baseDimensionStyle = [[XXXXBaseDimensionStyle alloc] init];
    }
    
    return self;
}

- (NSString *)hexWithColor:(UIColor *)color {
    const CGFloat *cs = CGColorGetComponents(color.CGColor);
    
    NSString *r = [NSString stringWithFormat:@"%@",[self hexWithInt:cs[0] * 255]];
    NSString *g = [NSString stringWithFormat:@"%@",[self hexWithInt:cs[1] * 255]];
    NSString *b = [NSString stringWithFormat:@"%@",[self hexWithInt:cs[2] * 255]];
    
    return [NSString stringWithFormat:@"#%@%@%@", r, g, b];
}

// 10进制转16进制
- (NSString *)hexWithInt:(long long int)tmpid {
    NSString *nLetterValue;
    NSString *str = @"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig = tmpid % 16;
        tmpid = tmpid / 16;
        switch (ttmpig) {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}

@end























