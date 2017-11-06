//
//  WBHomePageCell.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBHomePageCell.h"
@interface WBHomePageCell ()

@property (weak, nonatomic) IBOutlet UILabel *changerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;


@end


@implementation WBHomePageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"WBHomePageCell";
    WBHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        UINib * nib = [UINib nibWithNibName:@"WBHomePageCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ID];
        cell = [[nib instantiateWithOwner:self options:nil] lastObject];
        
        
        //cell = [[XMSettingItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark -  Life Cycle
#pragma mark -  CustomDelegate
#pragma mark -  Event Response
#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters
- (void)setCellModel:(WBHomePageCellModel *)cellModel{
    _cellModel = cellModel;
    
    self.changerLabel.text = cellModel.changerName;
    self.timeLabel.text = cellModel.timeString;
    self.messageLabel.text = cellModel.message;
    
    
}

@end
