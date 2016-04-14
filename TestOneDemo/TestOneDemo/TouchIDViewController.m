//
//  TouchIDViewController.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/3/15.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import "TouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDViewController ()
@property (nonatomic,strong)UISwitch * mySwitch;
@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mySwitch];
}

- (UISwitch *)mySwitch{
    if (!_mySwitch) {
        _mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(100, 200, 300, 44)];
        _mySwitch.center = self.view.center;
        
        [_mySwitch addTarget:self action:@selector(clikOn:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}

- (void)clikOn:(UISwitch *)sender{
    LAContext * context = [LAContext new];
    
    context.localizedFallbackTitle = @"忘记密码";
    NSError * error;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"设备支持Touch ID");

//        kLAPolicyDeviceOwnerAuthenticationWithBiometrics 。3次以后会提示识别识别。。然后没有后续操作，自己写。。
//        LAPolicyDeviceOwnerAuthentication 用户指纹识别3次以后会自动跳出输入密码解锁页面。。。
//        NSData * currentDomainState =[[NSUserDefaults standardUserDefaults]valueForKey:@"TouchIDDomainState"];//这个还没有验证，不知道怎么搞，暂时就先这样吧，要不还是验证下吧，不知道等到啥时候了，验证了下，好像并没有用呀，我新添加了个指纹，然后直接就能识别成功，currentDomainState一直是nil，我删除试试,确实。一直是nil，指纹删除了，就直接不能识别成功了。
        
        
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                NSLog(@"指纹识别成功");
//                [[NSUserDefaults standardUserDefaults]setValue:currentDomainState forKey:@"TouchIDDomainState"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    [view removeFromSuperview];
//                    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",self.mySwitch.on] forKey:@"ontouch"];
                });
            }
            else{
                if (error.code == kLAErrorAuthenticationFailed) {
                    NSLog(@"指纹识别失败");
                }
                if (error.code == kLAErrorUserFallback) {
                    NSLog(@"选择输入密码");
                }
                if (error.code == kLAErrorTouchIDNotAvailable) {
                    NSLog(@"TouchID不可用,设备没有指纹传感器");
                }
                if (error.code == kLAErrorTouchIDNotEnrolled) {
                    NSLog(@"TouchID不可用，用户没注册，没添加");
                }
                if (error.code == kLAErrorUserCancel) {
                    NSLog(@"用户取消");
                }
                if (error.code == kLAErrorTouchIDLockout) {
                    //指纹识别失败多次，要重新输入密码解锁指纹，或者如关机之后，再开机必须输入密码
                    NSLog(@"指纹锁定，请输入开机密码，解锁指纹");
                }
                if (error.code == kLAErrorSystemCancel ) {
                    NSLog(@"系统取消授权，有别的应用切入前台的时候，用户自己按了home键，或者自己点了别的应用");
                }
                if (error.code == kLAErrorPasscodeNotSet) {
                    NSLog(@"没有设置开机密码，不能打开指纹验证");
                }
                if (error.code == kLAErrorInvalidContext) {
                    NSLog(@"LAContext passed to this call has been previously invalidated.LAContext对象被释放，导致授权失败");
                }
                if (error.code == kLAErrorAppCancel) {
                    NSLog(@"系统应用，例如电话、闹铃等导致App被挂起，取消了授权，不是用户导致的，是系统的应用来了挡不住的。");
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                    [view removeFromSuperview];
                    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",self.mySwitch.on] forKey:@"ontouch"];
                });
            }
            
        }];
    }
    else{
        NSLog(@"设备不支持Touch ID:%@",error);
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备不支持Touch ID" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [sender setOn:0 animated:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",sender.on] forKey:@"ontouch"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            });
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
