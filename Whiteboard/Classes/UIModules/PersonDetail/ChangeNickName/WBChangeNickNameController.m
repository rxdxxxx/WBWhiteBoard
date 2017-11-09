//
//  WBChangeNickNameController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/9.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBChangeNickNameController.h"

@interface WBChangeNickNameController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic, copy) NSString *originalNickName;
@end

@implementation WBChangeNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rr_initTitleView:@"设置昵称"];
    [self.nickNameTextField addTarget:self action:@selector(lcg_textDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    
    
    WBUserModel *userModel = [WBUserModel currentUser];
    self.nickNameTextField.text = userModel.displayName;
    self.originalNickName = self.nickNameTextField.text;
    
    
    [self lcg_textDidChange:self.nickNameTextField];

}

- (void)lcg_textDidChange:(UITextField *)textField{
    if ( textField.text.length > 17) {
        textField.text = [textField.text substringToIndex:17];
    }
    
    if ([textField.text isEqualToString:self.originalNickName]) {
        self.saveBtn.enabled = NO;
    }else{
        if (textField.text.length == 0) {
            self.saveBtn.enabled = NO;
        }else{
            self.saveBtn.enabled = YES;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClick:(id)sender {
    
    if ([self.nickNameTextField.text lcg_removeWhitespaceAndNewlineCharacterSet].length == 0) {
        [WBHUD showErrorMessage:@"请输入正确的昵称" toView:self.view];
        return;
    }
    
    
    self.saveBtn.userInteractionEnabled = NO;
    [WBHUD showMessage:@"上传中..." toView:self.view];
    
    [WBUserModel changeUserNicknameWithString:self.nickNameTextField.text
                                 successBlock:^
    {
        [WBHUD showSuccessMessage:@"修改成功" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated: YES];
        });
        
    } failedBlock:^(NSString *message) {
        
        [WBHUD showErrorMessage:message toView:self.view];
        self.saveBtn.userInteractionEnabled = YES;
    }];
    
    
}

@end
