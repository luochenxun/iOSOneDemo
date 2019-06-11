//
// XXToast.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.
/*

XXToast.m

MIT LICENSE

Copyright (c) 2011 Guru Software

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/


#import "XXToast.h"
#import <QuartzCore/QuartzCore.h>

#define CURRENT_TOAST_TAG 6984678

static const CGFloat kComponentPadding = 5;

static XXToastSettings *sharedSettings = nil;

@interface XXToast(private)

- (XXToast *) settings;
- (CGRect)_toastFrameForImageSize:(CGSize)imageSize withLocation:(XXToastImageLocation)location andTextSize:(CGSize)textSize;
- (CGRect)_frameForImage:(XXToastType)type inToastFrame:(CGRect)toastFrame;

@end


@implementation XXToast


- (id) initWithText:(NSString *) tex{
	if (self = [super init]) {
		text = [tex copy];
	}
	
	return self;
}

- (void) show{
	[self show:XXToastTypeNone];
}

- (void) show:(XXToastType) type {
	
	XXToastSettings *theSettings = _settings;
	
	if (!theSettings) {
		theSettings = [XXToastSettings getSharedSettings];
	}
	
	UIImage *image = [theSettings.images valueForKey:[NSString stringWithFormat:@"%i", type]];
	
	UIFont *font = [UIFont systemFontOfSize:theSettings.fontSize];

    NSAttributedString *attributedText =[[NSAttributedString alloc] initWithString:text attributes:@{ NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(280, 60)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize textSize = rect.size;
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + kComponentPadding, textSize.height + kComponentPadding)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.font = font;
	label.text = text;
	label.numberOfLines = 0;
	if (theSettings.useShadow) {
		label.shadowColor = [UIColor darkGrayColor];
		label.shadowOffset = CGSizeMake(1, 1);
	}
	
	UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
	if (image) {
		v.frame = [self _toastFrameForImageSize:image.size withLocation:[theSettings imageLocation] andTextSize:textSize];
        
        switch ([theSettings imageLocation]) {
            case XXToastImageLocationLeft:
                [label setTextAlignment:NSTextAlignmentLeft];
                label.center = CGPointMake(image.size.width + kComponentPadding * 2 
                                           + (v.frame.size.width - image.size.width - kComponentPadding * 2) / 2, 
                                           v.frame.size.height / 2);
                break;
            case XXToastImageLocationTop:
                [label setTextAlignment:NSTextAlignmentCenter];
                label.center = CGPointMake(v.frame.size.width / 2, 
                                           (image.size.height + kComponentPadding * 2 
                                            + (v.frame.size.height - image.size.height - kComponentPadding * 2) / 2));
                break;
            default:
                break;
        }
		
	} else {
		v.frame = CGRectMake(0, 0, textSize.width + kComponentPadding * 2, textSize.height + kComponentPadding * 2);
		label.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 2);
	}
	CGRect lbfrm = label.frame;
	lbfrm.origin.x = ceil(lbfrm.origin.x);
	lbfrm.origin.y = ceil(lbfrm.origin.y);
	label.frame = lbfrm;
	[v addSubview:label];
	
	if (image) {
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		imageView.frame = [self _frameForImage:type inToastFrame:v.frame];
		[v addSubview:imageView];
	}
	
	v.backgroundColor = [UIColor colorWithRed:theSettings.bgRed green:theSettings.bgGreen blue:theSettings.bgBlue alpha:theSettings.bgAlpha];
	v.layer.cornerRadius = theSettings.cornerRadius;
	
	UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	
	CGPoint point = CGPointZero;
	
	UIInterfaceOrientation orientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
	double version = [[[UIDevice currentDevice] systemVersion] doubleValue];
	switch (orientation) {
		case UIDeviceOrientationPortrait:
		{
			if (theSettings.gravity == XXToastGravityTop) {
				point = CGPointMake(window.frame.size.width / 2, 45);
			} else if (theSettings.gravity == XXToastGravityBottom) {
				point = CGPointMake(window.frame.size.width / 2, window.frame.size.height - 45);
			} else if (theSettings.gravity == XXToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x + theSettings.offsetLeft, point.y + theSettings.offsetTop);
			break;
		}
		case UIDeviceOrientationPortraitUpsideDown:
		{
			if (version < 8.0) {
				v.transform = CGAffineTransformMakeRotation(M_PI);
			}
			
			float width = window.frame.size.width;
			float height = window.frame.size.height;
			
			if (theSettings.gravity == XXToastGravityTop) {
				point = CGPointMake(width / 2, height - 45);
			} else if (theSettings.gravity == XXToastGravityBottom) {
				point = CGPointMake(width / 2, 45);
			} else if (theSettings.gravity == XXToastGravityCenter) {
				point = CGPointMake(width/2, height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x - theSettings.offsetLeft, point.y - theSettings.offsetTop);
			break;
		}
		case UIDeviceOrientationLandscapeLeft:
		{
			if (version < 8.0) {
				v.transform = CGAffineTransformMakeRotation(M_PI/2); //rotation in radians
			}
			
			if (theSettings.gravity == XXToastGravityTop) {
				point = CGPointMake(window.frame.size.width - 45, window.frame.size.height / 2);
			} else if (theSettings.gravity == XXToastGravityBottom) {
				point = CGPointMake(45,window.frame.size.height / 2);
			} else if (theSettings.gravity == XXToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x - theSettings.offsetTop, point.y - theSettings.offsetLeft);
			break;
		}
		case UIDeviceOrientationLandscapeRight:
		{
			if (version < 8.0) {
				v.transform = CGAffineTransformMakeRotation(-M_PI/2);
			}
			
			if (theSettings.gravity == XXToastGravityTop) {
				point = CGPointMake(45, window.frame.size.height / 2);
			} else if (theSettings.gravity == XXToastGravityBottom) {
				point = CGPointMake(window.frame.size.width - 45, window.frame.size.height/2);
			} else if (theSettings.gravity == XXToastGravityCenter) {
				point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
			} else {
				// TODO : handle this case
				point = theSettings.postition;
			}
			
			point = CGPointMake(point.x + theSettings.offsetTop, point.y + theSettings.offsetLeft);
			break;
		}
		default:
			break;
	}

	v.center = point;
	v.frame = CGRectIntegral(v.frame);
	
	NSTimer *timer1 = [NSTimer timerWithTimeInterval:((float)theSettings.duration)/1000 
											 target:self selector:@selector(hideToast:) 
										   userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
	
	v.tag = CURRENT_TOAST_TAG;

	UIView *currentToast = [window viewWithTag:CURRENT_TOAST_TAG];
	if (currentToast != nil) {
    	[currentToast removeFromSuperview];
	}

	v.alpha = 0;
	[window addSubview:v];
	[UIView beginAnimations:nil context:nil];
	v.alpha = 1;
	[UIView commitAnimations];
	
	view = v;
	
	[v addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchDown];
}

- (CGRect)_toastFrameForImageSize:(CGSize)imageSize withLocation:(XXToastImageLocation)location andTextSize:(CGSize)textSize {
    CGRect theRect = CGRectZero;
    switch (location) {
        case XXToastImageLocationLeft:
            theRect = CGRectMake(0, 0, 
                                 imageSize.width + textSize.width + kComponentPadding * 3, 
                                 MAX(textSize.height, imageSize.height) + kComponentPadding * 2);
            break;
        case XXToastImageLocationTop:
            theRect = CGRectMake(0, 0, 
                                 MAX(textSize.width, imageSize.width) + kComponentPadding * 2, 
                                 imageSize.height + textSize.height + kComponentPadding * 3);
            
        default:
            break;
    }    
    return theRect;
}

- (CGRect)_frameForImage:(XXToastType)type inToastFrame:(CGRect)toastFrame {
    XXToastSettings *theSettings = _settings;
    UIImage *image = [theSettings.images valueForKey:[NSString stringWithFormat:@"%i", type]];
    
    if (!image) return CGRectZero;
    
    CGRect imageFrame = CGRectZero;

    switch ([theSettings imageLocation]) {
        case XXToastImageLocationLeft:
            imageFrame = CGRectMake(kComponentPadding, (toastFrame.size.height - image.size.height) / 2, image.size.width, image.size.height);
            break;
        case XXToastImageLocationTop:
            imageFrame = CGRectMake((toastFrame.size.width - image.size.width) / 2, kComponentPadding, image.size.width, image.size.height);
            break;
            
        default:
            break;
    }
    
    return imageFrame;
    
}

- (void) hideToast:(NSTimer*)theTimer{
	[UIView beginAnimations:nil context:NULL];
	view.alpha = 0;
	[UIView commitAnimations];
	
	NSTimer *timer2 = [NSTimer timerWithTimeInterval:500 
											 target:self selector:@selector(hideToast:) 
										   userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];
}

- (void) removeToast:(NSTimer*)theTimer{
	[view removeFromSuperview];
}


+ (XXToast *) makeText:(NSString *) _text{
	XXToast *toast = [[XXToast alloc] initWithText:_text];
	
	return toast;
}


- (XXToast *) setDuration:(NSInteger ) duration{
	[self theSettings].duration = duration;
	return self;
}

- (XXToast *) setGravity:(XXToastGravity) gravity 
			 offsetLeft:(NSInteger) left
			  offsetTop:(NSInteger) top{
	[self theSettings].gravity = gravity;
	[self theSettings].offsetLeft = left;
	[self theSettings].offsetTop = top;
	return self;
}

- (XXToast *) setGravity:(XXToastGravity) gravity{
	[self theSettings].gravity = gravity;
	return self;
}

- (XXToast *) setPostion:(CGPoint) _position{
	[self theSettings].postition = CGPointMake(_position.x, _position.y);
	
	return self;
}

- (XXToast *) setFontSize:(CGFloat) fontSize{
	[self theSettings].fontSize = fontSize;
	return self;
}

- (XXToast *) setUseShadow:(BOOL) useShadow{
	[self theSettings].useShadow = useShadow;
	return self;
}

- (XXToast *) setCornerRadius:(CGFloat) cornerRadius{
	[self theSettings].cornerRadius = cornerRadius;
	return self;
}

- (XXToast *) setBgRed:(CGFloat) bgRed{
	[self theSettings].bgRed = bgRed;
	return self;
}

- (XXToast *) setBgGreen:(CGFloat) bgGreen{
	[self theSettings].bgGreen = bgGreen;
	return self;
}

- (XXToast *) setBgBlue:(CGFloat) bgBlue{
	[self theSettings].bgBlue = bgBlue;
	return self;
}

- (XXToast *) setBgAlpha:(CGFloat) bgAlpha{
	[self theSettings].bgAlpha = bgAlpha;
	return self;
}


- (XXToastSettings *) theSettings{
	if (!_settings) {
		_settings = [[XXToastSettings getSharedSettings] copy];
	}
	
	return _settings;
}

@end


@implementation XXToastSettings
@synthesize offsetLeft;
@synthesize offsetTop;
@synthesize duration;
@synthesize gravity;
@synthesize postition;
@synthesize fontSize;
@synthesize useShadow;
@synthesize cornerRadius;
@synthesize bgRed;
@synthesize bgGreen;
@synthesize bgBlue;
@synthesize bgAlpha;
@synthesize images;
@synthesize imageLocation;

- (void) setImage:(UIImage *) img withLocation:(XXToastImageLocation)location forType:(XXToastType) type {
	if (type == XXToastTypeNone) {
		// This should not be used, internal use only (to force no image)
		return;
	}
	
	if (!images) {
		images = [[NSMutableDictionary alloc] initWithCapacity:4];
	}
	
	if (img) {
		NSString *key = [NSString stringWithFormat:@"%i", type];
		[images setValue:img forKey:key];
	}
    
    [self setImageLocation:location];
}

- (void)setImage:(UIImage *)img forType:(XXToastType)type {
    [self setImage:img withLocation:XXToastImageLocationLeft forType:type];
}


+ (XXToastSettings *) getSharedSettings{
	if (!sharedSettings) {
		sharedSettings = [XXToastSettings new];
		sharedSettings.gravity = XXToastGravityCenter;
		sharedSettings.duration = XXToastDurationShort;
		sharedSettings.fontSize = 16.0;
		sharedSettings.useShadow = YES;
		sharedSettings.cornerRadius = 5.0;
		sharedSettings.bgRed = 0;
		sharedSettings.bgGreen = 0;
		sharedSettings.bgBlue = 0;
		sharedSettings.bgAlpha = 0.7;
		sharedSettings.offsetLeft = 0;
		sharedSettings.offsetTop = 0;
	}
	
	return sharedSettings;
	
}

- (id) copyWithZone:(NSZone *)zone{
	XXToastSettings *copy = [XXToastSettings new];
	copy.gravity = self.gravity;
	copy.duration = self.duration;
	copy.postition = self.postition;
	copy.fontSize = self.fontSize;
	copy.useShadow = self.useShadow;
	copy.cornerRadius = self.cornerRadius;
	copy.bgRed = self.bgRed;
	copy.bgGreen = self.bgGreen;
	copy.bgBlue = self.bgBlue;
	copy.bgAlpha = self.bgAlpha;
	copy.offsetLeft = self.offsetLeft;
	copy.offsetTop = self.offsetTop;
	
	NSArray *keys = [self.images allKeys];
	
	for (NSString *key in keys) {
		[copy setImage:[images valueForKey:key] forType:[key intValue]];
	}
    
    [copy setImageLocation:imageLocation];
	
	return copy;
}

@end
