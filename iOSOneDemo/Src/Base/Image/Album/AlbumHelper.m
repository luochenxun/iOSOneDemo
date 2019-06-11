//
// AlbumHelper.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "AlbumHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>


@implementation AlbumHelper

#pragma mark - UIImage's methods

/*  UIView to UIImage */
+ (UIImage *)imageFromView:(UIView *)view {
	UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

#pragma mark - 在手机相册中创建相册

/*
 *  -------------  docs  --------------
 *  ALAssetsLibrary、ALAssetsGroup、ALAsset 介绍 :
 *  ALAssetsLibrary提供了我们对iOS设备中的相片、视频的访问。它是连接了我们应用程序和相册之间的访问的一个桥梁。
 *  ALAssetsGroup 指代一个相册。
 *  ALAsset 代表一个单一资源文件。
 *  ALAssetRepresentation封装了ALAsset，包含了一个资源文件中的很多属性。
 */
 
/*  Save uiImage in given album(create it if not exist) */
+ (void)saveUIImage:(UIImage *)image inPhoneAlbum:(NSString *)albumName {
	ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
	NSMutableArray *groups = [[NSMutableArray alloc]init];
	ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
		if (group) {
			[groups addObject:group];
		}
		else {
			BOOL hasTheGroup = NO;
			for (ALAssetsGroup *gp in groups) {
				NSString *name = [gp valueForProperty:ALAssetsGroupPropertyName];
				if ([name isEqualToString:albumName]) {
					hasTheGroup = YES;
				}
			}
			
			if (!hasTheGroup) {
				//do add a group named @albumName
				[assetsLibrary addAssetsGroupAlbumWithName:albumName resultBlock: ^(ALAssetsGroup *group) {
				    if (group != nil) {
				        [groups addObject:group];
					}
				}
				                              failureBlock:nil];
				hasTheGroup = YES;
			}
		}
	};
	
	// 遍历所有相册看要找的相册在不在，如果不在则创建之
	[assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
	
	// 保存指定UIImage入指定相册
	[self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(image)
	              customAlbumName:albumName
	              completionBlock: ^{
//                      //这里可以创建添加成功的方法
//                      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil
//                                                                   message:@"保存成功！"
//                                                                  delegate:nil
//                                                         cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                         otherButtonTitles: nil];
//                      [alert show];
	}
	                 failureBlock: ^(NSError *error) {
	    //处理添加失败的方法显示alert让它回到主线程执行，不然那个框框死活不肯弹出来
	    dispatch_async(dispatch_get_main_queue(), ^{
			//添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
			if ([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound || [error.localizedDescription rangeOfString:@"用户拒绝访问"].location != NSNotFound) {
			    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
			    
			    [alert show];
			}
		});
	}];
}

/*  the method of save image to the spec album  */
+ (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock {
	// Init assetLibrary
	ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
	// weak pt use in block
	__weak ALAssetsLibrary *weakAssetsLibrary = assetsLibrary;
	
	// Init addAsset recall block
	void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
		[assetsLibrary assetForURL:assetURL resultBlock: ^(ALAsset *asset) {
		    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock: ^(ALAssetsGroup *group, BOOL *stop) {
		        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
		            [group addAsset:asset];
		            if (completionBlock) {
		                completionBlock();
					}
				}
			} failureBlock: ^(NSError *error) {
		        if (failureBlock) {
		            failureBlock(error);
				}
			}];
		} failureBlock: ^(NSError *error) {
		    if (failureBlock) {
		        failureBlock(error);
			}
		}];
	};
	
	// write image data to album
	[assetsLibrary writeImageDataToSavedPhotosAlbum:imageData
	                                       metadata:metadata
	                                completionBlock: ^(NSURL *assetURL, NSError *error) {
	    if (customAlbumName) {
	        [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName
	                                       resultBlock: ^(ALAssetsGroup *group) {
	            if (group) {
	                [weakAssetsLibrary assetForURL:assetURL resultBlock: ^(ALAsset *asset) {
	                    [group addAsset:asset];
	                    if (completionBlock) {
	                        completionBlock();
						}
					} failureBlock: ^(NSError *error) {
	                    if (failureBlock) {
	                        failureBlock(error);
						}
					}];
				}
	            else {
	                AddAsset(weakAssetsLibrary, assetURL);
				}
			}
	                                      failureBlock: ^(NSError *error) {
	            AddAsset(weakAssetsLibrary, assetURL);
			}];
		}
	    else {
	        if (completionBlock) {
	            completionBlock();
			}
		}
	}];
}

@end
