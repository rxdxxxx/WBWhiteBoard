//
//  WBBoardManager.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBoardManager : NSObject

/**
 创建新白板

 @param name 名称
 @param image 封面图片
 */
+ (void)createNewBoardWithName:(NSString *)name
                         image:(UIImage *)image
                  successBlock:(void(^)(void))successBlock
                   failedBlock:(void(^)(NSString *message))failedBlock;


/**
 获取当前用户的所有板子列表
 */
+ (void)boardListForSuccessBlock:(void (^)(NSArray<WBBoardModel *> *boardList))successBlock
                     failedBlock:(void (^)(NSString *message))failedBlock;



/**
 改变当前使用的白板

 @param board 所选中的板子
 */
+ (void)changeUsingBoard:(WBBoardModel *)board
            successBlock:(void(^)(void))successBlock
             failedBlock:(void(^)(NSString *message))failedBlock;

@end
