//
//  QRImageViewController.m
//  Life
//
//  Created by RedRain on 17/3/8.
//  Copyright © 2017年 efetion. All rights reserved.
//

#import "QRImageViewController.h"

@interface QRImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation QRImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageView.image = self.qrImage;
    [self rr_initGoBackButton];
    [self rr_initTitleView:@"板子的码"];
    
}

- (void)rr_backAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];

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
