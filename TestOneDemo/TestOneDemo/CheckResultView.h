//
//  YZTCheckResultView.h
//  16_0324密码状态图表
//
//  Created by ChuckonYin on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//extern const CGFloat YZTCheckResultViewInfoDefaltWidth;

typedef NS_ENUM(NSInteger, CheckResultViewResult){
    YZTCheckResultViewResultFalse
};

typedef NS_ENUM(NSInteger, CheckResultViewPopDirection){
    YZTCheckResultViewPopDirectionLeft,
    YZTCheckResultViewPopDirectionCenter,
    YZTCheckResultViewPopDirectionRight
};

@interface CheckResultView : UIView

@property (nonatomic, assign) CGFloat infoWidth;

- (instancetype)initWithCenter:(CGPoint)center popDirection:(CheckResultViewPopDirection)direction;

- (void)popWithInfo:(NSString *)info resultType:(CheckResultViewResult)result;

- (void)popWithInfo:(NSString *)info center:(CGPoint)center resultType:(CheckResultViewResult)result;

- (void)dismiss;

@end

@interface CheckResultViewDetailView : UIView

- (instancetype)initWithHostView:(CheckResultView *)hostView;

@property (nonatomic, weak) CheckResultView *hostView;

- (void)refreshWithInfo:(NSString *)iofo;

@end

@interface NSString(YZTCheckResultView)

- (CGSize)cr_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)cr_widthForFont:(UIFont *)font;

- (CGFloat)cr_heightForFont:(UIFont *)font width:(CGFloat)width;

@end










