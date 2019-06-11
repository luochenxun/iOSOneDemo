//
// AFAutoPurgingImageCache.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <TargetConditionals.h>
#import <Foundation/Foundation.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The `AFImageCache` protocol defines a set of APIs for adding, removing and fetching images from a cache synchronously.
 */
@protocol AFImageCache <NSObject>

/**
 Adds the image to the cache with the given identifier.

 @param image The image to cache.
 @param identifier The unique identifier for the image in the cache.
 */
- (void)addImage:(UIImage *)image withIdentifier:(NSString *)identifier;

/**
 Removes the image from the cache matching the given identifier.

 @param identifier The unique identifier for the image in the cache.

 @return A BOOL indicating whether or not the image was removed from the cache.
 */
- (BOOL)removeImageWithIdentifier:(NSString *)identifier;

/**
 Removes all images from the cache.

 @return A BOOL indicating whether or not all images were removed from the cache.
 */
- (BOOL)removeAllImages;

/**
 Returns the image in the cache associated with the given identifier.

 @param identifier The unique identifier for the image in the cache.

 @return An image for the matching identifier, or nil.
 */
- (nullable UIImage *)imageWithIdentifier:(NSString *)identifier;
@end


/**
 The `ImageRequestCache` protocol extends the `ImageCache` protocol by adding methods for adding, removing and fetching images from a cache given an `NSURLRequest` and additional identifier.
 */
@protocol AFImageRequestCache <AFImageCache>

/**
 Asks if the image should be cached using an identifier created from the request and additional identifier.
 
 @param image The image to be cached.
 @param request The unique URL request identifing the image asset.
 @param identifier The additional identifier to apply to the URL request to identify the image.
 
 @return A BOOL indicating whether or not the image should be added to the cache. YES will cache, NO will prevent caching.
 */
- (BOOL)shouldCacheImage:(UIImage *)image forRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;

/**
 Adds the image to the cache using an identifier created from the request and additional identifier.

 @param image The image to cache.
 @param request The unique URL request identifing the image asset.
 @param identifier The additional identifier to apply to the URL request to identify the image.
 */
- (void)addImage:(UIImage *)image forRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;

/**
 Removes the image from the cache using an identifier created from the request and additional identifier.

 @param request The unique URL request identifing the image asset.
 @param identifier The additional identifier to apply to the URL request to identify the image.
 
 @return A BOOL indicating whether or not all images were removed from the cache.
 */
- (BOOL)removeImageforRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;

/**
 Returns the image from the cache associated with an identifier created from the request and additional identifier.

 @param request The unique URL request identifing the image asset.
 @param identifier The additional identifier to apply to the URL request to identify the image.

 @return An image for the matching request and identifier, or nil.
 */
- (nullable UIImage *)imageforRequest:(NSURLRequest *)request withAdditionalIdentifier:(nullable NSString *)identifier;

@end

/**
 The `AutoPurgingImageCache` in an in-memory image cache used to store images up to a given memory capacity. When the memory capacity is reached, the image cache is sorted by last access date, then the oldest image is continuously purged until the preferred memory usage after purge is met. Each time an image is accessed through the cache, the internal access date of the image is updated.
 */
@interface AFAutoPurgingImageCache : NSObject <AFImageRequestCache>

/**
 The total memory capacity of the cache in bytes.
 */
@property (nonatomic, assign) UInt64 memoryCapacity;

/**
 The preferred memory usage after purge in bytes. During a purge, images will be purged until the memory capacity drops below this limit.
 */
@property (nonatomic, assign) UInt64 preferredMemoryUsageAfterPurge;

/**
 The current total memory usage in bytes of all images stored within the cache.
 */
@property (nonatomic, assign, readonly) UInt64 memoryUsage;

/**
 Initialies the `AutoPurgingImageCache` instance with default values for memory capacity and preferred memory usage after purge limit. `memoryCapcity` defaults to `100 MB`. `preferredMemoryUsageAfterPurge` defaults to `60 MB`.

 @return The new `AutoPurgingImageCache` instance.
 */
- (instancetype)init;

/**
 Initialies the `AutoPurgingImageCache` instance with the given memory capacity and preferred memory usage
 after purge limit.

 @param memoryCapacity The total memory capacity of the cache in bytes.
 @param preferredMemoryCapacity The preferred memory usage after purge in bytes.

 @return The new `AutoPurgingImageCache` instance.
 */
- (instancetype)initWithMemoryCapacity:(UInt64)memoryCapacity preferredMemoryCapacity:(UInt64)preferredMemoryCapacity;

@end

NS_ASSUME_NONNULL_END

#endif
