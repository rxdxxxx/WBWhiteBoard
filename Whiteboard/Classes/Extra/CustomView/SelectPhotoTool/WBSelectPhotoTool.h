//
//  OPSelectPhotoTool.h
//  LCGOptimusPrime
//
//  Created by RedRain on 2017/8/1.
//  Copyright © 2017年 erics. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBSelectPhotoTool;

@protocol WBSelectPhotoToolDelegate <NSObject>

- (void)tool:(WBSelectPhotoTool *)tool didSelectImage:(UIImage *)image;

@end

@interface WBSelectPhotoTool : NSObject

@property (nonatomic, assign) NSUInteger tag;


@property (nonatomic, weak) id<WBSelectPhotoToolDelegate> delegate;


/**
 在showController.view中弹出 alertSheet
 */
- (void)showSheetInController:(UIViewController *)showController;

@end
