//
// CALayerPropertyDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "CALayerPropertyDemo.h"



@interface CALayerPropertyDemo ()

@end

@implementation CALayerPropertyDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:CALayerPropertyDemo.class];
}

+ (NSString *)displayName {
    return @"CALayer 边框、阴影等显示属性";
}

+ (NSString *)name {
    return [CALayerPropertyDemo className];
}

+ (NSString *)parentName {
    return @"CALayerDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1.1";
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
    self.title = [CALayerPropertyDemo displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {

}

- (void)initUI {
    // -------  CALayer定位
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@" 示例1 边框与阴影"];
    
    [self addDescriptionOnView:demo1 withText:@"显示一个卡片"];
    UIView *cardView = [UIView new];
    cardView.backgroundColor = [UIColor whiteColor];
    cardView.flex_alignSelf = FlexAlignSelf_center;
    cardView.flexSize = CGSizeMake(250, 100);
    cardView.layer.borderWidth = kAppDimension.lineWidth;
    cardView.layer.borderColor = kAppColor.dividerDark.CGColor;
    cardView.layer.cornerRadius = 6.0;
    cardView.layer.shadowColor = UIColor.blackColor.CGColor;
    cardView.layer.shadowOpacity = 0.5;
    cardView.layer.shadowRadius = 5.0;
    cardView.layer.shadowOffset = CGSizeMake(2, 4);
    [demo1 flex_addSubview:cardView];
    
    [self addDescriptionOnView:demo1 withText:@"给图片加阴影"];
    UIView *frameView = [UIView new];
    frameView.flex_alignSelf = FlexAlignSelf_center;
    frameView.flexSize = CGSizeMake(100, 100);
    CALayer *layer = [CALayer new];
    layer.frame = CGRectMake(0, 0, 100, 100);
    UIImage *img = [UIImage imageNamed:@"rain"];
    layer.contents = (id)img.CGImage;
    layer.shadowColor = UIColor.blackColor.CGColor;
    layer.shadowOpacity = 0.5;
    layer.shadowRadius = 5.0;
    layer.shadowOffset = CGSizeMake(2, 4);
    [frameView.layer addSublayer:layer];
    [demo1 flex_addSubview:frameView];
    
    
    // -------  demo2
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"示例2 图层蒙板"];
    
    // mask属性制作渐变色字
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.contentsScale = [UIScreen mainScreen].scale;
    gradientLayer.frame = CGRectMake(0, 0, 200, 30);
    [gradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
    [gradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];
    // label
    CATextLayer *labelLayer =[CATextLayer layer];
    labelLayer.contentsScale = [UIScreen mainScreen].scale;
    labelLayer.string = @"红黄绿渐变~~";
    labelLayer.bounds = CGRectMake(0, 0, 200, 30);
    labelLayer.font = (__bridge CFTypeRef _Nullable)(@"HelveticaNeue-BoldItalic");
    labelLayer.fontSize = 20.f; //字体的大小
    labelLayer.position = CGPointMake(100, 15);
    labelLayer.foregroundColor =[UIColor blackColor].CGColor; //字体的颜色
    
    // output
    UIView *layerFrame = [UIView new];
    [layerFrame.layer addSublayer:gradientLayer];
    gradientLayer.mask = labelLayer; // 注意要先添加layer再设置mask
    layerFrame.flexSize = CGSizeMake(200, 50);
    [self addDescriptionOnView:demo2 withText:@"使用mask属性制作渐变色字："];
    [demo2 flex_addSubview:layerFrame];
    
    
    
    
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












