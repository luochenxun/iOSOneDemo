//
// CALayerTransformDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "CALayerTransformDemo.h"

@interface CALayerTransformDemo()

@property (nonatomic, strong) CALayer *transormLayer;
@property (nonatomic, strong) CALayer *projectLayer;

@property (nonatomic, strong) UIView *cube;
@property (nonatomic, assign) NSInteger cubeRotateX;
@property (nonatomic, assign) NSInteger cubeRotateY;
@property (nonatomic, assign) NSInteger cubeRotateZ;

@property (nonatomic, strong) NSArray<UIView *> *face;

@end

@implementation CALayerTransformDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:CALayerTransformDemo.class];
}

+ (NSString *)displayName {
    return @"CALayer Transform";
}

+ (NSString *)name {
    return @"CALayerTransformDemo";
}

+ (NSString *)parentName {
    return @"CALayerDemo";
}

+ (NSString *)prioritySerial {
    return @"1.2.0";
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
    self.title = [CALayerTransformDemo displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    _cubeRotateX = 0;
    _cubeRotateY = 0;
    _cubeRotateZ = 0;
}

- (void)initUI {
    // ------- affineTransform
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@"仿射变换-affineTransform"];
    
    UIView *layerFrame = [UIView new];
    [layerFrame.layer addSublayer:self.compassLayer];
    layerFrame.flexSize = CGSizeMake(400, 400);
    
    [self addDescriptionOnView:demo1 withText:@"使用Transform画一个指南针："];
    [demo1 flex_addSubview:layerFrame];

    
    
    // -------  CATransform3D
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"3D变换-CATransform3D"];
    
    layerFrame = [UIView new];
    layerFrame.backgroundColor = [UIColor yellowColor];
    layerFrame.flexSize = CGSizeMake(300, 300);
    
    _transormLayer = [CALayer new];
    _transormLayer.frame = CGRectMake(0, 0, 200, 150);
    _transormLayer.position = CGPointMake(150, 120);
    _transormLayer.contents = (id)[UIImage imageNamed:@"rain"].CGImage;
    [layerFrame.layer addSublayer:_transormLayer];
    
    [demo2 flex_addSubview:layerFrame];
    
    [self addDescriptionOnView:demo2 withText:@"绕x轴旋转："];
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 1;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo2 flex_addSubview:slider];
    [self addDescriptionOnView:demo2 withText:@"绕y轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 2;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo2 flex_addSubview:slider];
    [self addDescriptionOnView:demo2 withText:@"绕z轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 3;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo2 flex_addSubview:slider];
    
    
    // 投影
    [self addDescriptionOnView:demo2 withText:@"透视投影"];
    layerFrame = [UIView new];
    layerFrame.backgroundColor = [UIColor greenColor];
    layerFrame.flexSize = CGSizeMake(300, 300);
    
    _projectLayer = [CALayer new];
    _projectLayer.frame = CGRectMake(0, 0, 200, 200);
    _projectLayer.backgroundColor = UIColor.blueColor.CGColor;
    _projectLayer.position = CGPointMake(150, 150);
    [layerFrame.layer addSublayer:_projectLayer];
    
    [demo2 flex_addSubview:layerFrame];
    
    [self addDescriptionOnView:demo2 withText:@"绕x轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 21;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo2 flex_addSubview:slider];
    [self addDescriptionOnView:demo2 withText:@"绕y轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 22;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo2 flex_addSubview:slider];
    [self addDescriptionOnView:demo2 withText:@"绕z轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 23;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo2 flex_addSubview:slider];
    
    
    // ------- demo3
    FlexLinearLayout *demo3 = [self addDemoBoxWithTitle:@"立方体"];
    
    layerFrame = [UIView new];
    layerFrame.backgroundColor = [UIColor greenColor];
    layerFrame.flexSize = CGSizeMake(300, 300);
    _cube = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [layerFrame addSubview:_cube];
    [demo3 flex_addSubview:layerFrame];
    
    // 设置所有子层共同灭点
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    layerFrame.layer.sublayerTransform = perspective;
    
    for (int i = 1; i <= 6; i++) {
        UIView *face = self.face[i-1];
        face.backgroundColor = XXXX_RANDOM_COLOR();
        face.frame = CGRectMake(0, 0, 100, 100);
        face.center = CGPointMake(150, 150);
        [_cube addSubview:face];
        XXXXLabel *faceLabel = [XXXXLabel labelWithType:XXXXLabelTypeDefault
                                                   text:[NSString stringWithFormat:@"%d", i]
                                                   font: [UIFont systemFontOfSize:30]
                                                  color:[UIColor blackColor]];
        faceLabel.frame = CGRectMake(0, 0, 50, 50);
        faceLabel.center = CGPointMake(50, 50);
        faceLabel.textAlignment = NSTextAlignmentCenter;
        faceLabel.verticalAlignment = XXXXLabelVerticalAlignmentMiddle;
        [face addSubview:faceLabel];
        
        CALayer *layer = face.layer;
        CATransform3D transform = CATransform3DIdentity;
        
        if (i == 1) {
            transform = CATransform3DMakeTranslation(0, 0, 50);
        }
        else if (i == 2) {
            transform = CATransform3DMakeTranslation(-50, 0, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
        }
        else if (i == 3) {
            transform = CATransform3DMakeTranslation(0, -50, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
        }
        else if (i == 4) {
            transform = CATransform3DMakeTranslation(50, 0, 0);
            transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
        }
        else if (i == 5) {
            transform = CATransform3DMakeTranslation(0, 50, 0);
            transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
        }
        else if (i == 6) {
            transform = CATransform3DMakeTranslation(0, 0, -50);
        }
        layer.transform = transform;
    }
    [self addDescriptionOnView:demo3 withText:@"绕x轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 31;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo3 flex_addSubview:slider];
    [self addDescriptionOnView:demo3 withText:@"绕y轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 32;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo3 flex_addSubview:slider];
    [self addDescriptionOnView:demo3 withText:@"绕z轴旋转："];
    slider = [[UISlider alloc] initWithFrame:CGRectZero];
    slider.flex_alignSelf = FlexAlignSelf_center;
    slider.flexSize = CGSizeMake(200, 20);
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.continuous = YES;
    slider.tag = 33;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [demo3 flex_addSubview:slider];
    
    [self.outerBox flex_updateLayout];
}

- (void)initAction {
    
}


#pragma mark - < Public Methods >


#pragma mark - < Main Logic >

- (CALayer *)compassLayer
{
    CALayer *outerLayer = [CALayer new];
    outerLayer.frame = CGRectMake(0, 0, 300, 300);
    
    // 表底盘(渐变 CAGradientLayer)
    CAGradientLayer *outletLayer = [CAGradientLayer new];
    outletLayer.contentsScale = [UIScreen mainScreen].scale;
    outletLayer.frame = outerLayer.bounds;
    outletLayer.colors = @[(id)[UIColor greenColor].CGColor, (id)[UIColor redColor].CGColor];
    outletLayer.locations = @[@0.0f, @1.0f];
    [outerLayer addSublayer:outletLayer];
    
    // 表面(CAShapeLayer)
    CAShapeLayer *surfaceLayer = [CAShapeLayer new];
    surfaceLayer.bounds = outerLayer.bounds;
    surfaceLayer.position = CGPointMake(CGRectGetMidX(outerLayer.bounds),CGRectGetMidY(outerLayer.bounds));
    surfaceLayer.contentsScale = [UIScreen mainScreen].scale;
    surfaceLayer.lineWidth = 3.0;
    surfaceLayer.fillColor = XXXX_COLOR_HEX(0xf5f5f5).CGColor;
    surfaceLayer.strokeColor = [UIColor blueColor].CGColor;
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p, nil, CGRectInset(outerLayer.bounds, 3, 3));
    surfaceLayer.path = p;
    [outerLayer addSublayer:surfaceLayer];
    
    // 四个方向的文字(CATextLayer)
    NSArray* pts = @[@"北", @"东", @"南", @"西"];
    for (int i = 0; i < 4; i++) {
        CATextLayer *textLayer = [CATextLayer new];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.string = pts[i];
        textLayer.bounds = CGRectMake(0,0,50,50);
        textLayer.position = CGPointMake(CGRectGetMidX(surfaceLayer.bounds), CGRectGetMidY(surfaceLayer.bounds));
        CGFloat vert = CGRectGetMidY(surfaceLayer.bounds) / CGRectGetHeight(textLayer.bounds);
        textLayer.anchorPoint = CGPointMake(0.5, vert);
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        textLayer.affineTransform = CGAffineTransformMakeRotation(i*M_PI/2.0);
        [surfaceLayer addSublayer:textLayer];
    }
    
    // the arrow
    CALayer *arrow = [CALayer new];
    arrow.contentsScale = [UIScreen mainScreen].scale;
    arrow.bounds = CGRectMake(0, 0, 10, 130);
    arrow.backgroundColor = [UIColor blackColor].CGColor;
    arrow.position = CGPointMake(CGRectGetMidX(outerLayer.bounds), CGRectGetMidY(outerLayer.bounds));
    arrow.anchorPoint = CGPointMake(0.5, 1);
    arrow.affineTransform = CGAffineTransformMakeRotation(M_PI/5.0);
    [outerLayer addSublayer:arrow];

    return outerLayer;
}

                              
#pragma mark - < Delegate Methods >

- (void)sliderValueChanged:(UISlider *)sender {
    UISlider *slider = (UISlider *)sender;
    if (sender.tag == 1) {
        _transormLayer.transform = CATransform3DMakeRotation(M_PI * 2 / 100.0 * slider.value, 1, 0, 0);
    }
    else if (sender.tag == 2) {
        _transormLayer.transform = CATransform3DMakeRotation(M_PI * 2 / 100.0 * slider.value, 0, 1, 0);
    }
    else if (sender.tag == 3) {
        _transormLayer.transform = CATransform3DMakeRotation(M_PI * 2 / 100.0 * slider.value, 0, 0, 1);
    }
    else if (sender.tag == 21) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500.0;
        transform = CATransform3DRotate(transform, M_PI * 2 / 100.0 * slider.value, 1, 0, 0);
        _projectLayer.transform = transform;
    }
    else if (sender.tag == 22) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500.0;
        transform = CATransform3DRotate(transform, M_PI * 2 / 100.0 * slider.value, 0, 1, 0);
        _projectLayer.transform = transform;
    }
    else if (sender.tag == 23) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500.0;
        transform = CATransform3DRotate(transform, M_PI * 2 / 100.0 * slider.value, 0, 0, 1);
        _projectLayer.transform = transform;
    }
    else if (sender.tag == 31) {
        _cubeRotateX = slider.value;
        [self rotateCube];
    }
    else if (sender.tag == 32) {
       _cubeRotateY = slider.value;
         [self rotateCube];
    }
    else if (sender.tag == 33) {
        _cubeRotateZ = slider.value;
         [self rotateCube];
    }
}

- (void)rotateCube
{
    CATransform3D x = CATransform3DRotate(CATransform3DIdentity, M_PI * 2 / 100.0 * _cubeRotateX, 1, 0, 0);
    CATransform3D y = CATransform3DRotate(CATransform3DIdentity, M_PI * 2 / 100.0 * _cubeRotateY, 0, 1, 0);
    CATransform3D z = CATransform3DRotate(CATransform3DIdentity, M_PI * 2 / 100.0 * _cubeRotateZ, 0, 0, 1);
    CATransform3D transform = CATransform3DConcat(x, y);
    transform = CATransform3DConcat(transform, z);
     _cube.layer.sublayerTransform = transform;
}

#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >

                              
- (NSArray<UIView *> *)face
{
    if (_face == nil) {
        _face = @[[UIView new],[UIView new],[UIView new],[UIView new],[UIView new],[UIView new]];
    }
    return _face;
}

@end












