//
//  WBMessageManager.h
//  Whiteboard
//
//  Created by RedRain on 2017/11/7.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBMessageManager : NSObject


/**
 为当前用户所在板子创建一条新的消息

 @param content 消息内容
 */
+ (void)createMessageWithContent:(NSString *)content
                    successBlock:(void(^)(void))successBlock
                     failedBlock:(void(^)(NSString *message))failedBlock;



/**
 拉取当前用户,所在板子的最新一条消息
 */
+ (void)lastMessageOfCurrentBoardForSuccessBlock:(void (^)(WBMessageModel *model))successBlock
                                     failedBlock:(void (^)(NSString *message))failedBlock;



/**
 分页拉取,消息内容展示历史记录

 @param message 如果传nil, 从当前时间开始搜索
 @param limit 每一页多少个数据项
 */
+ (void)messageListStartIndexMessage:(WBMessageModel *)message
                               limit:(NSInteger)limit
                        successBlock:(void (^)(NSArray<WBMessageModel *> *dataArray))successBlock
                         failedBlock:(void (^)(NSString *message))failedBlock;



/**
 编辑一条已经发布的消息

 @param aNewString 新内容
 */
+ (void)editMessageContentWithString:(NSString *)aNewString
                      changedMessage:(WBMessageModel *)messageModel
                        successBlock:(void (^)(void))successBlock
                         failedBlock:(void (^)(NSString *message))failedBlock;


@end
