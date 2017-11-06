//
//  WBMeMoreCell.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBMeMoreCell.h"

@implementation WBMeMoreCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"WBMeMoreCell";
    WBMeMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        UINib * nib = [UINib nibWithNibName:@"WBMeMoreCell" bundle:nil];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
