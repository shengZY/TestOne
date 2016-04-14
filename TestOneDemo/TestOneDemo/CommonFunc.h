//
//  CommonFunc.h
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/4/14.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunc : NSObject

+ (NSString *)formatPhoneNum:(NSString *)phoneNum hiddenRange:(NSRange)hiddenRange hiddenFlag:(char)hiddenFlag;
// 判断字符串是否手机号
+ (BOOL)isPhoneNum:(NSString *)str;
// 判断字符串是否email
+ (BOOL)isEmail:(NSString *)str;
//校验手机号码 详细格式校验
+ (BOOL) checkMobilePhoneNumber: (NSString *) strPhoneNumber;
// 判断 手机号
+ (BOOL)checkPhoneNum:(NSString *)phoneNum perrorMsg:(NSString **)perrorMsg;
+ (BOOL)isIdentity:(NSString*)str;
+ (BOOL)checkPassword:(NSString *)password perrorMsg:(NSString **)perrorMsg;
@end
