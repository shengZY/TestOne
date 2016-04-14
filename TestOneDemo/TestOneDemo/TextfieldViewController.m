//
//  TextfieldViewController.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/4/13.
//  Copyright © 2016年 Phyllis. All rights reserved.
//
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#import "TextfieldViewController.h"
#import "LoginInputView.h"
@interface TextfieldViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField * tf;

@property (nonatomic, strong)LoginInputView * loginview;/**<登录框，这种注释方式可以在下面有提示*/

@end

@implementation TextfieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tf];
    [self.view addSubview:self.loginview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//电话号码规范344
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger textlength = textField.text.length;      //控制光标
    UITextRange *rang01 = textField.selectedTextRange; //控制光标
    
    
    NSCharacterSet * charactereSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[charactereSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    NSString * text = [textField text];
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSMutableString * temString = [NSMutableString stringWithString:text];
    [temString insertString:@" " atIndex:0];
    text = temString;
    
    NSString * newString = @"";
    while (text.length >0) {
        NSString * subString = [text substringToIndex:MIN(text.length, 4)];
        newString =[newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    newString = [newString stringByTrimmingCharactersInSet:[charactereSet invertedSet]];
    
    if (newString.length >=14) {
        return NO;
    }
    [textField setText:newString];
    
    BOOL  isEndSelect = NO;
    if([string isEqualToString:@""])
    {
        if([rang01.end isEqual: textField.endOfDocument])
        {
            isEndSelect = YES;
        }
    }
    if([string isEqualToString:@""])
    {
        if(!isEndSelect)
        {
            UITextPosition *position = [textField positionFromPosition:rang01.start offset:-1];
            if (position ==nil) {
                textField.selectedTextRange = [textField textRangeFromPosition:rang01.start toPosition:rang01.start];
            }
            else{
                textField.selectedTextRange = [textField textRangeFromPosition:position toPosition:position];
            }
            
        }
    }
    else
    {
        UITextPosition *position = [textField positionFromPosition:rang01.start offset:textField.text.length -  textlength];
        if(((textField.text.length -  textlength) == 2)&&[rang01.start isEqual:textField.beginningOfDocument])
        {
            position = [textField positionFromPosition:rang01.start offset:1];
        }
        textField.selectedTextRange = [textField textRangeFromPosition:position toPosition:position];
    }
    return NO;
}

- (UITextField *)tf{
    if (!_tf) {
        _tf = [[UITextField alloc]initWithFrame:CGRectMake(50, 80, 200, 44)];
        _tf.delegate = self;
        _tf.backgroundColor = [UIColor redColor];
        _tf.keyboardType= UIKeyboardTypeNumberPad;
    }
    return  _tf;
}

- (LoginInputView *)loginview{
    if (!_loginview) {
        _loginview = [[LoginInputView alloc]initWithInputViewType:LoingInputViewTypeNomal InputViewdelete:self];
        _loginview.frame = CGRectMake(25, 150, kScreenWidth - 50, 84);
        _loginview.inputDescLable.text = @"请输入手机号登录";
    }
    return _loginview;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
