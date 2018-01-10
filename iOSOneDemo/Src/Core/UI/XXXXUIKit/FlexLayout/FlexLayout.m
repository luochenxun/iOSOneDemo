//
//  FlexLayout.m
//  TestProj
//
//  Created by luochenxun on 16/5/9.
//  Copyright © 2016年 luochenxun. All rights reserved.
//

#import "FlexLayout.h"

@interface FlexLayout ()

@end

@implementation FlexLayout

#pragma mark - < Life circle >

+ (FlexLinearLayout *)LinearLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align {
    FlexLinearLayout *wrapperLayout =
    [FlexLinearLayout LayoutWithFrame:frame direction:direction justityContent:content alignItems:align];
    return wrapperLayout;
}

+ (FlexLinearLayout *)LinearLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align {
    FlexLinearLayout *wrapperLayout =
    [FlexLinearLayout LayoutWithDirection:direction justityContent:content alignItems:align];
    return wrapperLayout;
}

+ (FlexScrollLayout *)ScrollLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align {
    FlexScrollLayout *wrapperLayout =
    [FlexScrollLayout LayoutWithDirection:direction justityContent:content alignItems:align];
    return wrapperLayout;
}

+ (FlexScrollLayout *)ScrollLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align {
    FlexScrollLayout *wrapperLayout =
    [FlexScrollLayout LayoutWithFrame:frame direction:direction justityContent:content alignItems:align];
    return wrapperLayout;
}

@end
