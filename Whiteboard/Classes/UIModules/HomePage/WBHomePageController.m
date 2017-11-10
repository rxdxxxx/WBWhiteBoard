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
#import "WBBoardListController.h"

@interface WBHomePageController ()
@property (nonatomic, strong) WBHomePageCellModel *dataModel;
@end

@implementation WBHomePageController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadTitleLabel];
    [WBNotificationCenter addObserver:self selector:@selector(reloadTitleLabel) name:kWBBoardManagerChangeUsingBoard object:nil];
    

    [self.view addSubview:self.tableView];
    

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}
- (void)viewDidLayoutSubviews{
    
    self.tableView.frame = self.view.bounds;
    self.tableView.height = self.tableView.height - 49;
}

#pragma mark -  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (self.dataModel) {
        self.tableEmptyView.hidden = YES;
        return 1;

    }else{
        self.tableEmptyView.hidden = NO;
        return 0;
    }
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
#pragma mark - WBTableEmptyViewDelegate
- (void)tableEmptyViewDidClickAction:(WBTableEmptyView *)emptyView{
    
    // 有板子,去发消息,
    if (WBUserModel.currentUser.currentBlackboard) {
        [self navRightBtnClick];
    }
    
    // 没板子,去选择板子
    else{
        
        WBBoardListController *vc = [WBBoardListController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

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
- (void)loadNewData{
    // 有板子,设置按钮的文字
    if (WBUserModel.currentUser.currentBlackboard) {
        [self.tableEmptyView resetActionBtnTitleWithString:@"发条信息去~"];
        
        if (self.rrRightBtn == nil) {
            [self rr_initNavRightBtnWithImageName:@"ico_schedule_edit" target:self action:@selector(navRightBtnClick)];
            [self rr_initNavLeftBtnWithImageName:@"ico_nav_history" target:self action:@selector(navLeftBtnClick)];
        }
    }else{
        [self.tableEmptyView resetActionBtnTitleWithString:@"选择板子去~"];
        
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = nil;
        
    }
    
    
    [WBMessageManager lastMessageOfCurrentBoardForSuccessBlock:^(WBMessageModel *model) {
        if (model) {
            self.dataModel = [WBHomePageCellModel new];
            self.dataModel.dataModel = model;
        }else{
            self.dataModel = nil;
        }
        
        [self.tableView reloadData];
        
    } failedBlock:^(NSString *message) {
        self.dataModel = nil;
        [WBHUD showMessage:message toView:self.view];
        [self.tableView reloadData];

    }];
}


- (void)reloadTitleLabel{
//    2017年11月10日16:15:29 暂时拿不到board的数据
//    WBUserModel *userModel = WBUserModel.currentUser;
//    NSString *boardName = userModel.currentBlackboard.boardName;
//    if (boardName.length) {
//        [self rr_initTitleView:boardName];
//    }else{
//        [self rr_initTitleView:@"小白板"];
//    }
    [self rr_initTitleView:@"小白板"];
}
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
