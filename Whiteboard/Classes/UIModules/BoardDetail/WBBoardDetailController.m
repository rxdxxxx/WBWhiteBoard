//
//  WBBoardDetailController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/7.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBBoardDetailController.h"
#import "WBSelectPhotoTool.h"
#import "QRImageViewController.h"
@interface WBBoardDetailController ()<WBSelectPhotoToolDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *boardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createNameLabel;
@property (weak, nonatomic) IBOutlet UIView *textFieldContentView;

@property (weak, nonatomic) IBOutlet UIButton *changeCoverBtn;
@property (weak, nonatomic) IBOutlet UITextField *boardNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, strong) WBSelectPhotoTool *photoTool;

@property (nonatomic, strong) UIImage *pickerImage;


@property (weak, nonatomic) IBOutlet UIButton *switchBoardBtn;
@property (weak, nonatomic) IBOutlet UIButton *qrBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBoardBtn;

@end

@implementation WBBoardDetailController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBoardUI];
    [self setupUI];
    [self editBtnMessage];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableViewDelegate
#pragma mark -  CustomDelegate
#pragma mark - WBSelectPhotoToolDelegate
- (void)toolWillSelectImage:(WBSelectPhotoTool *)tool{
    [WBHUD showMessage:@"处理中" toView:self.view];
}

- (void)tool:(WBSelectPhotoTool *)tool didSelectImage:(UIImage *)image{
    [WBHUD hideForView:self.view];
    
    self.coverImageView.image = image;
    self.pickerImage = image;
    self.rrRightBtn.enabled = YES;
}
#pragma mark -  Event Response
- (void)textFieldChangeCallback:(UITextField *)textField{
    self.boardNameLabel.text = textField.text;
    
    // 没选过图片
    if (self.pickerImage == nil) {
        // 输入了值,不是空, 而且和之前的内容也不一致
        NSString *showText = [self.boardNameLabel.text lcg_removeWhitespaceAndNewlineCharacterSet];
        
        if (showText.length > 0) {
            self.rrRightBtn.enabled = ![self.boardNameLabel.text isEqualToString:self.boardModel.boardName];
        }
        else if(showText.length == 0){
            self.rrRightBtn.enabled = NO;
        }
    }
    
    
}
- (IBAction)editBtnclick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self reloadEditState];

}


- (IBAction)pickImageBtnClick:(UIButton *)sender {
    [self.photoTool showSheetInController:self];
}
- (IBAction)switchBoardBtnClick:(UIButton *)sender {
    
    if(![WBUserModel.currentUser.currentBlackboard.objectId isEqualToString:self.boardModel.objectId]){
        UIAlertController *VC = [UIAlertController alertControllerWithTitle:@"是否确认切换?"
                                                                    message:nil
                                                             preferredStyle:(UIAlertControllerStyleAlert)];
        [VC addAction: [UIAlertAction actionWithTitle:@"确认"
                                                style:(UIAlertActionStyleDefault)
                                              handler:^(UIAlertAction * _Nonnull action)
                        {
                            
                            [WBHUD showMessage:@"切换中.." toView:self.view];
                            [WBBoardManager changeUsingBoard:self.boardModel successBlock:^{
                                [WBHUD showSuccessMessage:@"切换成功" toView:self.view];
                                [self reloadSwitchBtn];
                                
                            } failedBlock:^(NSString *message) {
                                [WBHUD showErrorMessage:message toView:self.view];
                            }];
                        }]];
        
        [VC addAction: [UIAlertAction actionWithTitle:@"取消"
                                                style:(UIAlertActionStyleCancel)
                                              handler:nil]];
        
        [self presentViewController:VC animated:YES completion:nil];
        
    }
}
- (IBAction)qrCodeBtnClick:(UIButton *)sender {
    
    QRImageViewController *vc = [[QRImageViewController alloc]init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    
    NSString *qrCodeString = [NSString stringWithFormat:@"%@%@",kQRCodePrefix,self.boardModel.objectId];
    
    vc.qrImage = [QRCodeMaker generateWithDefaultQRCodeData:qrCodeString imageViewWidth:200];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)deleteBoardBtnClick:(UIButton *)sender {
    if([WBUserModel.currentUser.currentBlackboard.objectId isEqualToString:self.boardModel.objectId]){
        [WBHUD showErrorMessage:@"不能删除使用中的板子" toView:self.view];
        return;
    }
        
    
    
    
    UIAlertController *VC = [UIAlertController alertControllerWithTitle:@"是否确认退出?"
                                                                message:nil
                                                         preferredStyle:(UIAlertControllerStyleAlert)];
    [VC addAction: [UIAlertAction actionWithTitle:@"确认"
                                            style:(UIAlertActionStyleDefault)
                                          handler:^(UIAlertAction * _Nonnull action)
                    {
                        
                        [WBHUD showMessage:@"退出中.." toView:self.view];
                        
                        [WBBoardManager quitBoard:self.boardModel
                                       successBlock:^{
                                           [WBHUD showSuccessMessage:@"退出成功" toView:self.view];
                                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                               [self.navigationController popViewControllerAnimated:YES];
                                           });
                                           
                                           
                                           
                                       } failedBlock:^(NSString *message) {
                                           [WBHUD showErrorMessage:message toView:self.view];

                                       }];
                        
                    }]];
    
    [VC addAction: [UIAlertAction actionWithTitle:@"取消"
                                            style:(UIAlertActionStyleCancel)
                                          handler:nil]];
    
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)navRightBtnClick{
    if (self.boardNameLabel.text.length == 0) {
        [WBHUD showErrorMessage:@"给板子起个名字吧" toView:self.view];
        return;
    }
    
    [self.view endEditing:YES];
    
    [WBHUD showMessage:@"更新中..." toView:self.view];
    [WBBoardManager editBoardInfoWithBoard:self.boardModel
                              newBoardName:self.boardNameLabel.text
                             newCoverImage:self.pickerImage
                              successBlock:^
    {
        [WBHUD showSuccessMessage:@"修改成功" toView:self.view];
        [self editBtnclick:self.editBtn];
        
    } failedBlock:^(NSString *message) {
        [WBHUD showErrorMessage:message toView:self.view];
    }];
    
    
}
#pragma mark -  Private Methods

- (void)setupBoardUI{
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.boardModel.coverUrl] placeholderImage:kBoardHoldImage];
    self.boardNameLabel.text = self.boardModel.boardName;
    self.boardNameTextField.text = self.boardModel.boardName;
    self.createNameLabel.text = self.boardModel.createUser.displayName;
}
-(void)setupUI{
    [self rr_initTitleView:self.boardModel.boardName ? : @"板子详情"];
    [self rr_initNavRightBtnWithImageName:@"ico_iap_tick" target:self action:@selector(navRightBtnClick)];
    self.rrRightBtn.enabled = NO;
    if (kScreenWidth > 320) {
        self.boardNameTextField.font = [UIFont systemFontOfSize:12];
    }else{
        self.boardNameTextField.font = [UIFont systemFontOfSize:10];
    }
    
    [self.boardNameTextField addTarget:self action:@selector(textFieldChangeCallback:) forControlEvents:(UIControlEventEditingChanged)];
    
    self.photoTool = [[WBSelectPhotoTool alloc] init];
    self.photoTool.delegate = self;
    
    self.createNameLabel.text = WBUserModel.currentUser.displayName;
}

- (void)reloadSwitchBtn{
    
    if([WBUserModel.currentUser.currentBlackboard.objectId isEqualToString:self.boardModel.objectId]){
        [self.switchBoardBtn setTitle:@"使用中" forState:(UIControlStateNormal)];
        self.switchBoardBtn.enabled = NO;
    }else{
        
        [self.switchBoardBtn setTitle:@"切换到这个白板" forState:(UIControlStateNormal)];
        self.switchBoardBtn.enabled = YES;
    }
}

- (void)editBtnMessage{
    // 1.切换使用白板的按钮
    [self reloadSwitchBtn];
    
    // 2.创建者才能显示删除按钮
    self.deleteBoardBtn.hidden = ![WBUserModel.currentUser.objectId isEqualToString:self.boardModel.createUser.objectId];
    
    
    // 3.编辑按钮
    [self.editBtn setTitle:@"取消编辑"
                  forState:(UIControlStateSelected)];
    [self.editBtn setTitleColor:self.editBtn.titleLabel.textColor forState:UIControlStateSelected];
    [self.editBtn setTintColor: [UIColor clearColor]];
 
    [self reloadEditState];
}

- (void)reloadEditState{
    
    self.changeCoverBtn.hidden = !self.editBtn.selected;
    self.textFieldContentView.hidden = !self.editBtn.selected;
    self.rrRightBtn.hidden = !self.editBtn.selected;
}

#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
