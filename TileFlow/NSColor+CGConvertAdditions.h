//
//  NSColor+CGConvertAdditions.h
//  Flipdesk
//
//  Created by Stefan Graupner on 10.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  http://forrst.com/posts/CGColor_Additions_for_NSColor-1eW



@interface NSColor (CGConvertAdditions)

/**
 Return CGColor representation of the NSColor in the RGB color space
 */
@property (readonly) CGColorRef CGColor;

/**
 Create new NSColor from a CGColorRef
 */
+ (NSColor*)colorWithCGColor:(CGColorRef)aColor;

@end
