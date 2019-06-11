//
// XXDropDownMenu.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>

@interface XXIndexPath : NSObject

@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger row;
- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;
+ (instancetype)indexPathWithCol:(NSInteger)col row:(NSInteger)row;

@end

#pragma mark - data source protocol
@class XXDropDownMenu;

@protocol XXDropDownMenuDataSource <NSObject>

@required
- (NSInteger)menu:(XXDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
- (NSString *)menu:(XXDropDownMenu *)menu titleForRowAtIndexPath:(XXIndexPath *)indexPath;
@optional
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(XXDropDownMenu *)menu;

@end

#pragma mark - delegate
@protocol XXDropDownMenuDelegate <NSObject>
@optional
- (void)menu:(XXDropDownMenu *)menu didSelectRowAtIndexPath:(XXIndexPath *)indexPath;
@end

#pragma mark - interface
@interface XXDropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <XXDropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <XXDropDownMenuDelegate> delegate;

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *separatorColor;
/**
 *  the width of menu will be set to screen width defaultly
 *
 *  @param origin the origin of this view's frame
 *  @param height menu's height
 *
 *  @return menu
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
- (NSString *)titleForRowAtIndexPath:(XXIndexPath *)indexPath;

@end



