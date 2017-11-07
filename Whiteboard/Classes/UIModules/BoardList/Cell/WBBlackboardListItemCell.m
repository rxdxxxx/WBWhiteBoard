//
//  WBBlackboardListItemCell.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBBlackboardListItemCell.h"

@interface WBBlackboardListItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *boardSelectImageView;
@property (weak, nonatomic) IBOutlet UILabel *boardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createNameLabel;

@end

@implementation WBBlackboardListItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(WBBoardModel *)cellModel{
    _cellModel = cellModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:cellModel.coverUrl] placeholderImage:kBoardHoldImage];
    
    self.boardNameLabel.text = cellModel.boardName;
    self.createNameLabel.text = cellModel.createUser.nickName;
    
    if([WBUserModel.currentUser.currentBlackboard.objectId isEqualToString:cellModel.objectId]){
        self.boardSelectImageView.hidden = NO;
    }else{
        self.boardSelectImageView.hidden = YES;
    }
    
}

@end
