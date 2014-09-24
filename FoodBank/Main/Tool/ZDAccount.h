//
//  ZDAccount.h
//  06视图抽屉框架
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDAccount : NSObject

//city = "\U6d77\U6dc0";
//nickname = "Free Loop";
//"figureurl_qq_2" = "http://q.qlogo.cn/qqapp/222222/C1BDA631B14741AF8F98E41AB2F717E8/100";
//gender  = "\U7537"
/**
 *  昵称
 */
@property (nonatomic,copy) NSString *nickname;
/**
 *  城市
 */
@property (nonatomic,copy) NSString *city;
/**
 *  小图像（40 ＊ 40）
 */
@property (nonatomic,copy) NSString *figureurl_qq_1;
/**
 *  大图向（100 ＊ 100）
 */
@property (nonatomic,copy) NSString *figureurl_qq_2;
/**
 *  性别
 */
@property (nonatomic,copy) NSString *gender;



/**
 *  访问令牌
 */
@property (nonatomic, copy) NSString *access_tokenQQ;
/**
 *  访问令牌
 */
@property (nonatomic, copy) NSString *expirationDate;
/**
 *  访问令牌
 */
@property (nonatomic, copy) NSString *openId;



/**
 *  访问令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  多少秒之后过期
 */
@property (nonatomic, copy) NSNumber *expires_in;
/**
 *  提醒时间
 */
@property (nonatomic, copy) NSNumber *remind_in;
/**
 *  用户ID
 */
@property (nonatomic, copy) NSNumber *uid;

/**
 *  过期时间
 */
@property (nonatomic, strong) NSDate *expires_time;

/**
 *  根据字典创建模型
 *
 */
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
