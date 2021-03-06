//
// DemoController.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "DemoController.h"
#import "DemoMDController.h"

@interface DemoController ()

@end

@implementation DemoController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self super_initEnvironment];
    [self super_initWindow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - < Init Methods >

- (void)super_initEnvironment {
}

- (void)super_initWindow {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"讲解" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBarItemClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.outerBox attachView:self.view];
    self.outerBox.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addObserver:self forKeyPath:@"outerBox.frame" options:0 context:NULL];
//    self.outerBox.autoresizesSubviews = YES;
}


#pragma mark - < Public Methods >

- (UIView *)addDividerOnView:(UIView *)view
{
    return [self addDividerOnView:view withMargin:nil];
}

- (UIView *)addDividerOnView:(UIView *)view withMargin:(NSArray<NSNumber *> *)margin
{
    UIView *line = [UIView new];
    line.flex_alignSelf = FlexAlignSelf_stretch;
    line.flex_layoutHeight = XXXX_SIZE_LINE;
    line.backgroundColor = kAppColor.divider;
    if (margin) {
        line.flex_margin = margin;
    } else {
        line.flex_margin = @[@15];
    }
    if ([view respondsToSelector:@selector(flex_addSubview:)]) {
        [view performSelector:@selector(flex_addSubview:) withObject:line];
    } else {
        NSAssert(NO, @"Only add description on layout");
    }
    return line;
}

- (XXXXButton *)addButtonOnView:(UIView *)view withText:(NSString *)text block:(XXXXButtonBlock)block {
    XXXXButton *button = [XXXXButton buttonWithType:XXXXButtonTypeDefault text:text onPress:block];
    button.flex_alignSelf = FlexAlignSelf_stretch;
    button.flex_margin = @[@15,@10];
    if ([view respondsToSelector:@selector(flex_addSubview:)]) {
        [view performSelector:@selector(flex_addSubview:) withObject:button];
    } else {
        NSAssert(NO, @"Only add description on layout");
    }
    return button;
}

- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text
{
    return [self addDescriptionOnView:view withText:text color:nil];
}

- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text color:(UIColor *)color
{
    return [self addDescriptionOnView:view withText:text color:nil margin:nil];
}

- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text margin:(NSArray<NSNumber *> *)margin
{
    return [self addDescriptionOnView:view withText:text color:nil margin:margin];
}

- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text color:(UIColor *)color margin:(NSArray<NSNumber *> *)margin
{
    XXXXLabel *label = [XXXXLabel labelWithType:XXXXLabelTypeDefault
                                           text:text font:kAppFont.h4 color:kAppColor.content];
    if (margin) {
        label.flex_margin = margin;
    } else {
        label.flex_margin = @[@15,@10];
    }
    label.numberOfLines = 0;
    label.flex_alignSelf = FlexAlignSelf_stretch;
    if (color) {
        label.textColor = color;
    }
    if ([view respondsToSelector:@selector(flex_addSubview:)]) {
        [view performSelector:@selector(flex_addSubview:) withObject:label];
    } else {
        NSAssert(NO, @"Only add description on layout");
    }
    
    return label;
}


- (XXXXLabel *)addLabelOnView:(UIView *)view withText:(NSString *)title {
    return [self addLabelOnView:view withText:title color:nil];
}

- (XXXXLabel *)addLabelOnView:(UIView *)view withText:(NSString *)title color:(UIColor *)color {
    XXXXLabel *label = [XXXXLabel labelWithType:XXXXLabelTypeDefault
                                           text:title font:kAppFont.h4 color:kAppColor.h1];
    label.textAlignment = NSTextAlignmentCenter;
    if (color) {
        label.textColor = color;
    }
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).mas_offset(10);
        make.width.equalTo(view);
        make.height.mas_equalTo(17);
    }];
    
    return label;
}


#pragma mark - < Main Logic >

- (void)onRightBarItemClicked:(id)sender {
    DemoMDController *mdController = [DemoMDController new];
    mdController.mdUrl = @"https://www.luochenxun.com/ios-0directory/";
//    mdController.demoName = [NSString stringWithFormat:@"%@.md",[self className]];
    if ([ControllerManageService sharedInstance].splitViewController.collapsed) {
        [self.navigationController pushViewController:mdController animated:YES];
    } else {
        [[ControllerManageService sharedInstance].primaryController.navigationController pushViewController:mdController animated:YES];
    }
}

- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title {
   return [self addDemoBoxWithTitle:title size:CGSizeZero];
}

- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title size:(CGSize)size {
    FlexLinearLayout *box = [FlexLayout LinearLayoutWithDirection:FlexDirection_column
                                                   justityContent:FlexJustityContent_flexStart
                                                       alignItems:FlexAlignItems_flexStart];
    box.flex_alignSelf = FlexAlignSelf_stretch;
    if (size.width != 0 || size.height != 0) {
        box.flexSize = size;
    }
    
    UIView *borderBox = [UIView new];
    borderBox.layer.borderColor = [kAppColor.dividerDark CGColor];
    borderBox.layer.borderWidth = XXXX_SIZE_LINE;
    borderBox.layer.cornerRadius = 6;
    [box addSubview:borderBox];
    [borderBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(box);
    }];
    
    XXXXLabel *titleLabel = [XXXXLabel labelWithType:XXXXLabelTypeDefault
                                                text:nil font:kAppFont.h5 color:kAppColor.h1];
    titleLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [box addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(titleLabel.flex_estimateWidthWithContent + 60, 20));
        make.top.equalTo(box).mas_offset(-10);
        make.centerX.equalTo(box);
    }];
    
    
    [box setFlexMargin:@[@15, @20]];
    [box setPadding:@[@15, @30]];
    
    [self.outerBox flex_addSubview:box];
    
    return box;
}

#pragma mark - < Observer Methods >

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"outerBox.frame"]) {
        if (self.outerBox.frame.size.height > 0 && self.outerBox.frame.size.width > 0) {
            [self.outerBox flex_updateLayout];
        }
    }
}

#pragma mark - < Delegate Methods >


#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >

- (FlexScrollLayout *)outerBox {
    if (_outerBox == nil) {
        _outerBox = [FlexLayout ScrollLayoutWithDirection:FlexDirection_column
                                           justityContent:FlexJustityContent_flexStart
                                               alignItems:FlexAlignItems_flexStart];
        _outerBox.paddingTop = 15;
    }
    return _outerBox;
}
@end










