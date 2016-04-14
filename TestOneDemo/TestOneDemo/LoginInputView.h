//
//  LoginInPutView.h
//  PANewToapAPP
//
//  Created by Yuu_zhang on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckResultView.h"

#define LoginInputViewClearNotifaction  @"loginInputViewClear"
@interface LoginInputView : UIView

typedef NS_ENUM(NSInteger, LoingInputViewType){
    LoingInputViewTypeNomal = 0,
    LoingInputViewTypeVerCode //验证码
};

- (instancetype)initWithInputViewType:(LoingInputViewType)type InputViewdelete:(id)myDelegate;


@property (nonatomic,strong)UITextField * textfield;
@property (nonatomic,strong)UILabel * inputDescLable;
@property (nonatomic,strong)UIView * backLineView;
@property (nonatomic,strong)UIView * descLableView;
@property (nonatomic,strong)UIView * rightClearView;
@property (nonatomic,strong)CheckResultView * noticeView;
@property (nonatomic,strong)UIButton *rigthBtn;
@property (nonatomic,strong)UILabel * timeLable;
@property (nonatomic, assign)id<UITextFieldDelegate>del;

@property (nonatomic, copy) NSString *startString, *endString;

- (void)showWarningWith:(NSString *)warnStr;

@end
