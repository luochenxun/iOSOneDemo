//
// UIViewAnimationDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "UIViewAnimationDemo.h"



@interface UIViewAnimationDemoView : UIView

@property (nonatomic, assign) BOOL reverse;

@end

@implementation UIViewAnimationDemoView

- (void)drawRect:(CGRect)rect
{
    NSLog(@"UIViewAnimationDemoView\'s drawRect call");
    CGRect frame = CGRectInset(self.bounds, 10, 10);
    CGContextRef con = UIGraphicsGetCurrentContext();
    if (self.reverse) {
        CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
        CGContextFillEllipseInRect(con, frame);
    } else {
        CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
        CGContextFillRect(con, frame);
    }
}

@end


@interface UIViewAnimationDemo ()

@end

@implementation UIViewAnimationDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:UIViewAnimationDemo.class];
}

+ (NSString *)displayName {
    return @"UIView Animation";
}

+ (NSString *)name {
    return @"UIViewAnimationDemo";
}

+ (NSString *)parentName {
    return @"AnimationDemo";
}

+ (NSString *)prioritySerial {
    return @"1.3.0";
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
    self.title = [UIViewAnimationDemo displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {

}

- (void)initUI {
    // -------  demo1
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@" 示例1 - Block动画"];
    
    UIView *animView = [UIView new];
    animView.backgroundColor = [UIColor yellowColor];
    animView.flexSize = CGSizeMake(100, 100);
    [self addDescriptionOnView:demo1 withText:@"使用Block动画改变view背景色"];
    [demo1 flex_addSubview:animView];
    [self addButtonOnView:demo1 withText:@"复位" block:^(UIView *btn) {
        [animView.layer removeAllAnimations]; // 停止所有动画
        animView.backgroundColor = [UIColor yellowColor];
        CGPoint p = animView.center;
        p.x = 60;
        animView.center = p;
    }];
    [self addButtonOnView:demo1 withText:@"开始动画" block:^(UIView *btn) {
        [UIView animateWithDuration:1 animations:^{
            animView.backgroundColor = [UIColor redColor];
            CGPoint p = animView.center;
            p.x += 100;
            animView.center = p;
        } completion:^(BOOL finished) { // finish表示动画是否真正完成了，因为有可能调回高时，动画被安排到下一个runloop执行
            NSLog(@"completion finished? ==> %@",@(finished));
            animView.backgroundColor = [UIColor blueColor];
        }];
    }];
    [self addButtonOnView:demo1 withText:@"开始动画 performWithoutAnimation" block:^(UIView *btn) {
        [UIView animateWithDuration:1 animations:^{
            animView.backgroundColor = [UIColor redColor];
            [UIView performWithoutAnimation:^{
                CGPoint p = animView.center;
                p.x = 200;
                animView.center = p;
            }];
        }];
    }];
    // 思考下动画实现的原理
    [self addButtonOnView:demo1 withText:@"在block中先移100再移300" block:^(UIView *btn) {
 
    }];
    [self addButtonOnView:demo1 withText:@"block动画前view.x=350,block中改为100)" block:^(UIView *btn) {
        CGPoint p = animView.center;
        p.x = 350;
        animView.center = p;
        [UIView animateWithDuration:1 animations:^{
            animView.backgroundColor = [UIColor redColor];
            CGPoint p = animView.center;
            p.x = 100;
            animView.center = p;
        }];
    }];
    [self addButtonOnView:demo1 withText:@"block动画中view.x=100,block后改为350)" block:^(UIView *btn) {
        [UIView animateWithDuration:1 animations:^{
            animView.backgroundColor = [UIColor redColor];
            CGPoint p = animView.center;
            p.x = 100;
            animView.center = p;
        }];
        CGPoint p = animView.center;
        p.x = 350;
        animView.center = p;
    }];

    
    // -------  demo2
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@" 示例2 - 动画options"];
    
    UIView *animView2 = [UIView new];
    animView2.backgroundColor = [UIColor yellowColor];
    animView2.flexSize = CGSizeMake(100, 100);
    [self addDescriptionOnView:demo2 withText:@"动画options"];
    [demo2 flex_addSubview:animView2];
    
    [self addButtonOnView:demo2 withText:@"复位" block:^(UIView *btn) {
        [animView2.layer removeAllAnimations]; // 停止所有动画
        animView2.backgroundColor = [UIColor yellowColor];
        CGPoint p = animView2.center;
        p.x = 60;
        animView2.center = p;
    }];
    
    [self addButtonOnView:demo2 withText:@"动画option - UIViewAnimationOptionAutoreverse1" block:^(UIView *btn) {
        NSUInteger op = UIViewAnimationOptionAutoreverse;
        [UIView animateWithDuration:1 delay:0 options:op animations:^{
            animView2.backgroundColor = [UIColor redColor];
            CGPoint p = animView2.center;
            p.x += 200;
            animView2.center = p;
        } completion:nil];
    }];
    
    [self addButtonOnView:demo2 withText:@"动画option - UIViewAnimationOptionAutoreverse2" block:^(UIView *btn) {
        NSUInteger op = UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat;
        CGPoint originPoint = animView2.center;
        [UIView animateWithDuration:1 delay:0 options:op animations:^{
            animView2.backgroundColor = [UIColor redColor];
            CGPoint p = animView2.center;
            p.x += 200;
            animView2.center = p;
        } completion:^(BOOL finished) {  // 使用Autoreverse的话要在completion里复原
            animView2.backgroundColor = [UIColor yellowColor];
            animView2.center = originPoint;
        }];
    }];
    
    [self addButtonOnView:demo2 withText:@"动画option - UIViewAnimationOptionRepeat" block:^(UIView *btn) {
        NSUInteger op = UIViewAnimationOptionRepeat;
        [UIView animateWithDuration:1 delay:0 options:op animations:^{
            animView2.backgroundColor = [UIColor redColor];
            CGPoint p = animView2.center;
            p.x += 200;
            animView2.center = p;
        } completion:nil];
    }];
    
    [self addButtonOnView:demo2 withText:@"动画option - UIViewAnimationOptionOverrideInheritedDuration" block:^(UIView *btn) {
        [UIView animateWithDuration:2 animations:^{
            CGPoint p = animView2.center;
            p.x += 100;
            animView2.center = p;
            NSUInteger op = UIViewAnimationOptionOverrideInheritedDuration;
            [UIView animateWithDuration:0.5 delay:0 options:op animations:^{
                animView2.backgroundColor = [UIColor blueColor];
            } completion:nil];
        }];
    }];
    
    // -------  demo3
    FlexLinearLayout *demo3 = [self addDemoBoxWithTitle:@" 示例3 - spring动画"];
    
    UIView *animView3 = [UIView new];
    animView3.backgroundColor = [UIColor yellowColor];
    animView3.flexSize = CGSizeMake(100, 100);
    [self addDescriptionOnView:demo3 withText:@"spring 动画"];
    [demo3 flex_addSubview:animView3];
    
    [self addButtonOnView:demo3 withText:@"复位" block:^(UIView *btn) {
        [animView3.layer removeAllAnimations]; // 停止所有动画
        animView3.backgroundColor = [UIColor yellowColor];
        CGPoint p = animView3.center;
        p.x = 60;
        animView3.center = p;
    }];
    
    [self addButtonOnView:demo3 withText:@"Spring抖动目标" block:^(UIView *btn) {
        [UIView animateWithDuration:2 delay:0
             usingSpringWithDamping:1 initialSpringVelocity:0
                            options:0
                         animations:^{
                             animView3.backgroundColor = [UIColor redColor];
                             CGPoint p = animView3.center;
                             p.x += 200;
                             animView3.center = p;
                         } completion:nil];
    }];
    
    [self addButtonOnView:demo3 withText:@"SpringVelocity" block:^(UIView *btn) {
        [UIView animateWithDuration:2 delay:0
             usingSpringWithDamping:0.3 initialSpringVelocity:20
                            options:0
                         animations:^{
                             animView3.backgroundColor = [UIColor redColor];
                             CGPoint p = animView3.center;
                             p.x += 200;
                             animView3.center = p;
                         } completion:nil];
    }];
    
    
    // -------  demo4
    FlexLinearLayout *demo4 = [self addDemoBoxWithTitle:@" 示例4 - keyframe动画"];
    
    UIView *animView4 = [UIView new];
    animView4.backgroundColor = [UIColor yellowColor];
    animView4.flexSize = CGSizeMake(100, 100);
    [demo4 flex_addSubview:animView4];
    
    [self addButtonOnView:demo4 withText:@"复位" block:^(UIView *btn) {
        [animView4.layer removeAllAnimations]; // 停止所有动画
        animView4.backgroundColor = [UIColor yellowColor];
        CGPoint p = animView4.center;
        p.x = 60;
        animView4.center = p;
    }];
    
    [self addButtonOnView:demo4 withText:@"开始动画" block:^(id btn) {
        __block CGPoint currentPoint = animView4.center;
        // 整个动画的持续时间，由最外层的duration决定
        [UIView animateKeyframesWithDuration:4 delay:0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
                currentPoint.x += 100;
                animView4.center = currentPoint;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
                currentPoint.x -= 50;
                animView4.center = currentPoint;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                currentPoint.x += 200;
                animView4.center = currentPoint;
            }];
        } completion:nil];
    }];
    
    // -------  demo5
    FlexLinearLayout *demo5 = [self addDemoBoxWithTitle:@" 示例5 - transitions动画"];
    
    UIImageView *animView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    animView5.flexSize = CGSizeMake(100, 100);
    [demo5 flex_addSubview:animView5];
    
    [self addButtonOnView:demo5 withText:@"复位" block:^(UIView *btn) {
        [animView5.layer removeAllAnimations]; // 停止所有动画
        animView5.image = [UIImage imageNamed:@"earth"];
    }];
    
    [self addButtonOnView:demo5 withText:@"翻转动画" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            [UIView transitionWithView:animView5 duration:1
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                animView5.image = [UIImage imageNamed:@"rain"];
                            } completion:nil];
        }
        else {
            [UIView transitionWithView:animView5 duration:1
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:^{
                                animView5.image = [UIImage imageNamed:@"earth"];
                            } completion:nil];
        }
    }];
    
    
    UIViewAnimationDemoView *animView6 = [UIViewAnimationDemoView new];
    animView6.flexSize = CGSizeMake(100, 100);
//    animView6.layer.opaque = NO;
    [demo5 flex_addSubview:animView6];

    [self addButtonOnView:demo5 withText:@"翻转动画" block:^(UIView *btn) {
        animView6.reverse = !animView6.reverse;
        [UIView transitionWithView:animView6 duration:1
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionAllowAnimatedContent
                        animations:^{
                            [animView6 setNeedsDisplay];
                        } completion:nil];
    }];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    baseView.flexSize = CGSizeMake(100, 100);
    [self addDescriptionOnView:demo5 withText:@"transitionWithView:红 toView:黄"];
    [demo5 flex_addSubview:baseView];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [baseView addSubview:innerView];
    innerView.backgroundColor = [UIColor redColor];
    UIView *outerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    outerView.backgroundColor = [UIColor yellowColor];
    [self addButtonOnView:demo5 withText:@"红->黄" block:^(UIView *btn) {
        [UIView transitionFromView:innerView
                            toView:outerView
                          duration:2
                           options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
                           }];
    }];
    [self addButtonOnView:demo5 withText:@"黄->红" block:^(UIView *btn) {
        [UIView transitionFromView:outerView
                            toView:innerView
                          duration:1
                           options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
                           }];
    }];
    
    
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












