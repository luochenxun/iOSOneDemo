//
//  DrawingImageDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "DrawingImageDemo.h"


@interface DrawingImageDemo ()

@end

@implementation DrawingImageDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:DrawingImageDemo.class];
}

+ (NSString *)displayName {
    return @"绘制Image、CGImage";
}

+ (NSString *)name {
    return @"DrawingImageDemo";
}

+ (NSString *)parentName {
    return @"DrawingDemo";
}

+ (NSString *)prioritySerial {
    return @"2.4.0";
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
    self.title = @"绘制Image、CGImage";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    //-------    Image 总述
    FlexLinearLayout *imageBox = [self addDemoBoxWithTitle:@" Image总述 "];
    imageBox.alignItems = FlexAlignItems_center;
    
    UIImage *tempImage = [UIImage imageNamed:@"rain"];
    CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(tempImage.CGImage));
    NSData *imageNSData = (__bridge_transfer NSData*)imageData;
    NSString *imageStr = [NSDataHelper convertDataToHexStr:imageNSData];
    NSMutableString *fetchImageStr = [NSMutableString stringWithCapacity:10];
//    for (NSUInteger i = 0,j = 0; i < imageStr.length; i++) {
//        if (<#condition#>) {
//            <#statements#>
//        }
//    }
//    imagens
    XXXXLabel *imageDataLabel = [self addDescriptionOnView:imageBox withText:[NSString stringWithFormat:@"%@",imageData]];
    imageDataLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    imageDataLabel.flex_layoutHeigh = 100;
    
    
    //-------    CGImage
    FlexLinearLayout *cgImgBox = [self addDemoBoxWithTitle:@" CGImage "];
    cgImgBox.alignItems = FlexAlignItems_center;
    
    [self addDescriptionOnView:cgImgBox withText:@"原图："];
    // show the image use a imageview
    UIImage *img = [UIImage imageNamed:@"earth"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    iv.backgroundColor = [UIColor yellowColor];
    [iv setFlexSize:img.size];
    [cgImgBox flex_addSubview:iv];
    
    [self addDescriptionOnView:cgImgBox withText:@"直接绘制CGImage的图像翻转问题："];
    img = [UIImage imageNamed:@"earth"];
    CGSize size = img.size;
    CGImageRef cgImg = [img CGImage];
    UIGraphicsBeginImageContext(size);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), cgImg);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:img];
    iv.backgroundColor = [UIColor yellowColor];
    [iv setFlexSize:size];
    [cgImgBox flex_addSubview:iv];
    
    [self addDescriptionOnView:cgImgBox withText:@"解决图像翻转问题-方法1："];
    img = [UIImage imageNamed:@"earth"];
    size = img.size;
    cgImg = [img CGImage];
    UIGraphicsBeginImageContext(size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height), flip(cgImg));
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:img];
    iv.backgroundColor = [UIColor yellowColor];
    [iv setFlexSize:size];
    [cgImgBox flex_addSubview:iv];
    
    [self addDescriptionOnView:cgImgBox withText:@"解决图像翻转问题-方法2："];
    img = [UIImage imageNamed:@"earth"];
    cgImg = [img CGImage];
    UIGraphicsBeginImageContext(size);
    img = [UIImage imageWithCGImage:cgImg scale:img.scale orientation:UIImageOrientationUp];
    [img drawAtPoint:CGPointMake(0, 0)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:img];
    iv.backgroundColor = [UIColor yellowColor];
    [iv setFlexSize:size];
    [cgImgBox flex_addSubview:iv];
    
    [self addDescriptionOnView:cgImgBox withText:@"解决图像翻转问题-方法3："];
    img = [UIImage imageNamed:@"earth"];
    size = img.size;
    cgImg = [img CGImage];
    UIGraphicsBeginImageContext(size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height), cgImg);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:img];
    iv.backgroundColor = [UIColor yellowColor];
    iv.transform = CGAffineTransformMakeScale(1.0,-1.0);
    [iv setFlexSize:size];
    [cgImgBox flex_addSubview:iv];
    
    // create image context and generate img
    [self addDescriptionOnView:cgImgBox withText:@"图片截取："];
    img = [UIImage imageNamed:@"earth"];
    size = img.size;
    CGFloat scale = img.scale;
    CGImageRef testCgImg = [img CGImage];
    CGSize testCgSize = CGSizeMake(CGImageGetWidth(testCgImg), CGImageGetHeight(testCgImg));
    NSLog(@"UIImage's size in 2x: %@", NSStringFromCGSize(size)); // {150, 150}
    NSLog(@"CGImage's size in 2x: %@", NSStringFromCGSize(testCgSize)); // {300, 300}
    CGImageRef leftImg = CGImageCreateWithImageInRect([img CGImage], CGRectMake(0, 0, size.width * scale /2, size.height * scale));
    CGImageRef rightImg = CGImageCreateWithImageInRect([img CGImage], CGRectMake(size.width * scale /2, 0, size.width  * scale /2, size.height * scale));
    UIGraphicsBeginImageContext(CGSizeMake(size.width * 1.5, size.height));
    con = UIGraphicsGetCurrentContext();
    // 截取时要使用scale,输出时不需要
    CGContextDrawImage(con, CGRectMake(0, 0, size.width/2, size.height), flip(leftImg));
    CGContextDrawImage(con, CGRectMake(size.width, 0, size.width/2, size.height), flip(rightImg));
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(leftImg);
    CGImageRelease(rightImg);
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:img];
    iv.backgroundColor = [UIColor yellowColor];
    [iv setFlexSize:img.size];
    [cgImgBox flex_addSubview:iv];
    
    //-------    Snapshot
    FlexLinearLayout *snapshotBox = [self addDemoBoxWithTitle:@" snapshot "];
    snapshotBox.alignItems = FlexAlignItems_center;
    
    [self addDescriptionOnView:snapshotBox withText:@"CALayer的 renderInContext:context 显示截图 ："];
    // show the image use a imageview
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.flex_alignSelf = FlexAlignSelf_stretch;
    imageView.flex_layoutHeigh = 200;
    [snapshotBox flex_addSubview:imageView];
    [self addButtonOnView:snapshotBox withText:@"截个图" block:^(id btn) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect rect = [keyWindow bounds];
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [keyWindow.layer renderInContext:context];
        UIImage *screenImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        imageView.image = screenImg;
    }];
    
    [self addDescriptionOnView:snapshotBox withText:@"UIView的drawViewHierarchyInRect: 显示截图："];
    // show the image use a imageview
    imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.flex_alignSelf = FlexAlignSelf_stretch;
    imageView.flex_layoutHeigh = 200;
    [snapshotBox flex_addSubview:imageView];
    weakify(self);
    [self addButtonOnView:snapshotBox withText:@"截个图" block:^(id btn) {
        strongify(self);
        UIGraphicsBeginImageContext(self.outerBox.frame.size);
        [self.outerBox drawViewHierarchyInRect:self.outerBox.frame afterScreenUpdates:NO];
        UIImage *screenImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        imageView.image = screenImg;
    }];
    
    [self addDescriptionOnView:snapshotBox withText:@"snapshotViewAfterScreenUpdates: 显示截图："];
    // show the image use a imageview
    UIView *snapViewFrame = [[UIView alloc] init];
    snapViewFrame.flex_alignSelf = FlexAlignSelf_stretch;
    snapViewFrame.flex_layoutHeigh = 200;
    [snapshotBox flex_addSubview:snapViewFrame];
    [self addButtonOnView:snapshotBox withText:@"截个图" block:^(id btn) {
        strongify(self);
        CLEAR_VIEWS(snapViewFrame);
        UIView *snapView = [self.outerBox snapshotViewAfterScreenUpdates:NO];
        snapView.frame = snapViewFrame.bounds;
        snapView.contentMode = UIViewContentModeScaleAspectFit;
        [snapViewFrame addSubview:snapView];
    }];
    
    [self.outerBox flex_updateLayout];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >

CGImageRef flip(CGImageRef im)
{
    CGSize size = CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    UIGraphicsBeginImageContext(size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height), im);
    CGImageRef resultImageRef = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    return resultImageRef;
}

#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end












