//
//  UIPlaceHolderTextView.h
//  kidme
//
//  Created by luochenxun on 15/5/22.
//  Copyright (c) 2015年 kacha-mobile. All rights reserved.
//

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
