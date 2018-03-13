//
//  DrawingAdvance.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "DrawingAdvance.h"

@interface DrawingAdvance ()

@end

@implementation DrawingAdvance


+ (void)load {
    [[DemoManager sharedManager] registerDemo:DrawingAdvance.class];
}

+ (NSString *)displayName {
    return @"绘图进阶";
}

+ (NSString *)name {
    return @"DrawingAdvance";
}

+ (NSString *)parentName {
    return @"DrawingDemo";
}

+ (NSString *)prioritySerial {
    return @"2.6.0";
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
    self.title = @"绘图进阶";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
//    ImageView
    FlexLinearLayout *pathDemo = [self addDemoBoxWithTitle:@" Paths & Shapes "];
    pathDemo.alignItems = FlexAlignSelf_center;
    
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 在一个 300x300的画布上stroke一个三角形
    CGContextMoveToPoint(context, 150, 0); // 落笔，先将笔触移到画布的某点（三角形顶点）
    CGContextAddLineToPoint(context, 0, 300); // 分别连接另两个顶点的线
    CGContextAddLineToPoint(context, 300, 300);
    CGContextSetLineWidth(context, 5); // 设置线粗
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor); // 画线的颜色
    CGContextStrokePath(context); // 画线
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self addDescriptionOnView:pathDemo withText:@"使用stroke画一个三角形"];
    // show the image use a imageview
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:CGSizeMake(300, 300)];
    [pathDemo flex_addSubview:iv];
     
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












