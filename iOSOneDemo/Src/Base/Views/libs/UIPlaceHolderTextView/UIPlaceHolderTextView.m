//
//  UIPlaceHolderTextView.m
//  kidme
//
//  Created by luochenxun on 15/5/22.
//  Copyright (c) 2015年 kacha-mobile. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@implementation UIPlaceHolderTextView

- (void)awakeFromNib {
	[super awakeFromNib];
	
	[self setPlaceholder:@""];
	[self setPlaceholderColor:[UIColor lightGrayColor]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setPlaceholder:@""];
		[self setPlaceholderColor:[UIColor lightGrayColor]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
	}
	return self;
}

- (void)textChanged:(NSNotification *)notification {
	if ([[self placeholder] length] == 0) {
		return;
	}
	
	if ([[self text] length] == 0) {
		[[self viewWithTag:999] setAlpha:1];
	}
	else {
		[[self viewWithTag:999] setAlpha:0];
	}
}

- (void)setText:(NSString *)text {
	[super setText:text];
	
	[self textChanged:nil];
}

- (void)drawRect:(CGRect)rect {
	if ([[self placeholder] length] > 0) {
		if (self.placeHolderLabel == nil) {
			self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, 0)];
			self.placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
			self.placeHolderLabel.numberOfLines = 0;
			self.placeHolderLabel.font = self.font;
			self.placeHolderLabel.backgroundColor = [UIColor clearColor];
			self.placeHolderLabel.textColor = self.placeholderColor;
			self.placeHolderLabel.alpha = 0;
			self.placeHolderLabel.tag = 999;
			[self addSubview:self.placeHolderLabel];
		}
		
		self.placeHolderLabel.text = self.placeholder;
		[self.placeHolderLabel sizeToFit];
		[self sendSubviewToBack:self.placeHolderLabel];
	}
	
	if ([[self text] length] == 0 && [[self placeholder] length] > 0) {
		[[self viewWithTag:999] setAlpha:1];
	}
	
	[super drawRect:rect];
}

@end

//
////隐藏键盘，实现UITextViewDelegate
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
//
//    if ([text isEqualToString:@"\n"]) {
//        [m_textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//
//}
//
//@end
