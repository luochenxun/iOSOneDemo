//
// CoreAnimationDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "CoreAnimationDemo.h"



@interface CoreAnimationDemo ()

@end

@implementation CoreAnimationDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:CoreAnimationDemo.class];
}

+ (NSString *)displayName {
    return @"显示动画 CoreAnimation";
}

+ (NSString *)name {
    return [CoreAnimationDemo className];
}

+ (NSString *)parentName {
    return @"AnimationDemo";
}

+ (NSString *)prioritySerial {
    return @"1.6.0";
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
    self.title = [CoreAnimationDemo displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {

}

- (void)initUI {
    // -------  demo1
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@"示例1 - CABasicAnimation"];
    
    [self addDescriptionOnView:demo1 withText:@"属性动画" color:[UIColor redColor] margin:@[@15,@20,@15,@25]];
    
    UIView *viewFrame = [UIView new];
    viewFrame.flexSize = CGSizeMake(400, 100);
    [demo1 flex_addSubview:viewFrame];
    CALayer *animLayer = [[CALayer alloc] init];
    animLayer.backgroundColor = [UIColor yellowColor].CGColor;
    animLayer.frame = CGRectMake(120, 0, 100, 100);
    [viewFrame.layer addSublayer:animLayer];
    
    [self addButtonOnView:demo1 withText:@"复位" block:^(id btn) {
        animLayer.frame = CGRectMake(120, 0, 100, 100);
        animLayer.backgroundColor = [UIColor yellowColor].CGColor;
    }];
    
    [self addButtonOnView:demo1 withText:@"设置from,to" block:^(id btn) {
        CGPoint startValue = animLayer.position;
        CGPoint endValue = CGPointMake(startValue.x + 200, startValue.y);
        
        [CATransaction setDisableActions:YES];
        // 构造Animation
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
        anim.duration = 1;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        anim.fromValue = [NSValue valueWithCGPoint:startValue];
        anim.toValue = [NSValue valueWithCGPoint:endValue];
        // 开启动画
        [animLayer addAnimation:anim forKey:nil];
    }];
    
    [self addButtonOnView:demo1 withText:@"使用默认from,to" block:^(id btn) {
        CGPoint startValue = animLayer.position;
        CGPoint endValue = CGPointMake(startValue.x + 200, startValue.y);
        
        [CATransaction setDisableActions:YES];
        animLayer.position = endValue;
        // 构造Animation
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
        anim.duration = 1;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        // 开启动画
        [animLayer addAnimation:anim forKey:nil];
    }];
    
    [self addButtonOnView:demo1 withText:@"设置timing等属性" block:^(id btn) {
        CGPoint now = animLayer.position;
        CGPoint startValue = CGPointMake(now.x - 100, now.y);
        CGPoint endValue = CGPointMake(now.x + 100, now.y);
        
        [CATransaction setDisableActions:YES];
        // 构造Animation
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
        anim.duration = 0.5;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        anim.repeatCount = 3;
        anim.autoreverses = YES;
        anim.fromValue = [NSValue valueWithCGPoint:startValue];
        anim.toValue = [NSValue valueWithCGPoint:endValue];
        // 开启动画
        [animLayer addAnimation:anim forKey:nil];
    }];
    
    [self addDescriptionOnView:demo1 withText:@"虚拟属性" color:[UIColor redColor] margin:@[@15,@20,@15,@25]];
    
    viewFrame = [UIView new];
    viewFrame.flexSize = CGSizeMake(300, 80);
    [demo1 flex_addSubview:viewFrame];
    animLayer = [[CALayer alloc] init];
    animLayer.contents = (__bridge id)[UIImage imageNamed:@"rain"].CGImage;
    animLayer.frame = CGRectMake(120, 0, 50, 50);
    [viewFrame.layer addSublayer:animLayer];
    
    [self addButtonOnView:demo1 withText:@"使用属性动画转360度(点了之后没反应)" block:^(id btn) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
        anim.duration = 1;
        anim.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(animLayer.transform, M_PI*2, 0, 0, 1)];
        [animLayer addAnimation:anim forKey:nil];
    }];
    
    [self addButtonOnView:demo1 withText:@"使用CAValueFunction让图片转360度" block:^(id btn) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
        anim.duration = 1;
        anim.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
        anim.toValue = @(M_PI * 2);
        [animLayer addAnimation:anim forKey:nil];
    }];
    
    [self addButtonOnView:demo1 withText:@"使用虚拟属性让图片转360度" block:^(id btn) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anim.duration = 1;
        anim.byValue = @(M_PI * 2);
        [animLayer addAnimation:anim forKey:nil];
    }];
    
    // -------  demo2
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"示例2 - CAKeyframeAnimation"];
    
    // -------  demo3
    FlexLinearLayout *demo3 = [self addDemoBoxWithTitle:@"示例3 - CAAnimationGroup"];
    viewFrame = [UIView new];
    viewFrame.flexSize = CGSizeMake(300, 200);
    [demo3 flex_addSubview:viewFrame];
    // 关键帧动画的路径
    UIBezierPath *animPath = [[UIBezierPath alloc] init];
    [animPath moveToPoint:CGPointMake(0, 100)];
    [animPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(50, 50) controlPoint2:CGPointMake(200, 200)];
    // 在界面上先把路径画出来
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = animPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0;
    [viewFrame.layer addSublayer:pathLayer];
    // 动画图层
    animLayer = [[CALayer alloc] init];
    animLayer.frame = CGRectMake(0, 0, 50, 20);
    animLayer.position = CGPointMake(0, 100);
    animLayer.backgroundColor = [UIColor greenColor].CGColor;
    [viewFrame.layer addSublayer:animLayer];
    
    [self addButtonOnView:demo3 withText:@"开始动画" block:^(id btn) {
        // 关键帧动画创建路径移动画动 - CAKeyframeAnimation
        CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyAnim.path = animPath.CGPath;
        keyAnim.rotationMode = kCAAnimationRotateAuto;
        // 颜色变化动画 - CABasicAnimation
        CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        basicAnim.toValue = (__bridge id)[UIColor redColor].CGColor;
        
        // 动画组 CAAnimationGroup
        CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
        groupAnim.animations = @[keyAnim, basicAnim];
        groupAnim.duration = 4;
        
        // 开始动画
        [animLayer addAnimation:groupAnim forKey:nil];
    }];
    
//    // -------  demo4
//    FlexLinearLayout *demo4 = [self addDemoBoxWithTitle:@"示例4 - 自定义动画属性"];

    // -------  demo4
    FlexLinearLayout *demo4 = [self addDemoBoxWithTitle:@"示例4 - CATransition"];
    
    
    
    // -------  demoX
    FlexLinearLayout *demoX = [self addDemoBoxWithTitle:@"示例X - "];
    
    // make a gray circle image
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(10,10), NO, 1);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0,0,10,10));
    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
    CGContextFillPath(con);
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // make a cell with that image
    CAEmitterCell* cell = [CAEmitterCell emitterCell];
    cell.birthRate = 100;
    cell.lifetime = 1.5;
    cell.velocity = 100;
    cell.emissionRange = M_PI / 5.0;
    cell.contents = (id)im.CGImage;
    
    CAEmitterLayer *emitLayter = [CAEmitterLayer new];
    emitLayter.emitterPosition = CGPointMake(30, 100);
    emitLayter.emitterShape = kCAEmitterLayerPoint;
    emitLayter.emitterMode = kCAEmitterLayerPoints;
    emitLayter.emitterCells = @[cell];
    
    viewFrame = [UIView new];
    viewFrame.flex_alignSelf = FlexAlignSelf_stretch;
    viewFrame.backgroundColor = [UIColor yellowColor];
    viewFrame.flex_layoutHeight = 200;
    [demoX flex_addSubview:viewFrame];
    [viewFrame.layer addSublayer:emitLayter];

    
    
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












