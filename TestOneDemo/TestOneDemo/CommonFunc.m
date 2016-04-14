//
//  CommonFunc.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/4/14.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc
// 格式化手机号：如13344446789 ==> 133****6789 (hiddenRange:NSRange(3,4) hiddenFlag:'*')
+ (NSString *)formatPhoneNum:(NSString *)phoneNum hiddenRange:(NSRange)hiddenRange hiddenFlag:(char)hiddenFlag {
    NSString *hiddenString = @"";
    NSString *resultString = nil;
    if (hiddenRange.location < phoneNum.length) {
        if (([phoneNum length]-hiddenRange.location) < hiddenRange.length) {
            for (NSInteger i = 0; i < [phoneNum length]-hiddenRange.location; i ++){
                hiddenString = [hiddenString stringByAppendingFormat:@"%c", hiddenFlag];
            }
            resultString = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(hiddenRange.location, [phoneNum length]-hiddenRange.location) withString:hiddenString];
        } else {
            for (NSInteger i = 0; i < hiddenRange.length; i ++){
                hiddenString = [hiddenString stringByAppendingFormat:@"%c", hiddenFlag];
            }
            resultString = [phoneNum stringByReplacingCharactersInRange:hiddenRange withString:hiddenString];
        }
    } else {
        resultString = phoneNum;
    }
    
    return resultString;
}

// 判断字符串是否手机号
+ (BOOL)isPhoneNum:(NSString *)str
{
    NSString * MOBILE = @"^\\d{11}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:str] == NO) {
        return NO;
    }
    return YES;
}

// 判断字符串是否email
+ (BOOL)isEmail:(NSString *)str
{
    NSString * email = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", email];
    if ([regextestmobile evaluateWithObject:str] == NO)
        return NO;
    return YES;
}

+ (BOOL)isIdentity:(NSString*)str
{
    NSString* identity = @"^[0-9]{16,18}$";
    NSPredicate *pwTest3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", identity];
    if ([pwTest3 evaluateWithObject:str] == NO) {
        return NO;
    }
    return YES;
}
// 判断 手机号
+ (BOOL)checkPhoneNum:(NSString *)phoneNum perrorMsg:(NSString **)perrorMsg
{
    if (phoneNum == nil || phoneNum.length == 0) {
        *perrorMsg = @"手机号不能为空";
        return NO;
    }
    if ([[phoneNum substringToIndex:1] isEqualToString:@"1"] == NO) {
        *perrorMsg = @"手机号必须以1开头";
        return NO;
    }
    NSString * MOBILE = @"[0-9]{11}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phoneNum] == NO) {
        *perrorMsg = @"手机号要以1开头的11位数字";
        return NO;
    }
    return YES;
}
//校验手机号码 详细格式校验
+ (BOOL) checkMobilePhoneNumber: (NSString *) strPhoneNumber
{
    if ( strPhoneNumber ) {
        NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                                  initWithPattern:@"^[1][3-8]\\d{9}$"
                                                  options:NSRegularExpressionCaseInsensitive
                                                  error:nil];
        NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:strPhoneNumber
                                                                      options:NSMatchingReportProgress
                                                                        range:NSMakeRange(0, strPhoneNumber.length)];
        
        if(numberofMatch > 0)
        {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)checkPassword:(NSString *)password perrorMsg:(NSString **)perrorMsg{
    if (password == nil || password.length == 0) {
        *perrorMsg = @"密码不能为空";
        return NO;
    }
    
    NSString *pwRegex1 = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate *passwordlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex1];
    if ([passwordlTest evaluateWithObject:password] == NO) {
        *perrorMsg = @"密码只能由数字和字母组成,长度6-16位";
        return NO;
    }
    
    NSString* pwRegex2 = @"^[a-zA-Z]{6,16}$";
    NSPredicate *pwTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex2];
    if ([pwTest2 evaluateWithObject:password]) {
        *perrorMsg = @"密码必须包含至少一个数字";
        return NO;
    }
    
    NSString* pwRegex3 = @"^[0-9]{6,16}$";
    NSPredicate *pwTest3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex3];
    if ([pwTest3 evaluateWithObject:password]) {
        *perrorMsg = @"密码必须至少包含一个字母";
        return NO;
    }
    
    NSString* pwRegex4 = @"([a-zA-Z0-9])\1{2}";
    NSPredicate *pwTest4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwRegex4];
    if ([pwTest4 evaluateWithObject:password.uppercaseString]) {
        *perrorMsg = @"同一数字或字母不能出现连续三次重复；如：111";
        return NO;
    }
    return YES;
}

//返回与当前日期相隔某天的日期 day 正数 就是date以后的日子，负数，就是date以前的日子
-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day

{

    NSDateComponents *comps = [[NSDateComponents alloc] init];

    //    [comps setMonth:month];
    [comps setDay:day];

    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];


    return mDate;

}
//自己创建日期数组
-(NSMutableArray *)makedateArr{
    NSMutableArray * dateArr = [[NSMutableArray alloc]init];
    NSDate * currentDate= [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    for (int i = - 7; i< 31; i++) {
        NSDate * date =[self getPriousorLaterDateFromDate:currentDate withDay:i];
        NSString *str = [formatter stringFromDate:date];
        [dateArr addObject:str];
    }
    return  dateArr;
}

@end
