//
//  WBMessageEditController.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBMessageEditController.h"

@interface WBMessageEditController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation WBMessageEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rr_initTitleView:@"书写板报"];
    [self rr_initNavRightBtnWithImageName:@"ico_iap_tick" target:self action:@selector(editComplete)];

    if (self.messageModel) {
        self.textView.text = self.messageModel.message;
    }
    [self.textView becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Life Cycle
#pragma mark -  UITableViewDelegate
#pragma mark -  CustomDelegate
#pragma mark -  Event Response

- (void)editComplete{
    
}

#pragma mark -  Private Methods
#pragma mark -  Public Methods
#pragma mark -  Getters and Setters

@end
