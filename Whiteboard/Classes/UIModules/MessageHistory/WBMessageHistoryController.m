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
#import <MJRefresh/MJRefreshAutoNormalFooter.h>

@interface WBMessageHistoryController ()<WBTableEmptyViewDelegate>
@property (nonatomic, strong) NSMutableArray<WBHomePageCellModel*> *dataArray;



@end

@implementation WBMessageHistoryController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];

    [self loadMoreData];
    
}

- (void)rr_backAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount = self.dataArray.count;
    
    self.tableEmptyView.hidden = (dataCount != 0);
    self.tableView.mj_footer.hidden = (dataCount == 0);
    
    return dataCount;
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
#pragma mark - WBTableEmptyViewDelegate
- (void)tableEmptyViewDidClickAction:(WBTableEmptyView *)emptyView{
    [self rr_backAction:nil];
}

#pragma mark -  Event Response
- (void)loadMoreData{
    WBHomePageCellModel *cellModel = self.dataArray.lastObject;
    
    [WBMessageManager messageListStartIndexMessage:cellModel.dataModel
                                             limit:10
                                      successBlock:^(NSArray<WBMessageModel *> *dataArray)
    {
        for (WBMessageModel *message in dataArray) {
            WBHomePageCellModel *cellModel = [WBHomePageCellModel new];
            cellModel.dataModel = message;
            [self.dataArray addObject:cellModel];
        }
        
        if (dataArray.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView reloadData];
    } failedBlock:^(NSString *message) {
        [self.tableView.mj_footer endRefreshing];
        [WBHUD showErrorMessage:message toView:self.view];
    }];
}
#pragma mark -  Private Methods
- (void)setupUI{
    
    [self rr_initTitleView:@"历史记录"];
    [self rr_initGoBackButton];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self.tableEmptyView resetActionBtnTitleWithString:@"发布消息去~"];
}
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters
- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
@end
