//
//  WBBoardManager.m
//  Whiteboard
//
//  Created by RedRain on 2017/11/6.
//  Copyright © 2017年 RedRain. All rights reserved.
//

#import "WBBoardManager.h"
#import "WBServiceConst.h"

@implementation WBBoardManager
+ (void)createNewBoardWithName:(NSString *)name
                         image:(UIImage *)image
                  successBlock:(void (^)(void))successBlock
                   failedBlock:(void (^)(NSString *message))failedBlock{
    
    AVFile *file = [AVFile fileWithData:UIImagePNGRepresentation(image)];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // 成功或失败处理...
        if (succeeded) {
            [self createBoardAfterUploadFile:file boardName:name successBlock:successBlock failedBlock:failedBlock];
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
    }];
    
}


/**
 文件上传成功后,创建白板对象

 @param file 文件对象
 @param name 板子名称
 */
+ (void)createBoardAfterUploadFile:(AVFile *)file
                         boardName:(NSString *)name
                      successBlock:(void (^)(void))successBlock
                       failedBlock:(void (^)(NSString *message))failedBlock{
    
    AVObject *blackboardNew = [[AVObject alloc] initWithClassName:t_Blackboard];// 构建对象
    [blackboardNew setObject:AVUser.currentUser forKey:@"createUser"];// 设置创建者
    [blackboardNew setObject:[name lcg_removeWhitespaceAndNewlineCharacterSet] forKey:@"boardName"];// 设置板子的名称
    [blackboardNew setObject:file.url forKey:@"coverUrl"];// 板子的封面
    [blackboardNew saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self createBoardUserMap:blackboardNew successBlock:successBlock failedBlock:failedBlock];
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
            
        }
    }];// 保存到云端
}


/**
 板子创建成功,创建板子和用户的关系表

 @param boardObj 板子对象
 */
+ (void)createBoardUserMap:(AVObject *)boardObj
              successBlock:(void (^)(void))successBlock
               failedBlock:(void (^)(NSString *message))failedBlock{
    
    
    if (boardObj == nil || boardObj.objectId.length == 0) {
        if (failedBlock) {
            failedBlock(@"发生了什么错误...");
        }
        return;
    }
    
    
    AVObject *blackboardMapUser= [[AVObject alloc] initWithClassName:t_BlackboardUserMap];// 选课表对象
    // 设置关联
    [blackboardMapUser setObject:AVUser.currentUser forKey:k_User];
    [blackboardMapUser setObject:boardObj forKey:k_Blackboard];
    
    [blackboardMapUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (succeeded) {
            if (successBlock) {
                successBlock();
            }
        }else{

            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
        
    }];
}


#pragma mark - 拉取当前用户的白板列表
+ (void)boardListForSuccessBlock:(void (^)(NSArray<WBBoardModel *> *boardList))successBlock
                     failedBlock:(void (^)(NSString *message))failedBlock{
    
    AVQuery *query = [AVQuery queryWithClassName:t_BlackboardUserMap];
    
    [query whereKey:k_User equalTo:AVUser.currentUser];
    
    [query includeKey:k_User];
    [query includeKey:k_Blackboard];
    [query includeKey:@"blackboard.createUser"];

    [query addDescendingOrder:k_CreatedAt];
    [query findObjectsInBackgroundWithBlock:^(NSArray<WBBoardMapUserModel *> * _Nullable objects, NSError * _Nullable error) {
        NSMutableArray *boardList = [NSMutableArray new];

        for (WBBoardMapUserModel *map in objects) {
            [boardList addObject:map.blackboard];
        }
        if (error == nil) {
            if (successBlock) {
                successBlock(boardList);
            }
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
    }];
    
}

#pragma mark - 改变当前使用的白板
+ (void)changeUsingBoard:(WBBoardModel *)board
            successBlock:(void (^)(void))successBlock
             failedBlock:(void (^)(NSString *))failedBlock{
    
    if (board == nil || board.objectId == nil || board.objectId.length == 0) {
        if (failedBlock) {
            failedBlock(@"这个板子坏掉了,选其他的白板吧~");
        }
        return;
    }
    
    WBUserModel *userModel = WBUserModel.currentUser;
    [userModel setObject:board forKey:@"currentBlackboard"];
    [userModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            if (successBlock) {
                successBlock();
            }
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
    }];// 保存到云端
    
}

#pragma mark - 根据objectID,查询板子的具体信息
+ (void)boardDetailWithObjectID:(NSString *)objectID
                   successBlock:(void (^)(WBBoardModel *boardModel))successBlock
                    failedBlock:(void (^)(NSString *message))failedBlock{
    
    if (objectID == nil || objectID.length == 0) {
        if (failedBlock) {
            failedBlock(@"这个板子坏掉了,选其他的白板吧~");
        }
        return;
    }
    
    AVQuery *query = [AVQuery queryWithClassName:t_Blackboard];
    
    [query whereKey:k_ObjectId equalTo:objectID];
    [query includeKey:k_CreateUser];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<WBBoardModel *> * _Nullable objects, NSError * _Nullable error) {
       
        if (error == nil) {
            if (successBlock) {
                successBlock(objects.firstObject);
            }
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
    }];
}

#pragma mark - 查询某个用户是否已经加入了某个板子
+ (void)searchCurrentUserJoinBoard:(WBBoardModel *)boardModel
                      successBlock:(void (^)(BOOL isJoin))successBlock
                       failedBlock:(void (^)(NSString *message))failedBlock{
    
    AVQuery *query = [AVQuery queryWithClassName:t_BlackboardUserMap];
    
    [query whereKey:k_User equalTo:AVUser.currentUser];
    [query whereKey:k_Blackboard equalTo:boardModel];
    [query findObjectsInBackgroundWithBlock:^(NSArray<WBBoardMapUserModel *> * _Nullable objects, NSError * _Nullable error) {

        if (error == nil) {
            if (successBlock) {
                successBlock(objects.count > 0);
            }
        }else{
            if (failedBlock) {
                failedBlock(error.localizedDescription);
            }
        }
    }];
}

#pragma mark - 设置通过二维码加入板子
/**
 板子创建成功,创建板子和用户的关系表
 
 @param boardObj 板子对象
 */
+ (void)createBoardUserMapWithBoardModel:(WBBoardModel *)boardObj
                            successBlock:(void (^)(void))successBlock
                             failedBlock:(void (^)(NSString *message))failedBlock{
    
    
    [self createBoardUserMap:boardObj successBlock:successBlock failedBlock:failedBlock];
}
@end
