//
// MMMarkdown.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

//! Project version number for MMMarkdown.
FOUNDATION_EXPORT double MMMarkdownVersionNumber;

//! Project version string for MMMarkdown.
FOUNDATION_EXPORT const unsigned char MMMarkdownVersionString[];

typedef NS_OPTIONS(NSUInteger, MMMarkdownExtensions)
{
    MMMarkdownExtensionsNone = 0,
    
    MMMarkdownExtensionsAutolinkedURLs      = 1 << 0,
//    MMMarkdownExtensionsCrossReferences     = 1 << 1,
//    MMMarkdownExtensionsCustomAttributes    = 1 << 2,
    MMMarkdownExtensionsFencedCodeBlocks    = 1 << 3,
//    MMMarkdownExtensionsFootnotes           = 1 << 4,
    MMMarkdownExtensionsHardNewlines        = 1 << 5,
    MMMarkdownExtensionsStrikethroughs      = 1 << 6,
//    MMMarkdownExtensionsTableCaptions       = 1 << 7,
    MMMarkdownExtensionsTables              = 1 << 8,
    MMMarkdownExtensionsUnderscoresInWords  = 1 << 9,
    
    MMMarkdownExtensionsGitHubFlavored = MMMarkdownExtensionsAutolinkedURLs|MMMarkdownExtensionsFencedCodeBlocks|MMMarkdownExtensionsHardNewlines|MMMarkdownExtensionsStrikethroughs|MMMarkdownExtensionsTables|MMMarkdownExtensionsUnderscoresInWords,
};

@interface MMMarkdown : NSObject

/*!
 Convert a Markdown string to HTML.
 
 @param string
    A Markdown string. Must not be nil.
 @param error
    Out parameter used if an error occurs while parsing the Markdown. May be NULL.
 @result
    Returns an HTML string.
 */
+ (NSString *)HTMLStringWithMarkdown:(NSString *)string error:(__autoreleasing NSError **)error __attribute__((nonnull(1)));

/*!
 Convert a Markdown string to HTML.
 
 @param string
    A Markdown string. Must not be nil.
 @param extensions
    The extensions to enable.
 @param error
    Out parameter used if an error occurs while parsing the Markdown. May be NULL.
 @result
    Returns an HTML string.
 */
+ (NSString *)HTMLStringWithMarkdown:(NSString *)string extensions:(MMMarkdownExtensions)extensions error:(__autoreleasing NSError **)error __attribute__((nonnull(1)));

@end
