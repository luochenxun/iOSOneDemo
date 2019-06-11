//
// KVCAndKVO.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "KVCAndKVO.h"

@interface KVCDemoDog : NSObject

@property (nonatomic, copy) NSString *name;

- (NSString *)printInfo;
@end

@implementation KVCDemoDog

- (NSString *)printInfo
{
    return [NSString stringWithFormat:@"The dog's name is %@. ", self.name];
}

@end

@interface KVCDemoStudent : NSObject

@property (nonatomic, strong) KVCDemoDog *dog;

@end

@interface KVCDemoStudent()

@property (nonatomic, copy) NSString *name;

@end

@implementation KVCDemoStudent

- (instancetype)init
{
    if (self = [super init]) {
        _name = @"default";
        _dog = [[KVCDemoDog alloc] init];
        _dog.name = @"default";
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"Catch undefined key.");
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (NSString *)printInfo
{
    return [NSString stringWithFormat:@"Hello, my name is %@. ", self.name];
}

@end

@interface KVCAndKVO ()

@end

@implementation KVCAndKVO


+ (void)load {
    [[DemoManager sharedManager] registerDemo:KVCAndKVO.class];
}

+ (NSString *)displayName {
    return @"KVC & KVO";
}

+ (NSString *)name {
    return @"KVCAndKVO";
}

+ (NSString *)parentName {
    return @"OCDemo";
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
    self.title = @"KVC & KVO";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    //  ----- demo1
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@"示例1"];

    KVCDemoStudent *student = [[KVCDemoStudent alloc] init];
    [self addDescriptionOnView:demo1 withText:[student printInfo]];
    [self addDescriptionOnView:demo1 withText:@"使用KVO修改student属性"];
    [student setValue:@"小明" forKey:@"name"];
    [self addDescriptionOnView:demo1 withText:[student printInfo]];
    [self addDescriptionOnView:demo1 withText:[student.dog printInfo]];
    [self addDescriptionOnView:demo1 withText:@"使用KVO修改student keypath, dog.name=xx"];
    [student setValue:@"旺财" forKeyPath:@"dog.name"];
    [self addDescriptionOnView:demo1 withText:[student.dog printInfo]];
    
    [self addDescriptionOnView:demo1 withText:@"原理编-修复key: _name"];
    [student setValue:@"小强" forKey:@"_name"];
    [self addDescriptionOnView:demo1 withText:[student printInfo]];
    
    // Catch住未定义的key，防止 crash
    [student setValue:@"test" forKey:@"test"];
    
    [self addDescriptionOnView:demo1 withText:@"--- 使用KVC将字典映射成对象 ---"];
    NSDictionary *dict = @{
                           @"name"  : @"小东",
//                           @"dog" : @{ @"name" : @"小黄" },
//                         @"dog.name" : @"小黄",  // 无法映射keypath
                           };
    KVCDemoStudent *student2 = [[KVCDemoStudent alloc] init];
    [student2 setValuesForKeysWithDictionary:dict];
    [self addDescriptionOnView:demo1 withText:[student2 printInfo]];
    [self addDescriptionOnView:demo1 withText:[student2.dog printInfo]];
    
    // ------ demo2
//    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"示例2"];
    
    KVCDemoStudent *student3 = [[KVCDemoStudent alloc] init];
    [student3 addObserver:self forKeyPath:@"name"
                  options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [student3 setValue:@"小明" forKey:@"name"];

    
    [self.outerBox flex_updateLayout];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >
#pragma mark - < Delegate Methods >

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context
{
    NSLog(@"newValue----%@",change[@"new"]);
    NSLog(@"oldValue----%@",change[@"old"]);
}


#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end












