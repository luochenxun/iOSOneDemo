//
//  ProgramDesignHeader.h
//
//  Created by luochenxun on 15/5/23.
//  Copyright (c) 2015年 kacha-mobile. All rights reserved.
//
//  为编程方便提供的宏

#ifndef app_ProgramDesignHeader_h
#define app_ProgramDesignHeader_h

// -----------------------  SingleTon ---------------------------------
// 单实例宏
#pragma mark - SingleTon
#define FUNC_INTERCAFE_SINGLETON(className) + (className *)sharedInstance;              \
                                            - (instancetype)init UNAVAILABLE_ATTRIBUTE; \
                                            + (instancetype)new UNAVAILABLE_ATTRIBUTE;  \

#define FUNC_IMPLEMENT_SINGLETON(className)                                                        \
    static className *mInstance = nil;                                                             \
    +(className *)sharedInstance {                                                                 \
        static dispatch_once_t once;                                                               \
        dispatch_once(&once, ^{                                                                    \
            mInstance = [[self alloc] init];                                                       \
        });                                                                                        \
        return mInstance;                                                                          \
    }
    
/*************************  Marco methods  ***************************/
#pragma mark - Marco method

#define STR_EMPTY(str) ((str == nil) || (str.length <= 0))

#define DEF_WEAK_SELF(weakself) __weak typeof(self) weakself = self

/**  Get appDelegate   */
#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])


/*************************  UI Tools  ***************************/
#pragma mark - UI Tools

#define CLEAR_VIEWS(view) [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]

// show toast
#define SHOW_TOAST(msg) [((AppDelegate *)[UIApplication sharedApplication].delegate)showToast:msg]

// show progressBar
#define SHOW_PROGRESS_BAR()                                                                        \
    [((AppDelegate *)[UIApplication sharedApplication].delegate)showProgressBar]
// hide progressBar
#define HIDE_PROGRESS_BAR()                                                                        \
    [((AppDelegate *)[UIApplication sharedApplication].delegate)hideProgressBar]
    
#define PUSH(viewController)                                                                       \
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).mNaviController                 \
        pushViewController:viewController                                                          \
                  animated:YES]

    
#define POP_SELF() [self.navigationController popViewControllerAnimated:YES]
#define POP(viewController) [viewController.navigationController popViewControllerAnimated:YES]

#define POP_ALL(isAnimated)                                                                        \
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).mNaviController                 \
        popToRootViewControllerAnimated:isAnimated]
        
#define SHOW_LOGIN_SHEET()                                                                         \
    [((AppDelegate *)[UIApplication sharedApplication].delegate)showLoginSheet]
    
/*************************  Block Tools  ***************************/
#pragma mark - Block Tools

/**
 *  @author luochenxun(luochenxun@gmail.com), 15-06-11 16:06:58
 *
 *  Simple Callback block , will callback with a data of NSDictionary
 *
 *  @param dataDict : the callback's param
 */
typedef void (^CallBackBlockWithDictParam)(NSDictionary *dataDict);

#define dispatch_main_sync_safe(block)  \
    if ([NSThread isMainThread]) {      \
        block();                        \
    } else {                            \
        dispatch_sync(dispatch_get_main_queue(), block);    \
    }

#define dispatch_main_async_safe(block)                     \
    if ([NSThread isMainThread]) {                          \
        block();                                            \
    } else {                                                \
        dispatch_async(dispatch_get_main_queue(), block);   \
    }



// 通用weakify&strongify宏，可以提升使用弱引用效率
#define weakify(var) __weak typeof(var) AHKWeak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = AHKWeak_##var; \
_Pragma("clang diagnostic pop")

#endif
