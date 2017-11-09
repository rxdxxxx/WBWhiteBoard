//
//  WBChangeHeaderController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/9.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBChangeHeaderController.h"
#import "WBSelectPhotoTool.h"

@interface WBChangeHeaderController ()<WBSelectPhotoToolDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (nonatomic, strong) WBSelectPhotoTool *photoTool;

@property (nonatomic, strong) UIImage *pickerImage;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation WBChangeHeaderController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rr_initTitleView:@"个人头像"];
    [self rr_initNavRightBtnWithImageName:@"ico_plan_icon_selected" target:self action:@selector(navRightBtnClick:)];
    
    
    WBUserModel *userModel = [WBUserModel currentUser];
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatarUrl] placeholderImage:kUserHeaderHoldImage];    
    
    self.photoTool = [[WBSelectPhotoTool alloc] init];
    self.photoTool.delegate = self;
    
    self.saveBtn.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableViewDelegate
#pragma mark -  CustomDelegate
#pragma mark - WBSelectPhotoToolDelegate
- (void)tool:(WBSelectPhotoTool *)tool didSelectImage:(UIImage *)image{
    self.userHeaderImageView.image = image;
    self.pickerImage = image;
    self.saveBtn.enabled = YES;
    
}
#pragma mark -  Event Response
- (void)navRightBtnClick:(UIButton *)btn{
    [self.photoTool showSheetInController:self];

}

- (IBAction)saveBtnClick:(id)sender {
    self.saveBtn.userInteractionEnabled = NO;
    
    [WBHUD showMessage:@"上传中..." toView:self.view];

    [WBUserModel changeUserHeaderWithImage:self.pickerImage successBlock:^{
        [WBHUD showSuccessMessage:@"修改成功" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated: YES];
        });
        
    } failedBlock:^(NSString *message) {
        [WBHUD showErrorMessage:message toView:self.view];
        self.saveBtn.userInteractionEnabled = YES;

    }];
    
}


#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters
@end
