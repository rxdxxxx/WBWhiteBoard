//
//  WBHomePageController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/5.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBHomePageController.h"

@interface WBHomePageController ()

@end

@implementation WBHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rr_initTitleView:@"小白板"];
    [self rr_initNavRightBtnWithImageName:@"ico_schedule_edit" target:self action:@selector(didReceiveMemoryWarning)];
    [self rr_initNavLeftBtnWithImageName:@"ico_nav_history" target:self action:@selector(didReceiveMemoryWarning)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
