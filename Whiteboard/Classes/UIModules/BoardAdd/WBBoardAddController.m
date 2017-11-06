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
}

#pragma mark -  Event Response
- (void)textFieldChangeCallback:(UITextField *)textField{
    self.boardNameLabel.text = textField.text;
    
}

- (IBAction)pickImageBtnClick{
    [self.photoTool showSheetInController:self];

}

- (void)navRightBtnClick{
    
}

#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
