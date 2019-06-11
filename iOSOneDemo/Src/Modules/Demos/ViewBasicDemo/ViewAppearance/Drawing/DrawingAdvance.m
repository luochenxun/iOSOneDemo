//
// DrawingAdvance.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

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
    // -------  Paths & Shapes
    FlexLinearLayout *pathDemo = [self addDemoBoxWithTitle:@" Paths & Shapes "];
    pathDemo.alignItems = FlexAlignSelf_center;
    
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 在一个 300x300的画布上stroke一个三角形
    CGContextMoveToPoint(context, 150, 10); // 落笔，先将笔触移到画布的某点（三角形顶点）
    CGContextAddLineToPoint(context, 10, 280); // 分别连接另两个顶点的线
    CGContextAddLineToPoint(context, 280, 280);
    CGContextClosePath(context);
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
    
    
    // 画矩形
    UIGraphicsBeginImageContext(CGSizeMake(80, 80));
    context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, CGRectMake(10, 10, 50, 50)); // 画一个矩形
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor); // fillCOlor
    CGContextFillPath(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self addDescriptionOnView:pathDemo withText:@"fill一个矩形"];
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:CGSizeMake(80, 80)];
    [pathDemo flex_addSubview:iv];
    
    // 画椭圆与圆
    UIGraphicsBeginImageContext(CGSizeMake(300, 150));
    context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 50, 50)); // 画一个圆
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor); // fillCOlor
    CGContextFillPath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(70, 0, 50, 100)); // 画一个xrc
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor); // fillCOlor
    CGContextFillPath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(70, 0, 50, 100)); // 画一个椭
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor); // fillCOlor
    CGContextFillPath(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self addDescriptionOnView:pathDemo withText:@"fill一个圆"];
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    iv.contentMode = UIViewContentModeCenter;
    [iv setFlexSize:CGSizeMake(300, 150)];
    [pathDemo flex_addSubview:iv];
    
    // 画弧
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context, 20, 20, 10, 0, 2 * M_PI, 1); // 画圆
    CGContextSetLineWidth(context, 3); // 设置线粗
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 画线的颜色
    CGContextStrokePath(context); // 画线
    CGContextAddArc(context, 60, 20, 10, 0, M_PI/2.0, 1); // 逆时针画条从0到pi/2的弧
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor); // 画线的颜色
    CGContextStrokePath(context); // 画线
    CGContextAddArc(context, 20, 60, 10, 0, M_PI/2.0, 0); // 顺时针画条从0到pi/2的弧
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor); // 画线的颜色
    CGContextStrokePath(context); // 画线
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self addDescriptionOnView:pathDemo withText:@"画各种弧形"];
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    iv.contentMode = UIViewContentModeCenter;
    [iv setFlexSize:CGSizeMake(100, 100)];
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












