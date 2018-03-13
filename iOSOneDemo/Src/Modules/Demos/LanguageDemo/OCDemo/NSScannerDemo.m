//
//  NSScannerDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "NSScannerDemo.h"

@interface NSScannerDemo ()

@end

@implementation NSScannerDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:NSScannerDemo.class];
}

+ (NSString *)displayName {
    return @"NSScanner";
}

+ (NSString *)name {
    return @"NSScannerDemo";
}

+ (NSString *)parentName {
    return @"OCDemo";
}

+ (NSString *)prioritySerial {
    return @"1.5.0";
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
    self.title = @"NSScanner";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
//   demo1
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@"示例1"];
    demo1.alignItems = FlexAlignSelf_center;
    
    NSString *numStr = @"a 1 b 2 c 3 d 4 e 5 f 6 o";
    [self addDescriptionOnView:demo1 withText:[NSString stringWithFormat:@"----- 查看字符串：\"%@\"中有多少个数字，以及打印数字的位置 ------",numStr]];
    
    NSScanner * scanner = [NSScanner scannerWithString:numStr];
    int numCount = 0;
    NSMutableString *result = [NSMutableString stringWithCapacity:10];
    while (NO == [scanner isAtEnd]) {
        if ([scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:NULL]) {
            int num;
            if ([scanner scanInt:&num]) {
                [result appendString:[NSString stringWithFormat:@"num=%d, index:%ld\n",num, scanner.scanLocation]];
                numCount ++ ;
            }
        }
    }
    
    [self addDescriptionOnView:demo1 withText:[NSString stringWithFormat:@"共 %@ 个数字，数字及位置信息:\n%@",@(numCount),result]];

    // ------- demo2
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"示例2"];
    demo2.alignItems = FlexAlignSelf_center;
    
    NSString *testStr = @"123.321abc137d efg/hij kl";
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"----- 测试所用扫描字符串：%@ ------",testStr]];
    
    NSString *scanStr = @"fg";
    BOOL scanResult;
    
    NSScanner *aScanner = [NSScanner scannerWithString:testStr];
    
    //扫描字符串
    //扫描到指定字符串时停止，返回结果为指定字符串之前的字符串
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner开始位置：%lu",aScanner.scanLocation]];

    NSString *container;
    scanResult = [aScanner scanUpToString:scanStr intoString:&container];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner扫描字符串：%@",scanStr]];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner是否成功：%@",scanResult?@"YES":@"NO"]];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner返回的结果：%@",container]];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner扫描后的位置：%lu",aScanner.scanLocation]];
    
    //扫描整数
    //将会接着上一次扫描结束的位置继续扫描
    [self addDescriptionOnView:demo2 withText:@"--- 扫描整数 [aScanner scanInteger:&anInteger ---"];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner当前scanLocation：%lu",aScanner.scanLocation]];
    NSInteger anInteger;
    scanResult = [aScanner scanInteger:&anInteger];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner是否成功：%@",scanResult?@"YES":@"NO"]];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner返回的结果：%@",@(anInteger)]];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner扫描后的位置：%lu",aScanner.scanLocation]];

    [self addDescriptionOnView:demo2 withText:@"--- 扫描整数(先把location置0) ---"];
    aScanner.scanLocation = 0;
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner当前scanLocation：%lu",aScanner.scanLocation]];
    scanResult = [aScanner scanInteger:&anInteger];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner是否成功：%@",scanResult?@"YES":@"NO"]];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner返回的结果：%@",@(anInteger)]];
    [self addDescriptionOnView:demo2 withText:[NSString stringWithFormat:@"scanner扫描后的位置：%lu",aScanner.scanLocation]];
    
    
    [self.outerBox flex_updateLayout];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >
#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end












