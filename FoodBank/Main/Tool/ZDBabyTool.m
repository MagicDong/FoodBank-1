//
//  ZDBabyTool.m
//  FoodBank
//
//  Created by apple-jiexian on 14-10-10.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDBabyTool.h"

@implementation ZDBabyTool
singleton_implementation(ZDBabyTool)
/**
 *  存储一个数据
 *
 *  @param account 需要存储的对象
 *
 *  @return 是否存储成功
 */
- (BOOL)saveAccount:(ZDBaby *)account
{
    // 获取Doc目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接完整路径 将数据保存到指定文件中
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"baby.data"];
    // 存储指定account到指定路径中dataPath
    return [NSKeyedArchiver archiveRootObject:account toFile:dataPath];
}


/**
 *  从Doc路径中取出指定保存用户信息的文件
 *
 *  @return 返回一个从Doc中取出的文件
 */
- (ZDBaby *)account
{
    // 获取Doc目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接完整路径 将从此文件中取数据
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"baby.data"];
    // 读取指定路径的文件
    ZDBaby *account = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    // 判断当前时间和获取的用户信息中的过期时间比较是否过期
    return account;
}

- (BOOL)removeAccount
{
    // 获取Doc目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接完整路径 将从此文件中取数据
    NSString *dataPath = [docPath stringByAppendingPathComponent:@"baby.data"];
    // 读取指定路径的文件
    NSFileManager *manager =  [NSFileManager defaultManager];
    BOOL success = [manager removeItemAtPath:dataPath error:nil];
    
    return success;
}
@end
