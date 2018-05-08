//
//  UIImageDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "UIImageDemo.h"

@interface UIImageDemo ()

@end

@implementation UIImageDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:UIImageDemo.class];
}

+ (NSString *)displayName {
    return @"UIImage与UIImageView";
}

+ (NSString *)name {
    return @"UIImageDemo";
}

+ (NSString *)parentName {
    return @"DrawingDemo";
}

+ (NSString *)prioritySerial {
    return @"2.2.0";
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
    self.title = @"UIImage与UIImageView";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
//    ImageView
    FlexLinearLayout *contentModeBox = [self addDemoBoxWithTitle:@" ImageView - contentMode "];
    contentModeBox.alignItems = FlexAlignSelf_center;
    
    [self addDescriptionOnView:contentModeBox withText:@"下图黄色区域为 imageView 的View区域 "];
    [self addDescriptionOnView:contentModeBox withText:@"UIViewContentModeScaleToFill: "];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [contentModeBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:contentModeBox withText:@"UIViewContentModeScaleAspectFit: "];
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.clipsToBounds = YES;
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [contentModeBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:contentModeBox withText:@"UIViewContentModeScaleAspectFill: "];
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.clipsToBounds = YES;
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [contentModeBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:contentModeBox withText:@"UIViewContentModeRedraw: "];
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.clipsToBounds = YES;
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeRedraw;
    [contentModeBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:contentModeBox withText:@"UIViewContentModeCenter: "];
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.clipsToBounds = YES;
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeCenter;
    [contentModeBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:contentModeBox withText:@"如果不设 clipsToBounds的话，看看UIViewContentModeCenter会怎样: "];
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth"]];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeCenter;
    [contentModeBox flex_addSubview:imgView];
    
    //    Resizable image
    FlexLinearLayout *resizeableImgBox = [self addDemoBoxWithTitle:@" 拉伸方式 resizingMode "];
    resizeableImgBox.alignItems = FlexAlignSelf_center;
    
    [self addDescriptionOnView:resizeableImgBox withText:@"UIImageResizingModeTile: "];
    UIImage *img = [UIImage imageNamed:@"earth"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    imgView = [[UIImageView alloc] initWithImage:img];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [resizeableImgBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:resizeableImgBox withText:@"UIImageResizingModeStretch: "];
    img = [UIImage imageNamed:@"earth"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    imgView = [[UIImageView alloc] initWithImage:img];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [resizeableImgBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:resizeableImgBox withText:@"Title 只拉伸中间部分: "];
    img = [UIImage imageNamed:@"earth"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, img.size.width/2-1, img.size.height, img.size.width/2) resizingMode:UIImageResizingModeTile];
    imgView = [[UIImageView alloc] initWithImage:img];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [resizeableImgBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:resizeableImgBox withText:@"Stretch 只拉伸中间部分: "];
    img = [UIImage imageNamed:@"earth"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, img.size.width/4, img.size.height, img.size.width/4) resizingMode:UIImageResizingModeStretch];
    imgView = [[UIImageView alloc] initWithImage:img];
    imgView.backgroundColor = [UIColor yellowColor];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [resizeableImgBox flex_addSubview:imgView];
    
    //    image RenderMode
    FlexLinearLayout *renderModeBox = [self addDemoBoxWithTitle:@" Image渲染方式 renderMode "];
    renderModeBox.alignItems = FlexAlignSelf_center;
    
    [self addDescriptionOnView:renderModeBox withText:@"普通的图片(UIImageRenderingModeAutomatic): "];
    img = [UIImage imageNamed:@"rain"];
    imgView = [[UIImageView alloc] initWithImage:img];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [renderModeBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:renderModeBox withText:@"UIImageRenderingModeAlwaysTemplate（继承父View tintColor）: "];
    img = [UIImage imageNamed:@"rain"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgView = [[UIImageView alloc] initWithImage:img];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [renderModeBox flex_addSubview:imgView];
    
    [self addDescriptionOnView:renderModeBox withText:@"设置tintColor为黄色:"];
    img = [UIImage imageNamed:@"rain"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgView = [[UIImageView alloc] initWithImage:img];
    imgView.tintColor = [UIColor yellowColor];
    imgView.flex_alignSelf = FlexAlignSelf_stretch;
    imgView.flex_layoutHeight = 100;
    imgView.flex_margin = @[@50,@30];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [renderModeBox flex_addSubview:imgView];
    
    [self addButtonOnView:renderModeBox withText:@"将父容器的tintColor调为绿色" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            renderModeBox.tintColor = [UIColor greenColor];
        }else {
            renderModeBox.tintColor = [APP_DELEGATE.window tintColor];
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












