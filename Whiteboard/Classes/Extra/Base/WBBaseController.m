//
//  RRBaseController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBBaseController.h"

@interface WBBaseController ()


@end

@implementation WBBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor wb_navigationBarColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //统一设置导航栏的返回按钮，如要改变，在控制器内设置覆盖
    if (self.navigationController.viewControllers.count  > 1) {
        [self rr_initGoBackButton];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Life Cycle
#pragma mark -  UITableViewDelegate
#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame =[UIScreen mainScreen].bounds;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];

//        self.tableEmptyView.delegate = self;
//        _tableView.backgroundView = self.tableEmptyView;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        _tableView.delegate = (id<UITableViewDelegate>)self;
        _tableView.autoresizingMask = UIViewAutoresizingNone;
        _tableView.tableFooterView = [UIView new];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    return _tableView;
}

@end
