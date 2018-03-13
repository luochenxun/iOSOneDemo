//
//  GraphicsContextDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "GraphicsContextDemo.h"


@interface GCDemoCustomView : UIView

@end

@implementation GCDemoCustomView

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor redColor] setFill];  // 相当于设置了画笔的颜色。
    [p fill];
}

// 两个 draw 方法只取其一
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//    UIGraphicsPushContext(ctx);
//    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    [[UIColor yellowColor] setFill];
//    [p fill];
//    UIGraphicsPopContext();
//}

@end

@interface GCDemoCustomView2 : UIView

@end

@implementation GCDemoCustomView2

- (void)drawRect:(CGRect)rect
{
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0, 0, 100, 100));
    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
    CGContextFillPath(con);
}

@end

@interface GraphicsContextDemo ()

@end

@implementation GraphicsContextDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:GraphicsContextDemo.class];
}

+ (NSString *)displayName {
    return @"绘图画布 GraphicsContext";
}

+ (NSString *)name {
    return @"GraphicsContextDemo";
}

+ (NSString *)parentName {
    return @"DrawingDemo";
}

+ (NSString *)prioritySerial {
    return @"2.3.0";
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
    self.title = @"绘图画布 GraphicsContext";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    //-------    Get GraphicsContext
    FlexLinearLayout *graphicsBox = [self addDemoBoxWithTitle:@" Graphics Context "];
    graphicsBox.alignItems = FlexAlignItems_center;
    
    [self addDescriptionOnView:graphicsBox withText:@"使用UIKit获得GraphicsContext："];
    GCDemoCustomView *cv = [[GCDemoCustomView alloc] init];
    [cv setFlexSize:CGSizeMake(100, 100)];
    [graphicsBox flex_addSubview:cv];
    
    [self addDescriptionOnView:graphicsBox withText:@"使用CoreGraphics获得GraphicsContext："];
    GCDemoCustomView2 *cv2 = [[GCDemoCustomView2 alloc] init];
    [cv2 setFlexSize:CGSizeMake(100, 100)];
    cv2.flex_marginTop = 10;
    [graphicsBox flex_addSubview:cv2];
    
    //-------    image context
    FlexLinearLayout *imgContextBox = [self addDemoBoxWithTitle:@" image context "];
    imgContextBox.alignItems = FlexAlignItems_center;
    
    // create image context and generate img
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor yellowColor] setFill];
    [p fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:CGSizeMake(100, 100)];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"可以看出输出到image上如果没有画的部分是透明的。 上面画上View上也一样，之所以是黑色是因为View如果没有绘东西是黑色的底。而这里使用imageView装载此image，默认是白色的底。"];
    
    [self addDividerOnView:imgContextBox];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeMultiply:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeMultiply alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeScreen:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeScreen alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeOverlay:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeOverlay alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeDarken:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeDarken alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeLighten:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeLighten alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeColorDodge:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeColorDodge alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeColorBurn:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeColorBurn alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeSoftLight:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeSoftLight alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeHardLight:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeHardLight alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeDifference:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeDifference alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeExclusion:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeExclusion alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeHue:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeHue alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeSaturation:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeSaturation alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeColor:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeColor alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    [self addDescriptionOnView:imgContextBox withText:@"BlendMode-kCGBlendModeLuminosity:"];
    // create image context and generate img
    image = [UIImage imageNamed:@"earth"];
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
    [image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
    [image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
            blendMode:kCGBlendModeLuminosity alpha:1.0];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // show the image use a imageview
    iv = [[UIImageView alloc] initWithImage:image];
    [iv setFlexSize:image.size];
    [imgContextBox flex_addSubview:iv];
    
    
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












