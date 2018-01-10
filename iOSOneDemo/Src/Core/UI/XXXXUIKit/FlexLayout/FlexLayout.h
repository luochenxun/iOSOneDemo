//
//  FlexLayout.h
//  TestProj
//
//  Created by luochenxun on 16/5/9.
//  Copyright © 2016年 luochenxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+FlexLayout.h"
#import "FlexlayoutMacro.h"
#import "FlexScrollLayout.h"
#import "FlexLinearLayout.h"

@interface FlexLayout : NSObject

#pragma mark - < Factory methods >

/**
 *  Common init method , return a FlexLinearLayout
 */
+ (FlexLinearLayout *)LinearLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align;
+ (FlexLinearLayout *)LinearLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align;

/**
 *  Scrollable factory methods
 */
+ (FlexScrollLayout *)ScrollLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align;
+ (FlexScrollLayout *)ScrollLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align;

@end
