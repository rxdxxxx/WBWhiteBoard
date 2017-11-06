//
//  WBHomePageCellModel.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBHomePageCellModel : NSObject

@property (nonatomic, copy) NSString *changerName;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, assign) CGFloat cellHeight;

@end
