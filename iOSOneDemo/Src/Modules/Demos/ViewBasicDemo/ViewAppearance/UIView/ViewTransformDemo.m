//
//  ViewTransformDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "ViewTransformDemo.h"

@interface ViewTransformDemo ()

@end

@implementation ViewTransformDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewTransformDemo.class];
}

+ (NSString *)displayName {
    return @"View Transform";
}

+ (NSString *)name {
    return @"ViewTransformDemo";
}

+ (NSString *)parentName {
    return @"UIViewDemo";
}

+ (NSString *)prioritySerial {
    return @"1.4";
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
    self.title = @"View Transform";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
//    frame & bounds & center
    FlexLinearLayout *normalTransformBox = [self addDemoBoxWithTitle:@"基本形变"];
    normalTransformBox.alignItems = FlexAlignSelf_center;
    
    UIView *stage1View = [UIView new];
    stage1View.flex_layoutHeight = 200;
    stage1View.flex_margin = @[@50,@30];
    stage1View.backgroundColor = [UIColor yellowColor];
    [self addLabelOnView:stage1View withText:@"stage1"];
    [normalTransformBox flex_addSubview:stage1View];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    view1.frame = CGRectMake(50, 50, 100, 100);
    [self addLabelOnView:view1 withText:@"view1"];
    [stage1View addSubview:view1];
    
    UIView *view1frameView = [UIView new];
    view1frameView.backgroundColor = [UIColor clearColor];
    view1frameView.layer.borderColor = [[UIColor redColor] CGColor];
    view1frameView.layer.borderWidth = 1.0;
    view1frameView.frame = view1.frame;
    [stage1View addSubview:view1frameView];
    
    UIView *blackpoint = [UIView new];
    blackpoint.backgroundColor = [UIColor redColor];
    blackpoint.frame = CGRectMake(0,0,4,4);
    blackpoint.layer.cornerRadius = 2.0;
    blackpoint.center = CGPointMake((100-4)/2, (100-4)/2);
    [view1 addSubview:blackpoint];
    
    NSMutableString *frameBoxDes = [NSMutableString stringWithFormat:@""];
    [frameBoxDes appendFormat:@"在黄色的stage1上，有一个矩形view1 \nframe: %@ \n", NSStringFromCGRect(view1.frame)];
    [frameBoxDes appendFormat:@"bounds : %@ \n", NSStringFromCGRect(view1.bounds)];
    [frameBoxDes appendFormat:@"center :%@ \n", NSStringFromCGPoint(view1.center)];
    XXXXLabel *view1InfoLabel = [self addDescriptionOnView:normalTransformBox withText:frameBoxDes];

    [self addButtonOnView:normalTransformBox withText:@"view1 转动45度" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            view1.transform = CGAffineTransformMakeRotation(45 * M_PI / 180.0);
        }else {
            view1.transform = CGAffineTransformMakeRotation(0);
        }
        
        view1frameView.frame = view1.frame;
        
        NSMutableString *frameBoxDes = [NSMutableString stringWithFormat:@""];
        [frameBoxDes appendFormat:@"在黄色的stage1上，有一个矩形view1 \nframe: %@ \n", NSStringFromCGRect(view1.frame)];
        [frameBoxDes appendFormat:@"bounds : %@ \n", NSStringFromCGRect(view1.bounds)];
        [frameBoxDes appendFormat:@"center :%@ \n", NSStringFromCGPoint(view1.center)];
        [view1InfoLabel setText:frameBoxDes];
        [FlexLayout updateRootLayout:view1InfoLabel];
    }];
    
    
    //
    FlexLinearLayout *multiTransformBox = [self addDemoBoxWithTitle:@"联合形变"];
    multiTransformBox.alignItems = FlexAlignSelf_center;
    
    UIView *stage2View = [UIView new];
    stage2View.flex_layoutHeight = 200;
    stage2View.flex_margin = @[@50,@30];
    stage2View.backgroundColor = [UIColor yellowColor];
    [self addLabelOnView:stage2View withText:@"stage1"];
    [multiTransformBox flex_addSubview:stage2View];
    
    UIView *view2Copy = [UIView new];
    view2Copy.backgroundColor = [UIColor greenColor];
    view2Copy.frame = CGRectMake(50, 50, 100, 100);
    [self addLabelOnView:view2Copy withText:@"view2 copy"];
    [stage2View addSubview:view2Copy];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    view2.frame = CGRectMake(50, 50, 100, 100);
    [self addLabelOnView:view2 withText:@"view2"];
    [stage2View addSubview:view2];
    
    [self addButtonOnView:multiTransformBox withText:@"view2 先右移再旋转" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            view2.transform = CGAffineTransformMakeTranslation(50, 0);
            view2.transform = CGAffineTransformRotate(view2.transform, 1 / 4.0 * M_PI);
        }else {
            view2.transform = CGAffineTransformIdentity;
        }
    }];
    
    [self addButtonOnView:multiTransformBox withText:@"view2 先旋转再右移" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            CGAffineTransform r = CGAffineTransformMakeRotation(1 / 4.0 * M_PI);
            CGAffineTransform t = CGAffineTransformMakeTranslation(50, 0);
            view2.transform = CGAffineTransformConcat(r, t);
        }else {
            view2.transform = CGAffineTransformIdentity;
        }
    }];
    
    [self addButtonOnView:multiTransformBox withText:@"view2 自定义变换" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            view2.transform = CGAffineTransformMake(1, 0, -0.2, 1, 0 , 0);
        }else {
            view2.transform = CGAffineTransformIdentity;
        }
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












