//
//  Demo.m
//  XXXX
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

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
}


#pragma mark - < Public Methods >


#pragma mark - < Main Logic >

- (void)onRightBarItemClicked:(id)sender {
    DemoMDController *mdController = [DemoMDController new];
    mdController.demoName = [NSString stringWithFormat:@"%@.md",[self className]];
    [self.navigationController pushViewController:mdController animated:YES];
}

- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title {
   return [self addDemoBoxWithTitle:title size:CGSizeZero];
}

- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title size:(CGSize)size {
    FlexLinearLayout *box = [FlexLayout LinearLayoutWithDirection:FlexDirection_column
                                                   justityContent:FlexJustityContent_flexStart
                                                       alignItems:FlexAlignItems_flexStart];
    if (size.width == 0 || size.height == 0) {
        box.flexSize = CGSizeMake(kAppDimension.screenWidth - 30, 50);
    } else {
        box.flexSize = size;
    }
    
    box.layer.borderColor = [kAppColor.dividerDark CGColor];
    box.layer.borderWidth = XXXX_SIZE_LINE;
    box.layer.cornerRadius = 3;
    
    XXXXLabel *titleLabel = [XXXXLabel labelWithType:XXXXLabelTypeDefault
                                      text:nil font:kAppFont.h5 color:kAppColor.h1];
    titleLabel.opaque = YES;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [box addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.top.equalTo(box).mas_offset(-10);
        make.centerX.equalTo(box);
    }];
    titleLabel.text = title;
    
    [box setFlexMargin:@[@15, @20]];
    [box setPadding:@[@15, @30]];
    
    [self.outerBox flex_addSubview:box];
    
    return box;
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










