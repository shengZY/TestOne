//
//  LoginInPutView.m
//  PANewToapAPP
//
//  Created by Yuu_zhang on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "LoginInputView.h"
#import "Masonry.h"
#import "UIColor+Hex.h"

typedef NS_ENUM(NSInteger, ViewAnimationType){
    ViewAnimationTypeUp = 0,
    ViewAnimationTypeDown
};
@interface LoginInputView()<UITextFieldDelegate>


@property (nonatomic ,assign)LoingInputViewType currentType;
@property (nonatomic, assign)ViewAnimationType animationType;

@end

@implementation LoginInputView

- (instancetype)initWithInputViewType:(LoingInputViewType)type InputViewdelete:(id)myDelegate{
    if (self == [super init]) {
        _del = myDelegate;
        _currentType = type;
        [self createViews];
        self.textfield.delegate = self;
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length<=0) {
        if (self.animationType == ViewAnimationTypeDown) {
            [UIView animateWithDuration:0.3 animations:^{
                self.descLableView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0f, 1.0f);
            } completion:^(BOOL finished) {
                self.animationType = ViewAnimationTypeUp;
            }];
        }
    }
    if (self.del && [self.del respondsToSelector:@selector(textFieldShouldReturn:)]) {
       return [self.del textFieldShouldReturn:textField];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.del && [self.del respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return  [self.del textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.animationType == ViewAnimationTypeUp) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.descLableView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(- 0.1* self.descLableView.frame.size.width, -25),0.8f, 0.8f);
            
        } completion:^(BOOL finished) {
            self.animationType = ViewAnimationTypeDown;
        }];
        
    }
    if (self.del && [self.del respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
       return [self.del textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length<=0) {
        if (self.animationType == ViewAnimationTypeDown) {
            [UIView animateWithDuration:0.3 animations:^{
               self.descLableView.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0f, 1.0f);
//                self.inputDescLable.font = [UIFont systemFontOfSize:16];
            } completion:^(BOOL finished) {
                self.animationType = ViewAnimationTypeUp;
            }];
        }
    }
    if (self.del && [self.del respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.del textFieldDidEndEditing:textField];
    }
}

- (void)createViews{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backLineView];
    [self addSubview:self.descLableView];
    CGPoint point = CGPointMake(300, 7);
    self.noticeView  = [[CheckResultView alloc]initWithCenter:point popDirection:YZTCheckResultViewPopDirectionLeft];
    [self addSubview:self.noticeView];
    [self addSubview:self.textfield];
    [self.descLableView addSubview:self.inputDescLable];
    [self.backLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(54);
    }];
    [self.descLableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backLineView.mas_centerY);
        make.left.mas_equalTo(self.backLineView.mas_left).offset(6);
        make.height.mas_equalTo(20);
    }];
    
    [self.inputDescLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.descLableView.mas_centerY);
        make.left.mas_equalTo(self.descLableView.mas_left).offset(6);
        make.right.mas_equalTo(self.descLableView.mas_right).offset(-6);
        make.height.mas_equalTo(self.descLableView);
    }];
    if (_currentType == 0) {
        [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backLineView.mas_centerY);
            make.left.mas_equalTo(self.backLineView.mas_left).offset(10);
            make.right.mas_equalTo(self.backLineView.mas_right);
            make.height.mas_equalTo(self);
        }];
    }
    else{
        UILabel * lineLable =[[UILabel alloc]init];
        lineLable.backgroundColor = [UIColor colorWithHex:0xcccccc];
        [self addSubview:lineLable];
        [self addSubview:self.timeLable];
        [self addSubview:self.rigthBtn];
        [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backLineView.mas_centerY);
            make.left.mas_equalTo(self.backLineView.mas_left).offset(10);
            make.right.mas_equalTo(self.backLineView.mas_centerX).offset(50);
            make.height.mas_equalTo(self);
        }];
        [lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (self.textfield.mas_right).offset(4);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self.backLineView.mas_bottom).offset(-12);
        }];
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineLable.mas_right);
            make.right.mas_equalTo(self.backLineView.mas_right);
            make.height.mas_equalTo(self.backLineView.mas_height);
            make.centerY.mas_equalTo(self.backLineView.mas_centerY);
        }];
        [self.rigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineLable.mas_right);
            make.right.mas_equalTo(self.backLineView.mas_right);
            make.height.mas_equalTo(self.backLineView.mas_height);
            make.centerY.mas_equalTo(self.backLineView.mas_centerY);
        }];
    }
}



- (void)showWarningWith:(NSString *)warnStr{
    CGPoint point = CGPointMake(self.textfield.frame.size.width-30, self.textfield.center.y);
    [self.noticeView popWithInfo:warnStr center:point resultType:YZTCheckResultViewResultFalse];
    
}

- (void)clearAction:(id)sender{
    self.textfield.text = @"";
    [self.textfield resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:LoginInputViewClearNotifaction object:@"buttonUneable"];
    [self.noticeView dismiss];
}

- (UIView *)backLineView{
    if (!_backLineView) {
        _backLineView = [[UIView alloc]init];
        _backLineView.backgroundColor =[UIColor whiteColor];
        _backLineView.layer.borderWidth = 1;
        _backLineView.layer.borderColor = [UIColor colorWithHex:0xcccccc].CGColor;
        _backLineView.clipsToBounds = YES;
        _backLineView.layer.cornerRadius = 6;
    }
    return _backLineView;
}

- (UILabel *)inputDescLable{
    if (!_inputDescLable) {
        _inputDescLable = [[UILabel alloc]init];
        _inputDescLable.font = [UIFont systemFontOfSize:16];
        _inputDescLable.textColor  = [UIColor colorWithHex:0xcccccc];
        _inputDescLable.backgroundColor = [UIColor whiteColor];
        _inputDescLable.textAlignment = NSTextAlignmentCenter;
    }
    return _inputDescLable;
}

- (UITextField *)textfield{
    if (!_textfield) {
        _textfield = [[UITextField alloc]init];
        [_textfield setFont:[UIFont systemFontOfSize:16]];
        [_textfield setTextColor:[UIColor colorWithHex:0x4a4a4a]];
//        _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textfield.rightView = self.rightClearView;
        _textfield.rightViewMode = UITextFieldViewModeWhileEditing;
        
    }
    return _textfield;
}

- (UIView *)rightClearView{
    if (!_rightClearView) {
        _rightClearView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 54)];
        UIImageView * clearImage= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clear"]];
        clearImage.frame = CGRectMake(25, 18, 18, 18);
        [_rightClearView addSubview:clearImage];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 0, 30, 54);
        [btn addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightClearView addSubview:btn];
    }
    return _rightClearView;
}

- (UIView *)descLableView{
    if (!_descLableView) {
        _descLableView = [[UIView alloc]init];
        _descLableView.backgroundColor = [UIColor whiteColor];
    }
    return _descLableView;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc]init];
//        _timeLable.text = @"120秒后重发";
//        _timeLable.textColor = [UIColor colorWithHex:0x9b9b9b];
        _timeLable.font = [UIFont systemFontOfSize:14];
        _timeLable.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLable;
}

- (UIButton *)rigthBtn{
    if (!_rigthBtn) {
        _rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _rigthBtn;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
