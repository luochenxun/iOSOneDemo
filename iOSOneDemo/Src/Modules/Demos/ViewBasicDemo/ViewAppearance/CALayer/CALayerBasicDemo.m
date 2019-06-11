//
// CALayerBasicDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "CALayerBasicDemo.h"


@interface CALayerBasicDemoCustomLayer : CALayer
@end

@implementation CALayerBasicDemoCustomLayer

- (void)display
{
    // 使用绘图或其它方法得到 image，再利用设置 contents输出图象
    UIImage *image = [UIImage imageNamed:@"earth"];
    self.contents = (id)image.CGImage;
}

@end

@interface CALayerBasicDemoCustomLayer2 : CALayer
@end


@implementation CALayerBasicDemoCustomLayer2

- (void)drawInContext:(CGContextRef)context
{
    CGContextAddArc(context, 20, 20, 10, 0, 2 * M_PI, 1); // 画圆
    CGContextSetLineWidth(context, 3); // 设置线粗
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 画线的颜色
    CGContextStrokePath(context); // 画线
}

@end


@interface CALayerBasicDemo ()

@end

@implementation CALayerBasicDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:CALayerBasicDemo.class];
}

+ (NSString *)displayName {
    return @"CALayer基础";
}

+ (NSString *)name {
    return @"CALayerBasicDemo";
}

+ (NSString *)parentName {
    return @"CALayerDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1.0";
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
    self.title = @"CALayer基础";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {

}

- (void)initUI {
    // -------  CALayer定位
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@" 示例1 - CALayer的contents属性 "];
    
    CALayer *contentLayer = [CALayer new];
    UIImage *image = [UIImage imageNamed:@"earth"];
    contentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    contentLayer.contents = (__bridge id)image.CGImage; // 注意，这里要使用CGImage
    UIView *layerFrame = [UIView new];
    [layerFrame.layer addSublayer:contentLayer];
    layerFrame.flexSize = image.size;
    
    [self addDescriptionOnView:demo1 withText:@"使用 ImageView 显示图片："];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.flexSize = CGSizeMake(image.size.width, image.size.height);
    [demo1 flex_addSubview:imageView];
    
    [self addDescriptionOnView:demo1 withText:@"使用 contents 属性在layer上绘制图片："];
    [demo1 flex_addSubview:layerFrame];

    [self addDescriptionOnView:demo1 withText:@"使用 contentGravity-kCAGravityResize 显示缩放图片："];
    contentLayer = [CALayer new];
    contentLayer.backgroundColor = [UIColor yellowColor].CGColor;
    image = [UIImage imageNamed:@"earth"];
    contentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height/2); // 图片宽度缩一倍
    contentLayer.position = CGPointMake(image.size.width/2, image.size.height/2);
    contentLayer.contents = (__bridge id)image.CGImage; // 注意，这里要使用CGImage
    contentLayer.contentsGravity = kCAGravityResize;
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:contentLayer];
    layerFrame.flexSize = image.size;
    [demo1 flex_addSubview:layerFrame];
    
    [self addDescriptionOnView:demo1 withText:@"使用 contentGravity-kCAGravityResizeAspect 显示缩放图片："];
    contentLayer = [CALayer new];
    contentLayer.backgroundColor = [UIColor yellowColor].CGColor;
    image = [UIImage imageNamed:@"earth"];
    contentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height/2); // 图片宽度缩一倍
    contentLayer.position = CGPointMake(image.size.width/2, image.size.height/2);
    contentLayer.contents = (__bridge id)image.CGImage; // 注意，这里要使用CGImage
    contentLayer.contentsGravity = kCAGravityResizeAspect;
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:contentLayer];
    layerFrame.flexSize = image.size;
    [demo1 flex_addSubview:layerFrame];
    
    [self addDescriptionOnView:demo1 withText:@"使用 contentGravity-kCAGravityResizeAspectFill 显示缩放图片："];
    contentLayer = [CALayer new];
    contentLayer.backgroundColor = [UIColor yellowColor].CGColor;
    image = [UIImage imageNamed:@"earth"];
    contentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height/2); // 图片宽度缩一倍
    contentLayer.position = CGPointMake(image.size.width/2, image.size.height/2);
    contentLayer.contents = (__bridge id)image.CGImage; // 注意，这里要使用CGImage
    contentLayer.contentsGravity = kCAGravityResizeAspectFill;
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:contentLayer];
    layerFrame.flexSize = image.size;
    [demo1 flex_addSubview:layerFrame];
    
    [self addDescriptionOnView:demo1 withText:@"使用 contentGravity-kCAGravityCenter 显示缩放图片："];
    contentLayer = [CALayer new];
    contentLayer.backgroundColor = [UIColor yellowColor].CGColor;
    image = [UIImage imageNamed:@"earth"];
    contentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height/2); // 图片宽度缩一倍
    contentLayer.position = CGPointMake(image.size.width, image.size.height);
    contentLayer.contents = (__bridge id)image.CGImage; // 注意，这里要使用CGImage
    contentLayer.contentsGravity = kCAGravityCenter;
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:contentLayer];
    layerFrame.flexSize = CGSizeMake(image.size.width*2, image.size.height*2);
    [demo1 flex_addSubview:layerFrame];
    
    [self addDescriptionOnView:demo1 withText:@"使用 contentGravity-kCAGravityCenter 显示缩放图片（设置contentsScale）："];
    contentLayer = [CALayer new];
    contentLayer.backgroundColor = [UIColor yellowColor].CGColor;
    image = [UIImage imageNamed:@"earth"];
    contentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height/2); // 图片宽度缩一倍
    contentLayer.position = CGPointMake(image.size.width/2, image.size.height/2);
    contentLayer.contents = (__bridge id)image.CGImage; // 注意，这里要使用CGImage
    contentLayer.contentsScale = [UIScreen mainScreen].scale;
    contentLayer.contentsGravity = kCAGravityCenter;
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:contentLayer];
    layerFrame.flexSize = image.size;
    [demo1 flex_addSubview:layerFrame];
    


    // -------  绘制CALayer
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"示例2 - 绘制CALayer"];

    [self addDescriptionOnView:demo2 withText:@"使用display绘图："];
    CALayerBasicDemoCustomLayer *customLayer = [CALayerBasicDemoCustomLayer new];
    customLayer.frame = CGRectMake(0, 0, 100, 100);
    [customLayer setNeedsDisplay]; // 重要！
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:customLayer];
    layerFrame.flexSize = CGSizeMake(200, 200);
    [demo2 flex_addSubview:layerFrame];
    
    CALayerBasicDemoCustomLayer2 *customLayer2 = [CALayerBasicDemoCustomLayer2 new];
    customLayer2.frame = CGRectMake(0, 0, 100, 100);
    [customLayer2 setNeedsDisplay]; // 重要！
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:customLayer2];
    layerFrame.flexSize = CGSizeMake(200, 200);
    
    [self addDescriptionOnView:demo2 withText:@"使用drawInContext绘图："];
    [demo2 flex_addSubview:layerFrame];
    
    NSLog(@"自定义Layer的contentScale : %f", customLayer2.contentsScale);
    NSString *logStr = [NSString stringWithFormat:@"自定义Layer的contentScale : %f", customLayer2.contentsScale];
    [self addDescriptionOnView:demo2 withText:logStr];
    
    
    
    // -------  CALayer 属性
    FlexLinearLayout *demo3 = [self addDemoBoxWithTitle:@" 示例3 - CALayer的布局与定位 "];
    
    UIView *view1 = [UIView new];
    view1.layer.backgroundColor = [UIColor yellowColor].CGColor;
    view1.flexSize = CGSizeMake(200, 200);
    [demo3 flex_addSubview:view1];
    
    // 把红色的 layer1 放在外层 layer的中间
    CALayer *layer1 = [CALayer new];
    layer1.bounds = CGRectMake(0, 0, 70, 50);
    layer1.position = CGPointMake(100, 100); // 设置定位在外层layer的中点
    layer1.anchorPoint = CGPointMake(0.5, 0.5); // 设置锚点在本layer的中间
    layer1.backgroundColor = [UIColor redColor].CGColor;
    [view1.layer addSublayer:layer1];
    
    // 把蓝色的 layer2 放在外层 layer的左上角
    CALayer *layer2 = [CALayer new];
    layer2.bounds = CGRectMake(0, 0, 30, 20);
    layer2.position = CGPointMake(0, 0); // 设置定位在外层layer的左上角
    layer2.anchorPoint = CGPointMake(0, 0); // 设置锚点在layer的左上角
    layer2.backgroundColor = [UIColor blueColor].CGColor;
    [view1.layer addSublayer:layer2];
    
    
    
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












