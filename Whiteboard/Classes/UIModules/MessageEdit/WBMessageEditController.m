//
//  WBMessageEditController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBMessageEditController.h"

@interface WBMessageEditController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation WBMessageEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rr_initTitleView:@"书写板报"];
    [self rr_initNavRightBtnWithImageName:@"ico_iap_tick" target:self action:@selector(editComplete:)];

    if (self.messageModel) {
        self.textView.text = self.messageModel.message;
        self.rrRightBtn.enabled = NO;
    }
    [self.textView becomeFirstResponder];
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Life Cycle
#pragma mark -  UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    // 如果是修改信息
    if (self.messageModel) {
        if ([textView.text isEqualToString:self.messageModel.dataModel.content]) {
            self.rrRightBtn.enabled = NO;
        }else{
            self.rrRightBtn.enabled = YES;
        }
    }
    
}
#pragma mark -  CustomDelegate
#pragma mark -  Event Response

- (void)editComplete:(UIButton *)btn{
    if (self.messageModel) {
        [self updateMessage:btn];
    }else{
        [self createMessage:btn];
    }
}

#pragma mark -  Private Methods
- (void)updateMessage:(UIButton *)btn{
    
    if ([self.textView.text lcg_removeWhitespaceAndNewlineCharacterSet].length == 0) {
        [WBHUD showErrorMessage:@"请输入要发布的内容"
                         toView:self.view];
        return;
    }

    [self.view endEditing:YES];

    btn.userInteractionEnabled = NO;

    [WBMessageManager editMessageContentWithString:self.textView.text
                                    changedMessage:self.messageModel.dataModel
                                      successBlock:^
    {
        [WBHUD showSuccessMessage:@"修改成功" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            btn.userInteractionEnabled = YES;
        });
        
    } failedBlock:^(NSString *message) {
        btn.userInteractionEnabled = YES;
        [WBHUD showErrorMessage:message toView:self.view];
    }];
    
}
- (void)createMessage:(UIButton *)btn{
    if ([self.textView.text lcg_removeWhitespaceAndNewlineCharacterSet].length == 0) {
        [WBHUD showErrorMessage:@"请输入要发布的内容"
                         toView:self.view];
        return;
    }
    [self.view endEditing:YES];

    btn.userInteractionEnabled = NO;
    [WBMessageManager createMessageWithContent:self.textView.text
                                  successBlock:^
    {
        [WBHUD showSuccessMessage:@"发布成功" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failedBlock:^(NSString *message) {
        btn.userInteractionEnabled = YES;
        [WBHUD showErrorMessage:message toView:self.view];
    }];
}
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
