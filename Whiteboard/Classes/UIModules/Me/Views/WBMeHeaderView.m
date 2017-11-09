//
//  WBMeHeaderView.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBMeHeaderView.h"

@interface WBMeHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *userInfoContentView;

@end

@implementation WBMeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.userInfoContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapUserInfoView)]];
}

- (void)didTapUserInfoView{
    if (self.tapCallback) {
        self.tapCallback();
    }
}

@end
