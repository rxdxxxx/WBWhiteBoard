//
//  WBRegisterController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBRegisterController.h"

@interface WBRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation WBRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self rr_initTitleView:@"注册"];
    [self rr_initGoBackButton];
    
}

- (void)rr_backAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerBtnClick:(id)sender {
    
//    let randomUser = UserModel()
//
//    guard
//    let userName = userNameTextField.text,
//    userNameTextField.text!.characters.count > 0,
//    let password = passwordTextField.text,
//    passwordTextField.text!.characters.count > 0 else {
//        print("需要输入内容的啊")
//        return
//    }
//
//
//    randomUser.username = LCString(userName)
//    randomUser.password = LCString(password)
//
//    if(randomUser.signUp().isSuccess){
//        print("注册成功")
//    }else{
//        print("注册失败")
//
//    }
    if ([self.userNameTextField.text lcg_removeWhitespaceAndNewlineCharacterSet].length == 0 || [self.passwordTextField.text lcg_removeWhitespaceAndNewlineCharacterSet].length == 0) {
        [WBHUD showErrorMessage:@"需要输入内容的啊" toView:self.view];
        return;
    }
    
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = self.userNameTextField.text;// 设置用户名
    user.password =  self.passwordTextField.text;// 设置密码
    
    [WBHUD showMessage:@"注册中" toView:self.view];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功
            [WBHUD showSuccessMessage:@"注册成功" toView:self.view];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
            [WBHUD showErrorMessage:error.localizedDescription toView:self.view];
        }
    }];
    
}


@end
