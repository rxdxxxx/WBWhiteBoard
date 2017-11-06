//
//  WBBoardListController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBBoardListController.h"
#import "WBBlackboardListItemCell.h"

@interface WBBoardListController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation WBBoardListController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rr_initTitleView:@"我的小黑板"];
    [self rr_initNavRightBtnWithImageName:@"ico_nav_add" target:self action:@selector(didReceiveMemoryWarning)];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WBBlackboardListItemCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(WBBlackboardListItemCell.class)];
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize =  CGSizeMake(kScreenWidth * 0.5, 244);
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WBBlackboardListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(WBBlackboardListItemCell.class) forIndexPath:indexPath];
    return cell;
}

#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
