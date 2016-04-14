//
//  UIColor+Hex.h
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/4/14.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/**
 *	通过16进制获取color
 *
 *	@param	hex	16进制RGB
 *
 *	@return	uicolor
 */
+ (UIColor *)colorWithHex:(NSInteger)hex;

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
@end
