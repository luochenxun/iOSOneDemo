//
//  EncodeDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "EncodeDemo.h"

@interface EncodeDemo ()

@end

@implementation EncodeDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:EncodeDemo.class];
}

+ (NSString *)displayName {
    return @"编码 Demo";
}

+ (NSString *)name {
    return @"EncodeDemo";
}

+ (NSString *)parentName {
    return @"FrameworkDemo";
}

+ (NSString *)prioritySerial {
    return @"3.2.0";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEnvironment];
    [self initWindow];
    [self initUI];
    [self initAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - < Init Methods >

- (void)initWindow {
    self.title = @"编码";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    FlexLinearLayout *box = [self addDemoBoxWithTitle:@"各数据类型转换"];
    
    NSString *aString = @"1234abc";
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"字符串(%@)转成 NSData",aString]];
    
    // utf8
    [self addDescriptionOnView:box withText:@"---- 使用 UTF8 Encoding ----"];
    NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"输出 NSData：%@",aData]];
    
    aString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"将NSData转回NSString：%@",aString]];
    
    // 16进制数字
    [self addDescriptionOnView:box withText:@"---- 字符串每位表示一个16进制数 ----"];
    aData = [self convertHexStrToData:aString];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"输出 NSData：%@",aData]];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"输出2 NSData：%@",[self convertHexStrToData2:aString]]];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"将NSData转回NSString：%@",[self convertDataToHexStr:aData]]];
    
    [box adjustLayoutHeightBySubviews];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >

- (NSData *)convertHexStrToData:(NSString *)str
{
    if (str == nil || str.length == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:10];
    if (str.length % 2 == 0) {
        for (NSUInteger i = 0; i < str.length; i = i+2) {
            unichar highCh = [str characterAtIndex:i];
            unsigned short highByte = [self convertCharToInt:highCh];
            unichar lowCh = [str characterAtIndex:i+1];
            unsigned short lowByte = [self convertCharToInt:lowCh];
            Byte byte = (highByte << 4) | lowByte;
            [hexData appendBytes:&byte length:1];
        }
    } else {
        for (NSUInteger i = 0; i < str.length; i = i+2) {
            unichar highCh = 0;
            unsigned short highByte = 0;
            if (i == 0) {
                highByte = 0;
            } else {
                highCh = [str characterAtIndex:i-1];
                highByte = [self convertCharToInt:highCh];
            }
            unichar lowCh = [str characterAtIndex:i];
            unsigned short lowByte = [self convertCharToInt:lowCh];
            Byte byte = (highByte << 4) | lowByte;
            [hexData appendBytes:&byte length:1];
        }
    }
    return hexData;
}

- (unsigned short)convertCharToInt:(unichar)ch
{
    if (ch >= '0' && ch <= '9') {
        return (ch - '0');
    }
    if (ch >= 'a' && ch <= 'z') {
        return (ch - 'a') + 10;
    }
    if (ch >= 'A' && ch <= 'Z') {
        return (ch - 'A') + 10;
    }
    return 0;
}

- (NSData *)convertHexStrToData2:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}

- (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || data.length == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:data.length];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    if ([string characterAtIndex:0] == '0') {
        return [string substringWithRange:NSMakeRange(1, string.length-1)];
    }
    
    return string;
}

#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end













