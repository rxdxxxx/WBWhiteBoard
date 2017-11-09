//
//  WBMEController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBMEController.h"
#import "WBMeMoreCell.h"
#import "WBMeHeaderView.h"
#import "WBBoardListController.h"
#import "WBQRScanViewController.h"
#import "WBQRScanResultController.h"

@interface WBMEController ()<QRScanDelegate>
@property (nonatomic, strong) WBMeHeaderView *headerView;
@end

@implementation WBMEController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rr_initTitleView:@"小白板"];
    
    self.headerView = [WBMeHeaderView lcg_viewFromXib];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    WBUserModel *userModel = [WBUserModel currentUser];
    self.headerView.userNickLabel.text = userModel.displayName;
    [self.headerView.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatarUrl] placeholderImage:kUserHeaderHoldImage];
}

- (void)viewDidLayoutSubviews{
    
    self.tableView.frame = self.view.bounds;
    self.tableView.height = self.tableView.height - 49;
}

#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBMeMoreCell *cell = [WBMeMoreCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.cellNameLabel.text = @"我的小白板";
    }else{
        cell.cellNameLabel.text = @"发现小白板";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {

        WBBoardListController *vc = [WBBoardListController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{

        WBQRScanViewController *vc = [WBQRScanViewController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark -  CustomDelegate
#pragma mark - QRScanDelegate
- (void)qrScanResult:(NSString *)result viewController:(WBQRScanViewController *)qrScanVC{
    [qrScanVC.navigationController popViewControllerAnimated:YES];
    
    if ([result hasPrefix:kQRCodePrefix]) {
        
        NSArray *objectIDArray = [result componentsSeparatedByString:kQRCodePrefix];
        
        [WBHUD showMessage:@"什么好东西~" toView:self.view];
        [WBBoardManager boardDetailWithObjectID:objectIDArray.lastObject successBlock:^(WBBoardModel *boardModel) {
            WBQRScanResultController *vc = [WBQRScanResultController new];
            vc.boardModel = boardModel;
            [self.navigationController pushViewController:vc animated:YES];
            [WBHUD hideForView:self.view];
        } failedBlock:^(NSString *message) {
            [WBHUD showErrorMessage:message toView:self.view];
        }];
    }else{
        [WBHUD showErrorMessage:@"这个不是我菜,换一个试试." toView:self.view];
    }
    
}

#pragma mark -  Event Response
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
