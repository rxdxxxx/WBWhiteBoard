//
//  WBBoardListController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBBoardListController.h"
#import "WBBlackboardListItemCell.h"
#import "WBBoardAddController.h"
#import "WBBoardDetailController.h"

@interface WBBoardListController ()<UICollectionViewDelegate,UICollectionViewDataSource,WBTableEmptyViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation WBBoardListController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    
    [self loadData];
    [WBNotificationCenter addObserver:self selector:@selector(loadData) name:kWBBoardManagerDelete object:nil];
    [WBNotificationCenter addObserver:self selector:@selector(loadData) name:kWBBoardManagerUpdate object:nil];
    [WBNotificationCenter addObserver:self selector:@selector(loadData) name:kWBBoardManagerCreate object:nil];
    [WBNotificationCenter addObserver:self selector:@selector(loadData) name:kWBBoardManagerChangeUsingBoard object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark -  UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger dataCount = self.dataArray.count;
    
    self.tableEmptyView.hidden = (dataCount != 0);
    
    return dataCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WBBlackboardListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WBBlackboardListItemCell.class) forIndexPath:indexPath];
    cell.cellModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WBBoardModel *selectBoard = self.dataArray[indexPath.row];
    WBBoardDetailController *vc = [WBBoardDetailController new];
    vc.boardModel = selectBoard;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -  CustomDelegate
#pragma mark - WBTableEmptyViewDelegate
- (void)tableEmptyViewDidClickAction:(WBTableEmptyView *)emptyView{
    [self navRightBtnClick];
}

#pragma mark -  Event Response
- (void)navRightBtnClick{
    WBBoardAddController *vc = [WBBoardAddController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -  Private Methods
- (void)loadData{
    [WBHUD showMessage:@"" toView:self.view];
    [WBBoardManager boardListForSuccessBlock:^(NSArray<WBBoardModel *> *boardList) {
        self.dataArray = [NSMutableArray arrayWithArray:boardList];
        [self.collectionView reloadData];
        [WBHUD hideForView:self.view];
    } failedBlock:^(NSString *message) {
        [WBHUD showErrorMessage:message toView:self.view];
    }];
}


- (void)setupUI{
    [self rr_initTitleView:@"我的小白板"];
    [self rr_initNavRightBtnWithImageName:@"ico_nav_add" target:self action:@selector(navRightBtnClick)];
    
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize =  CGSizeMake(kScreenWidth * 0.5, 230);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WBBlackboardListItemCell" bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass(WBBlackboardListItemCell.class)];
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundView = self.tableEmptyView;
    self.tableEmptyView.delegate = self;
    [self.collectionView reloadData];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.tableEmptyView resetActionBtnTitleWithString:@"加块白板去~"];
    
    [self.view addSubview:self.collectionView];
}
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
@end
