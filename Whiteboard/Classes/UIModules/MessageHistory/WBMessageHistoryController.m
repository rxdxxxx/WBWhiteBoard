//
//  WBMessageHistoryController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBMessageHistoryController.h"
#import "WBHomePageCell.h"
#import "WBMessageDetailController.h"

@interface WBMessageHistoryController ()
@property (nonatomic, strong) NSMutableArray<WBHomePageCellModel*> *dataArray;
@end

@implementation WBMessageHistoryController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rr_initTitleView:@"历史记录"];
    [self rr_initGoBackButton];
    
    WBHomePageCellModel *cellModel = [WBHomePageCellModel new];
    cellModel.message = @"哈哈哈哈啊哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈";
    [self.dataArray addObject:cellModel];
    [self.dataArray addObject:[WBHomePageCellModel new]];
    [self.dataArray addObject:[WBHomePageCellModel new]];
    [self.dataArray addObject:[WBHomePageCellModel new]];
    [self.dataArray addObject:[WBHomePageCellModel new]];

    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}
- (void)rr_backAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBHomePageCell *cell = [WBHomePageCell cellWithTableView:tableView];
    cell.cellModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataArray[indexPath.row].cellHeight > 180 ? 180 : self.dataArray[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WBMessageDetailController *vc = [WBMessageDetailController new];
    vc.dataModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
@end
