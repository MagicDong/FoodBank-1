//
//  ZDBabyTool.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-10.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class ZDBaby;
@interface ZDBabyTool : NSObject
singleton_interface(ZDBabyTool)
/**
 *  存储一个数据
 *
 *  @param account 需要存储的对象
 *
 *  @return 是否存储成功
 */
- (BOOL)saveAccount:(ZDBaby *)account;

/**
 *  获取一个存储账号的对象
 */
- (ZDBaby *)account;
/* 删除当前账号*/
- (BOOL)removeAccount;
@end
