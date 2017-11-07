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

@interface WBBoardListController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation WBBoardListController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
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
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WBBlackboardListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WBBlackboardListItemCell.class) forIndexPath:indexPath];
    cell.cellModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WBBoardModel *selectBoard = self.dataArray[indexPath.row];
    if(![WBUserModel.currentUser.currentBlackboard.objectId isEqualToString:selectBoard.objectId]){
        UIAlertController *VC = [UIAlertController alertControllerWithTitle:@"是否确认切换?"
                                                                    message:nil
                                                             preferredStyle:(UIAlertControllerStyleAlert)];
        [VC addAction: [UIAlertAction actionWithTitle:@"确认"
                                                style:(UIAlertActionStyleDefault)
                                              handler:^(UIAlertAction * _Nonnull action)
                        {
                            
                            [WBHUD showMessage:@"切换中.." toView:self.view];
                            [WBBoardManager changeUsingBoard:selectBoard successBlock:^{
                                [WBHUD showSuccessMessage:@"切换成功" toView:self.view];
                                [self loadData];

                            } failedBlock:^(NSString *message) {
                                [WBHUD showErrorMessage:message toView:self.view];
                            }];
                        }]];
        
        [VC addAction: [UIAlertAction actionWithTitle:@"取消"
                                                style:(UIAlertActionStyleCancel)
                                              handler:nil]];
        
        [self presentViewController:VC animated:YES completion:nil];
        
    }
}


#pragma mark -  CustomDelegate
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
    [self.collectionView reloadData];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
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
