//
//  UIColor+Hex.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/4/14.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)hex
{
    return [UIColor colorWithHex:hex
                           alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hex & 0XFF0000) >> 16) / 255.0
                           green:((hex & 0X00FF00) >> 8)  / 255.0
                            blue:(hex & 0X0000FF)         / 255.0
                           alpha:alpha];
}
@end
