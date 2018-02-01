//
//  DemoMDController.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/8.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "DemoMDController.h"
#import <MMMarkdown/MMMarkdown.h>

@interface DemoMDController ()

#pragma mark - < Private properties >

@property (nonatomic, strong) NSString *demoMDContent;
@property (nonatomic, copy) NSString *readMDErrorMsg;

#pragma mark - < UI Controls >

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation DemoMDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEnvironment];
    [self initWindow];
    [self initUI];
    [self initAction];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - < Init Methods >

- (void)initWindow {
    if (_demoDesName) {
        self.title = _demoDesName;
    } else {
        self.title = [_demoName stringByDeletingPathExtension];
    }
}

- (void)initEnvironment {
    _readMDErrorMsg = @"File Not Found";
    if (_demoName && ![_demoName.pathExtension isEqualToString:@"md"]) {
        _demoName = [_demoName stringByAppendingString:@".md"];
    }
    NSString *mdFile = [FCFileManager pathForMainBundleDirectoryWithPath:_demoName];
    if ([FCFileManager existsItemAtPath:mdFile]) {
        NSString *mdContent = [FCFileManager readFileAtPath:mdFile];
        mdContent = [@"<style>\
                     pre{\
                         font-size:8px;\
                         background-color:#e7e7e7;\
                     width:2000\
                     }\
                     </style>\n\n" stringByAppendingString:mdContent];
        NSError *error;
        _demoMDContent = [MMMarkdown HTMLStringWithMarkdown:mdContent error:&error];
        if (error) {
            _readMDErrorMsg = [error localizedDescription];
        }
    }
}

- (void)initUI {
    _webView = [[UIWebView alloc] init];
    _webView.frame = self.view.bounds;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_webView];
}

- (void)initAction {
    
}

- (void)loadData {
    if (_demoMDContent.length > 0) {
        [_webView loadHTMLString:_demoMDContent
                         baseURL:[NSURL fileURLWithPath:[FCFileManager pathForMainBundleDirectoryWithPath:_demoName]]];
    } else {
        [_webView loadHTMLString:_readMDErrorMsg baseURL:nil];
    }
}


#pragma mark - < Public Methods >


#pragma mark - < Main Logic >


#pragma mark - < Delegate Methods >


#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >

@end
