//
// UIPlaceHolderTextView.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView {
	NSString *_placeholder;
	UIColor *_placeholderColor;
	@private
	UILabel *_placeHolderLabel;
}


@property (nonatomic, retain) UILabel *placeHolderLabel;

@property (nonatomic, retain) NSString *placeholder;

@property (nonatomic, retain) UIColor *placeholderColor;

- (void)textChanged:(NSNotification *)notification;



@end
