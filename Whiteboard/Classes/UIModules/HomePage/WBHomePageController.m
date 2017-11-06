//
//  WBHomePageController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBHomePageController.h"
#import "WBHomePageCell.h"

@interface WBHomePageController ()
@property (nonatomic, strong) WBHomePageCellModel *dataModel;
@end

@implementation WBHomePageController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rr_initTitleView:@"小白板"];
    [self rr_initNavRightBtnWithImageName:@"ico_schedule_edit" target:self action:@selector(didReceiveMemoryWarning)];
    [self rr_initNavLeftBtnWithImageName:@"ico_nav_history" target:self action:@selector(didReceiveMemoryWarning)];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataModel.cellHeight;
}


#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
