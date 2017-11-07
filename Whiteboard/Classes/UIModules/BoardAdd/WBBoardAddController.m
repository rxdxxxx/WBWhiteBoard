//
//  WBBoardAddController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBBoardAddController.h"
#import "WBSelectPhotoTool.h"

@interface WBBoardAddController ()<WBSelectPhotoToolDelegate>
@property (weak, nonatomic) IBOutlet UILabel *boardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *changeCoverBtn;
@property (weak, nonatomic) IBOutlet UITextField *boardNameTextField;

@property (nonatomic, strong) WBSelectPhotoTool *photoTool;

@property (nonatomic, strong) UIImage *pickerImage;

@end

@implementation WBBoardAddController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self rr_initTitleView:@"新的白板"];
    [self rr_initNavRightBtnWithImageName:@"ico_iap_tick" target:self action:@selector(navRightBtnClick)];
    if (kScreenWidth > 320) {
        self.boardNameTextField.font = [UIFont systemFontOfSize:12];
    }else{
        self.boardNameTextField.font = [UIFont systemFontOfSize:10];
    }
    
    [self.boardNameTextField addTarget:self action:@selector(textFieldChangeCallback:) forControlEvents:(UIControlEventEditingChanged)];
    
    
    self.photoTool = [[WBSelectPhotoTool alloc] init];
    self.photoTool.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -  UITableViewDelegate
#pragma mark -  CustomDelegate
#pragma mark - WBSelectPhotoToolDelegate
- (void)tool:(WBSelectPhotoTool *)tool didSelectImage:(UIImage *)image{
    self.coverImageView.image = image;
    self.pickerImage = image;
}

#pragma mark -  Event Response
- (void)textFieldChangeCallback:(UITextField *)textField{
    self.boardNameLabel.text = textField.text;
    
}

- (IBAction)pickImageBtnClick{
    [self.photoTool showSheetInController:self];

}

- (void)navRightBtnClick{
    
    if (self.pickerImage == nil) {
        [WBHUD showErrorMessage:@"请为小白板,选一个封面" toView:self.view];
        return;
    }
    
    if ([self.boardNameLabel.text lcg_removeWhitespaceAndNewlineCharacterSet].length == 0) {
        [WBHUD showErrorMessage:@"请为小白板,起一个名字" toView:self.view];
        return;
    }
    
    [WBHUD showMessage:@"创建中" toView:self.view];
    [WBBoardManager createNewBoardWithName:self.boardNameLabel.text
                                     image:self.pickerImage
                              successBlock:^
    {
        [WBHUD showSuccessMessage:@"创建成功" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failedBlock:^(NSString *message) {
        [WBHUD showErrorMessage:message toView:self.view];
    }];
}



#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
