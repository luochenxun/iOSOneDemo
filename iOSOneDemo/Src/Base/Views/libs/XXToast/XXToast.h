/*

XXToast.h

MIT LICENSE

Copyright (c) 2012 Guru Software

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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum XXToastGravity {
	XXToastGravityTop = 1000001,
	XXToastGravityBottom,
	XXToastGravityCenter
}XXToastGravity;

typedef enum XXToastDuration {
	XXToastDurationLong = 10000,
	XXToastDurationShort = 1000,
	XXToastDurationNormal = 3000
}XXToastDuration;

typedef enum XXToastType {
	XXToastTypeInfo = -100000,
	XXToastTypeNotice,
	XXToastTypeWarning,
	XXToastTypeError,
	XXToastTypeNone // For internal use only (to force no image)
}XXToastType;

typedef enum {
    XXToastImageLocationTop,
    XXToastImageLocationLeft
} XXToastImageLocation;


@class XXToastSettings;

@interface XXToast : NSObject {
	XXToastSettings *_settings;
	
	NSTimer *timer;
	
	UIView *view;
	NSString *text;
}

- (void) show;
- (void) show:(XXToastType) type;
- (XXToast *) setDuration:(NSInteger ) duration;
- (XXToast *) setGravity:(XXToastGravity) gravity 
			 offsetLeft:(NSInteger) left
			 offsetTop:(NSInteger) top;
- (XXToast *) setGravity:(XXToastGravity) gravity;
- (XXToast *) setPostion:(CGPoint) position;
- (XXToast *) setFontSize:(CGFloat) fontSize;
- (XXToast *) setUseShadow:(BOOL) useShadow;
- (XXToast *) setCornerRadius:(CGFloat) cornerRadius;
- (XXToast *) setBgRed:(CGFloat) bgRed;
- (XXToast *) setBgGreen:(CGFloat) bgGreen;
- (XXToast *) setBgBlue:(CGFloat) bgBlue;
- (XXToast *) setBgAlpha:(CGFloat) bgAlpha;

+ (XXToast *) makeText:(NSString *) text;

- (XXToastSettings *) theSettings;

@end



@interface XXToastSettings : NSObject<NSCopying>{
	NSInteger duration;
	XXToastGravity gravity;
	CGPoint postition;
	XXToastType toastType;
	CGFloat fontSize;
	BOOL useShadow;
	CGFloat cornerRadius;
	CGFloat bgRed;
	CGFloat bgGreen;
	CGFloat bgBlue;
	CGFloat bgAlpha;
	NSInteger offsetLeft;
	NSInteger offsetTop;

	NSDictionary *images;
	
	BOOL positionIsSet;
}


@property(assign) NSInteger duration;
@property(assign) XXToastGravity gravity;
@property(assign) CGPoint postition;
@property(assign) CGFloat fontSize;
@property(assign) BOOL useShadow;
@property(assign) CGFloat cornerRadius;
@property(assign) CGFloat bgRed;
@property(assign) CGFloat bgGreen;
@property(assign) CGFloat bgBlue;
@property(assign) CGFloat bgAlpha;
@property(assign) NSInteger offsetLeft;
@property(assign) NSInteger offsetTop;
@property(readonly) NSDictionary *images;
@property(assign) XXToastImageLocation imageLocation;


- (void) setImage:(UIImage *)img forType:(XXToastType) type;
- (void) setImage:(UIImage *)img withLocation:(XXToastImageLocation)location forType:(XXToastType)type;
+ (XXToastSettings *) getSharedSettings;
						  
@end
