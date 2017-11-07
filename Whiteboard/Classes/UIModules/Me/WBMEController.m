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

@interface WBMEController ()
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBMeMoreCell *cell = [WBMeMoreCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WBBoardListController *vc = [WBBoardListController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
