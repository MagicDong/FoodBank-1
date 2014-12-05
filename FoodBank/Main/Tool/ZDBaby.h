//
//  ZDBaby.h
//  FoodBank
//
//  Created by apple-jiexian on 14-10-10.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDBaby : NSObject
/**
 *  用户名
 */
@property (nonatomic,strong) NSString *userName;
/**
 *  密码
 */
@property (nonatomic,strong) NSString *password;
/**
 *  jsessionid
 */
@property (nonatomic,strong) NSString *jsessionid;
/**
 *  头像
 */
@property (nonatomic,strong) UIImage *userIcon;

/**
 *  个性签名
 */
@property (nonatomic,copy) NSString *signature;
/**
 *  昵称
 */
@property (nonatomic,copy) NSString *nickName;
/**
 *  性别  YES男   NO女
 */
@property (nonatomic,assign) BOOL sex;
/**
 *  城市
 */
@property (nonatomic,copy) NSString *city;
/**
 *  生日
 */
@property (nonatomic,copy) NSString *birthday;
/**
 *  民族
 */
@property (nonatomic,copy) NSString *nation;

@end
