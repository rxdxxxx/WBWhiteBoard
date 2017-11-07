//
//  WBHomePageCellModel.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBHomePageCellModel.h"

@implementation WBHomePageCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.changerName = @"有故事的列宁";
        self.timeString = @"2017-10-10 12:21:31";
        self.message = @"恭喜发财,大吉大利";
    }
    return self;
}

- (void)setMessage:(NSString *)message{
    _message = [message copy];
        
    _cellHeight = [_message lcg_sizeWithFont:[UIFont systemFontOfSize:21] maxW:kScreenWidth - 76].height + 130;
    
}

- (void)setDataModel:(WBMessageModel *)dataModel{
    _dataModel = dataModel;
    
    self.changerName = dataModel.updateUser.displayName;
    self.timeString = dataModel.updatedAt.rr_formatStrig;
    self.message = dataModel.content;
}

@end
