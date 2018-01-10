//
//  ViewHierarchyDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "ViewHierarchyDemo.h"

@interface ViewHierarchyDemo ()

@end

@implementation ViewHierarchyDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewHierarchyDemo.class];
}

+ (NSString *)displayName {
    return @"View 层次";
}

+ (NSString *)name {
    return @"ViewHierarchyDemo";
}

+ (NSString *)parentName {
    return @"UIViewDemo";
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
    self.title = @"View 层次";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >
#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end
