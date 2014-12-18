//
//  ZDNetwork.h
//  FoodBank
//
//  Created by apple-jiexian on 14/12/1.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RspState.h"
#import "AFNetworking.h"

@interface ZDNetwork : NSObject

/* 1、注册用户 */
+ (void)registerWithPhone:(NSString *)phone Password:(NSString *) password  Callback:(void (^)(RspState *))callback;

/* 2、获取手机验证码 */
+ (void)getCheckCode:(NSString *)phone Type:(int)type
            Callback:(void (^)(RspState *))callback;

/* 3、登录 */
+ (void)LoginWithPhone:(NSString *)phone Password:(NSString *) password
              Callback:(void (^)(RspState *,NSString *))callback;

/* 4、重置密码 */
+ (void)resetAccount:(NSString *)phone Checkcode:(NSString*)checkcode  NewPassword:(NSString *) newPassword
            Callback:(void (^)(RspState *))callback;

/* 5、获取父母过敏食材列表 */
+ (void)getGuoMinCallback:(void(^)(RspState *,NSArray *))callback;

/* 6、提交宝宝基本信息 */
+ (void)postBabyInfoWithBirthday:(NSString *)birthday nation:(NSString *)nation allergy:(NSString *)allergy CallBack:(void (^)(RspState *))callback;

/* 7、获取初始化宝宝个人四库列表 */
+ (void)getSiKuInfoCallback:(void(^)(RspState *,NSArray *))callback;

/* 8、提交宝宝勾选个人四库信息 */
+ (void)postBabySiKuInfoWithMids:(NSArray *)mids CallBack:(void (^)(RspState *))callBack;

/* 9、获取今日尝试新食材信息 */
+ (void)getTodayTryInfoCallback:(void(^)(RspState *,NSArray *))callback;

/* 10、获取可选择的今日尝试新食材列表 */
+ (void)getEditTryFoodCallback:(void (^)(RspState *,NSArray *))callback;

/* 11、提交今日尝试新食材 */
+ (void)postToDayTryFoodSta:(NSString *)sta mid:(NSString *)mid cycle:(NSString *)cycle grams:(NSString *)grams Callback:(void (^)(RspState *))callback;

/* 12、获取尝试记录页信息 */
+ (void)getTryRecordInfoCallback:(void (^)(RspState *,NSArray *))callback;

/* 13、提交尝试结果 */
+ (void)postTryResultTryState:(NSString *)tryState CallBack:(void (^)(RspState *))callback;

/* 14、获取周总结 */
+ (void)getZhouCallback:(void (^)(RspState *))callback;

/* 15、获取月总结 */
+ (void)getYueCallback:(void (^)(RspState *))callback;

/* 16、获取个人四库信息列表 */
+ (void)getSikuInfoWeiChangshiCallback:(void (^)(RspState *))callback;

/* 17、获取正在尝试食材 */
+ (void)getTryingFoodCallback:(void (^)(RspState *))callback;



@end
