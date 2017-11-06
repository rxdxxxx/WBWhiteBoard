//
//  WBHomePageController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBHomePageController.h"
#import "WBHomePageCell.h"
#import "WBMessageEditController.h"
#import "WBNavigationController.h"
#import "WBMessageHistoryController.h"

@interface WBHomePageController ()
@property (nonatomic, strong) WBHomePageCellModel *dataModel;
@end

@implementation WBHomePageController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rr_initTitleView:@"小白板"];
    [self rr_initNavRightBtnWithImageName:@"ico_schedule_edit" target:self action:@selector(navRightBtnClick)];
    [self rr_initNavLeftBtnWithImageName:@"ico_nav_history" target:self action:@selector(navLeftBtnClick)];
    
    self.dataModel = [WBHomePageCellModel new];
    
    [self.view addSubview:self.tableView];

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
    WBHomePageCell *cell = [WBHomePageCell cellWithTableView:tableView];
    cell.cellModel = self.dataModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WBMessageEditController *vc = [WBMessageEditController new];
    vc.messageModel = self.dataModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataModel.cellHeight;
}


#pragma mark -  CustomDelegate
#pragma mark -  Event Response
- (void)navRightBtnClick{
    WBMessageEditController *vc = [WBMessageEditController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navLeftBtnClick{
    
    UINavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:[WBMessageHistoryController new]];
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
