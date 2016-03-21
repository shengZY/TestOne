//
//  ViewController.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 15/12/30.
//  Copyright © 2015年 Phyllis. All rights reserved.
//

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#import "FirstViewController.h"
#import "TestTextField.h"

@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UITextField * numTf;
@property (nonatomic, strong)UITableView * tableV;
@property (nonatomic, strong)UIView * tableHeaderView;
@property (nonatomic, strong)NSMutableArray * dataArr;
@property (nonatomic, assign)BOOL isDecimal;


@end

@implementation FirstViewController

#pragma  mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"NSNumberFormatterStyle";
    [self createSubViews];
//    [self wholeScreenPopGesture];//系统自带左划返回效果，但是自定义button就不行了，需要自己实现。还是借鉴别人的做法吧。
}

//- (void)wholeScreenPopGesture{
//    id taget = self.navigationController.interactivePopGestureRecognizer.delegate ;
//    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:taget action:@selector(handleNavigationTransition:)];
//    pan.delegate  = self;
//    [self.view addGestureRecognizer:pan];
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//   
//}
//
//- (void)handleNavigationTransition:(UIGestureRecognizer *)gesture{
//    
//}
//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (self.navigationController.viewControllers.count<=1) {
//        return NO;
//    }
//    else{
//        CGPoint point = [gestureRecognizer locationInView:self.view];//全屏左划都可以返回，但是会和tableview的滑动删除冲突。
//        if (point.x > ([[UIScreen mainScreen] bounds].size.width *1)) {
//            return NO;
//        }
//        else{
//            return YES;
//        }
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSubViews{
    [self.tableHeaderView addSubview:self.numTf];
    self.numTf.center = self.tableHeaderView.center;
    self.tableV.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:self.tableV];
}

#pragma mark - delegate 

#pragma mark -- tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
    }
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self formmatDigtWithString:self.numTf.text andNumberformmatStyle:indexPath.row];
    if (indexPath.row == 10) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self formmatNumberFromString:self.numTf.text]];
    }
    if (indexPath.row == 11) {
        cell.detailTextLabel.text = [self localizedStringFromSting:self.numTf.text andNumberformatStyle:NSNumberFormatterDecimalStyle];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.numTf resignFirstResponder];
    self.isDecimal = ! self.isDecimal;
    [self.tableV reloadData];
}

#pragma mark -- textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tableV reloadData];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger textlength = textField.text.length;      //控制光标
    UITextRange *rang01 = textField.selectedTextRange; //控制光标
    
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
    {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    
    NSString * newString =[self newStringWithString:text andisDecimal:self.isDecimal];
    
    
    BOOL  isEndSelect = NO;
    if([string isEqualToString:@""])
    {
        if([rang01.end isEqual: textField.endOfDocument])
        {
            isEndSelect = YES;
        }
    }
    int maxLength = 9;
    if (!self.isDecimal) {
        maxLength = maxLength + 2;
    }
    if ([newString rangeOfString:@"."].location != NSNotFound)
    {
        if (newString.length > maxLength + 3)
        {
            return NO;
        }
        
        NSArray *array = [newString componentsSeparatedByString:@"."];
        NSString *str2 = array[1];
        if (str2.length > 2)
        {
            return NO;
        }
        [textField setText:newString];
        
        if ([string isEqualToString:@"."])
        {
            return NO;
        }
    }
    else
    {
        if (newString.length > maxLength)
        {
            return NO;
        }
        [textField setText:newString];
        
    }
    
    if([string isEqualToString:@""])
    {
        if(!isEndSelect)
        {
            UITextPosition *position = [textField positionFromPosition:rang01.start offset:-1];
            textField.selectedTextRange = [textField textRangeFromPosition:position toPosition:position];
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


- (NSString * )newStringWithString:(NSString *)textStr andisDecimal:(BOOL)decimal{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.\b"];
    if (decimal) {
        textStr = [textStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSString * decimalStr = @"";
        NSString *newString =@"";
        if ([textStr containsString:@"."]) {
            NSArray * arr  =[textStr componentsSeparatedByString:@"."];
            decimalStr = [arr objectAtIndex:1];
            NSString * numStr = [arr objectAtIndex:0];
            textStr = [self formmatDigtWithString:numStr andNumberformmatStyle:NSNumberFormatterDecimalStyle];
            newString = [NSString stringWithFormat:@"%@.%@",textStr,decimalStr];
            
        }
        else{
            newString =[self formmatDigtWithString:textStr andNumberformmatStyle:NSNumberFormatterDecimalStyle];
        }
        return newString;
    }
    else{
        NSString *newString = textStr;
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];//过滤特殊字符的方法
        return newString;
    }
}


#pragma mark - event response

#pragma mark -- NsNumberFormatterMethod

- (NSString * )formmatDigtWithString:(NSString * )numStr andNumberformmatStyle:(NSNumberFormatterStyle )style{
    double value = [numStr doubleValue];
    NSNumberFormatter *formmat =[[NSNumberFormatter alloc]init];
    formmat.numberStyle = style;
//    formmat.positiveFormat = @"￥###,##0.00";
//    [formmat setMaximumFractionDigits:2];
//    [formmat setMinimumFractionDigits:2];
    NSString * newStr = [formmat stringFromNumber:[NSNumber numberWithDouble:value]];
    return newStr;
}


- (NSNumber * )formmatNumberFromString:(NSString *)str{
    NSNumber * number ;
    NSNumberFormatter *formmat =[[NSNumberFormatter alloc]init];
    formmat.numberStyle = NSNumberFormatterDecimalStyle;
//    [formmat setMinimumFractionDigits:2];
//    [formmat setMaximumFractionDigits:2];
//    formmat.positiveFormat = @"###,##0.00";
    number = [formmat numberFromString:str];
    return number;
}


-(NSString *)localizedStringFromSting:(NSString *)str andNumberformatStyle:(NSNumberFormatterStyle )style{
    double value = [str doubleValue];
   NSString * newStr =[NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble:value] numberStyle:NSNumberFormatterDecimalStyle];
    return newStr;
}

- (void)searchTouchAction:(UIButton *)sender{
    static BOOL isSecure;
    self.numTf.secureTextEntry = isSecure;//是否变成密码。。明文变密文
    isSecure = ! isSecure;
    NSLog(@"leftView Touch %@",self.numTf.text);
}

#pragma mark - getter&& setter
//自定义textfield
- (UITextField *)numTf {
    if (!_numTf) {
        _numTf = [[TestTextField alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
        _numTf.placeholder = @"请输入数字";
        
        _numTf.delegate = self;
        _numTf.borderStyle = UITextBorderStyleNone;
//        _numTf.clipsToBounds = YES;
        _numTf.layer.cornerRadius = 10.0;//边框颜色，宽度，圆角,但是只有UITextBorderStyleNone时候管用，其他模式下，不起作用。
        _numTf.layer.borderWidth = 1;
        _numTf.layer.borderColor = [UIColor redColor].CGColor;
        UIImage * searchImage =[UIImage imageNamed:@"searchIcon"];
        UIImageView * imageIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, searchImage.size.width, searchImage.size.height)];//想设置图片的位置，但是貌似不管用
       
        imageIV.image =searchImage;
        imageIV.backgroundColor = [UIColor redColor];
        imageIV.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchTouchAction:)];
        [imageIV addGestureRecognizer:tap];
//        _numTf.clearButtonMode
        _numTf.clearButtonMode = UITextFieldViewModeAlways;//和右侧视图一起设置的时候不会出现。。
//        _numTf.clearButtonMode
//        _numTf.leftView = imageIV;
//        _numTf.leftViewMode = UITextFieldViewModeAlways;//左边的视图，右边也一样可以添加，但是要设viewMode，不然不出来，，，
//        _numTf.rightView = imageIV;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        view.backgroundColor = [UIColor grayColor];
        [view addSubview:imageIV];
        _numTf.rightView = view;
        [_numTf.rightView addSubview:imageIV];
//        _numTf.rightView.frame = CGRectMake(30, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
        _numTf.rightViewMode = UITextFieldViewModeAlways;
        _numTf.keyboardType = UIKeyboardTypeDecimalPad;
        _numTf.returnKeyType =  UIReturnKeyDone;
    }
    return  _numTf;
}

- (UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
    }
    return _tableV;
}

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    }
    return _tableHeaderView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        [_dataArr addObject:@"NSNumberFormatterNoStyle"];
        [_dataArr addObject:@"DecimalStyle"];
        [_dataArr addObject:@"CurrencyStyle"];
        [_dataArr addObject:@"PercentStyle"];
        [_dataArr addObject:@"ScientificStyle"];
        [_dataArr addObject:@"SpellOutStyle"];
        [_dataArr addObject:@"OrdinalStyle"];
        [_dataArr addObject:@"CurrencyISOCodeStyle"];
        [_dataArr addObject:@"CurrencyPluralStyle"];
        [_dataArr addObject:@"CurrencyAccountingStyle"];
        [_dataArr addObject:@"nmberFormString"];
        [_dataArr addObject:@"localizedStrFromNum"];
    }
    return _dataArr;
}

@end
