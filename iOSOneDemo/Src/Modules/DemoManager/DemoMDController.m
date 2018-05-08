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
    
    if (_demoName) {
        NSString *mdFile = [FCFileManager pathForMainBundleDirectoryWithPath:_demoName];
        if ([FCFileManager existsItemAtPath:mdFile]) {
            NSString *mdContent = [FCFileManager readFileAtPath:mdFile];
            NSError *error;
            _demoMDContent = [MMMarkdown HTMLStringWithMarkdown:mdContent error:&error];
            if (_demoMDContent.length > 0) {
                _demoMDContent = [@"<style>\
                                  pre {\
                                  font:14px/1.5 \"PingFang SC\", STXihei; \
                                  background-color:#e7e7e7; \
                                  width:2000em \
                                  }\
                                  </style>\n\n" stringByAppendingString:_demoMDContent];
            }
            if (error) {
                _readMDErrorMsg = [error localizedDescription];
            }
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
    } else if (_mdUrl.length > 0) {
        NSURL *url = [NSURL URLWithString:_mdUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    else {
        [_webView loadHTMLString:_readMDErrorMsg baseURL:nil];
    }
}


#pragma mark - < Public Methods >


#pragma mark - < Main Logic >


#pragma mark - < Delegate Methods >


#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >

@end
