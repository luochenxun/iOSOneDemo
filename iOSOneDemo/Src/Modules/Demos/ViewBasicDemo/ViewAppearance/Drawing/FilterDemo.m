//
// FilterDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "FilterDemo.h"

@interface FilterDemoFilter : CIFilter

@property (nonatomic, strong) CIImage *inputImage;

@end

@implementation FilterDemoFilter

- (CIImage *)outputImage
{
    CGRect inextent = self.inputImage.extent;
    CIFilter *grad = [CIFilter filterWithName:@"CIRadialGradient"];
    CIVector *center = [CIVector vectorWithX:inextent.size.width/2.0 Y:inextent.size.height/2.0];
    [grad setValue:center forKey:@"inputCenter"];
    [grad setValue:@85 forKey:@"inputRadius0"];
    [grad setValue:@100 forKey:@"inputRadius1"];
    CIImage *gradimage = [grad valueForKey: @"outputImage"];
    
    CIFilter *blend = [CIFilter filterWithName:@"CIBlendWithMask"];
    [blend setValue:self.inputImage forKey:@"inputImage"];
    [blend setValue:gradimage forKey:@"inputMaskImage"];
    
    return blend.outputImage;
}

@end


@interface FilterDemo ()

@end

@implementation FilterDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:FilterDemo.class];
}

+ (NSString *)displayName {
    return @"滤镜 - CIFilter & CIImage";
}

+ (NSString *)name {
    return @"FilterDemo";
}

+ (NSString *)parentName {
    return @"DrawingDemo";
}

+ (NSString *)prioritySerial {
    return @"2.5.0";
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
    self.title = @"滤镜 - CIFilter & CIImage";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    //-------    CGImage
    FlexLinearLayout *cgImgBox = [self addDemoBoxWithTitle:@" 示例1 "];
    cgImgBox.alignItems = FlexAlignItems_center;
    
    UIImage *sourceImg = [UIImage imageNamed:@"earth"];
    CIImage *ciImg = [[CIImage alloc] initWithCGImage:sourceImg.CGImage];
    CGRect imgExtent = ciImg.extent;
    
    // filter1
    CIFilter *filter1 = [CIFilter filterWithName:@"CIRadialGradient"];
    CIVector *center = [CIVector vectorWithX:imgExtent.size.width/2 Y:imgExtent.size.height/2];
    [filter1 setValue:center forKey:@"inputCenter"];
    [filter1 setValue:@50 forKey:@"inputRadius0"];
    [filter1 setValue:@100 forKey:@"inputRadius1"];
    CIImage *filter1Output = [filter1 valueForKey: @"outputImage"];
    
    // filter2
    CIFilter *filter2 = [CIFilter filterWithName:@"CIBlendWithMask"];
    [filter2 setValue:ciImg forKey:kCIInputImageKey];
    [filter2 setValue:filter1Output forKey:@"inputMaskImage"];
    
    // 输出 bitmap
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef outputCGImg = [ciContext createCGImage:filter2.outputImage fromRect:imgExtent];
    UIImage *outputImg = [UIImage imageWithCGImage:outputCGImg];
    CGImageRelease(outputCGImg);
    // 也可以这样输出
//    UIGraphicsBeginImageContextWithOptions(moiextent.size, NO, 0);
//    [[UIImage imageWithCIImage:filter2] drawInRect:imgExtent];
//    UIImage* outputImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    // 显示Img
    UIImageView *iv = [[UIImageView alloc] initWithImage:outputImg];
    [iv setFlexSize:outputImg.size];
    [cgImgBox flex_addSubview:iv];
    
    //-------    自定义滤镜
    FlexLinearLayout *customBox = [self addDemoBoxWithTitle:@" 自定义滤镜 "];
    customBox.alignItems = FlexAlignItems_center;
    
    sourceImg = [UIImage imageNamed:@"earth"];
    ciImg = [[CIImage alloc] initWithCGImage:sourceImg.CGImage];
    
    // filter1
    FilterDemoFilter *customFilter = [FilterDemoFilter new];
    [customFilter setValue:ciImg forKey:kCIInputImageKey];
    
    // 输出 bitmap
    // 复用示例1中的 context
    outputCGImg = [ciContext createCGImage:customFilter.outputImage fromRect:imgExtent];
    outputImg = [UIImage imageWithCGImage:outputCGImg];
    CGImageRelease(outputCGImg);
    
    // 显示Img
    iv = [[UIImageView alloc] initWithImage:outputImg];
    [iv setFlexSize:outputImg.size];
    [customBox flex_addSubview:iv];
    
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












