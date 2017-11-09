//
//  WBQRScanResultController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/8.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBQRScanResultController.h"

@interface WBQRScanResultController ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *boardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation WBQRScanResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rr_initTitleView:@"码的结果"];
    // Do any additional setup after loading the view from its nib.
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.boardModel.coverUrl] placeholderImage:kBoardHoldImage];
    self.boardNameLabel.text = self.boardModel.boardName;
    self.createNameLabel.text = self.boardModel.createUser.displayName;
    
    self.addBtn.enabled = NO;
    
    [WBHUD showSuccessMessage:nil toView:self.view];
    [WBBoardManager searchCurrentUserJoinBoard:self.boardModel
                                  successBlock:^(BOOL isJoin)
    {
        [WBHUD hideForView:self.view];
        if (isJoin) {
            [self.addBtn setTitle:@"已加入" forState:(UIControlStateNormal)];
        }else{
            self.addBtn.enabled = YES;
        }
        
        
    } failedBlock:^(NSString *message) {
        [WBHUD showErrorMessage:message toView:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBtnClick:(UIButton *)sender {
    
    [WBHUD showMessage:@"加加加!!!" toView:self.view];
    [WBBoardManager createBoardUserMapWithBoardModel:self.boardModel
                                        successBlock:^
    {
        [WBHUD showSuccessMessage:@"快去,`我的小白板`看看" toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failedBlock:^(NSString *message) {
        [WBHUD showErrorMessage:message toView:self.view];
    }];
    
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self rr_backAction:nil];
}


@end
