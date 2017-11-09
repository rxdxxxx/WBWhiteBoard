//
//  WBPersonDetailController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/9.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBPersonDetailController.h"
#import "WBChangeHeaderController.h"
#import "WBChangeNickNameController.h"

@interface WBPersonDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation WBPersonDetailController
#pragma mark -  Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rr_initTitleView:@"个人信息"];
    WBUserModel *userModel = [WBUserModel currentUser];
    self.userNameLabel.text = userModel.displayName;
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatarUrl] placeholderImage:kUserHeaderHoldImage];
    
    [WBNotificationCenter addObserver:self selector:@selector(userHeaderChangeNotification) name:kNotificationUserChangeHeaderImage object:nil];
    [WBNotificationCenter addObserver:self selector:@selector(userNameChangeNotification) name:kNotificationUserChangeUserName object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  UITableViewDelegate
#pragma mark -  CustomDelegate
#pragma mark -  Event Response
- (void)userNameChangeNotification{
    
    WBUserModel *userModel = [WBUserModel currentUser];
    self.userNameLabel.text = userModel.displayName;
}
-(void)userHeaderChangeNotification{
    
    WBUserModel *userModel = [WBUserModel currentUser];
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatarUrl] placeholderImage:kUserHeaderHoldImage];
}

- (IBAction)tapUserHeaderViewCallback:(id)sender {
    WBChangeHeaderController *vc = [WBChangeHeaderController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)tapUserNameCallBack:(id)sender {
    
    WBChangeNickNameController *vc = [WBChangeNickNameController new];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
