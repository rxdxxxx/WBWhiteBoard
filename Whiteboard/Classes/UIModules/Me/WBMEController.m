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

@interface WBMEController ()

@end

@implementation WBMEController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rr_initTitleView:@"小白板"];
    
    self.tableView.tableHeaderView = [WBMeHeaderView lcg_viewFromXib];
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
    WBMeMoreCell *cell = [WBMeMoreCell cellWithTableView:tableView];
    return cell;
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
