//
//  ZDNetwork.m
//  FoodBank
//
//  Created by apple-jiexian on 14/12/1.
//  Copyright (c) 2014年 Dong. All rights reserved.
//

#import "ZDNetwork.h"
#import "AFNetworking.h"
#import "RspState.h"
#import <CommonCrypto/CommonDigest.h>
//#import <SMS_SDK/SMS_SDK.h>
#import "MJExtension.h"
#import "ZDFoodCategory.h"
#import "ZDNewFood.h"
#import "ZDTryRecord.h"
#import "ZDZhouZongJie.h"
#import "ZDYueZongJie.h"
#import "ZDChooseFood.h"
#import "ZDBabyTool.h"
#import "ZDBaby.h"

#define kBaseURL @"http://192.168.1.250/mobile"
#define kTimeout  10

#define kRequestPath @"bqfjapp.aspx"
#define kImagePath @"?method=getImage&imageName="

@interface ZDNetwork()

    
+(void) _netRspProcess:(RspState *)rsp;
    
+(void) _operationLog:(AFHTTPRequestOperation *)operation;

@end

@implementation ZDNetwork

//1 注册新会员
+ (void)registerWithPhone:(NSString *)phone Password:(NSString *) password  Callback:(void (^)(RspState *))callback
{
    NSData *data=[password dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    
    unsigned char result[16];
    
    CC_MD5([data bytes],(unsigned int)data.length,result);
    
    NSString *md5Password = [NSString stringWithFormat:
                             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
//    /auth/getChkCode.do
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBaseURL, @"/auth/registerMember.do"];
    
    NSDictionary *para =@{
                          @"username":phone,
                          @"checkCode":@"",
                          @"password":md5Password
                          };
//    username=123123111&checkCode=&password=123123111
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.timeoutInterval = kTimeout;
    [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self _operationLog:operation];
        
        NSDictionary *dict = responseObject;
        RspState *rsp = [[RspState alloc]initWithDict:dict];
        callback(rsp);
        
        //  if success, save user name and password here ???, or UI do this
        if(rsp.rspCode==0)
        {
//            LoginAccount *account=[[LoginAccount alloc]initWithPhone:phone Md5Password:md5Password];
//            [LoginAccountTool sharedLoginAccountTool].currentAccount=account;
//            [LoginAccountTool sharedLoginAccountTool].loginState=NO; //登录成功后再设为yes
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        RspState *rsp = [RspState rspStateNetError];
        callback(rsp);
    }];
}

//2 获取手机验证码
+ (void)getCheckCode:(NSString *)phone  Callback:(void (^)(RspState *))callback
{
//    [SMS_SDK getVerifyCodeByPhoneNumber:phone AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
//        
//    }];
    
}

//3 登录
+ (void)LoginWithPhone:(NSString *)phone Password:(NSString *) password
              Callback:(void (^)(RspState *,NSString *))callback
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBaseURL, @"/auth/login.do"];
//    /auth/login.do
    NSData *data=[password dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    
    unsigned char result[16];
    
    CC_MD5([data bytes],(unsigned int)data.length,result);
    
    NSString *md5Password = [NSString stringWithFormat:
                             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]];
    
    NSDictionary *para =@{@"loginName":phone,
                          @"password":md5Password
                          };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = kTimeout;
    [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self _operationLog:operation];
        
        NSDictionary *rspDict = responseObject;
        RspState *rsp = [[RspState alloc]initWithDict:rspDict];
        NSString *str = rspDict[@"sessionid"];
//        ZDLog(@"111111-%@",str);
        if(rsp.rspCode == 0)
        {
            str = rspDict[ @"sessionid"];
//            LoginAccount *account=[[LoginAccount alloc]initWithPhone:phone Md5Password:md5Password];
//            [LoginAccountTool sharedLoginAccountTool].currentAccount=account;
//            [LoginAccountTool sharedLoginAccountTool].loginState=YES;
        }
        
        
        callback(rsp,str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        RspState *rsp = [RspState rspStateNetError];
        callback(rsp,nil);
    }];
}
/* 4、重置密码 */
+ (void)resetAccount:(NSString *)phone Checkcode:(NSString*)checkcode  NewPassword:(NSString *) newPassword
            Callback:(void (^)(RspState *))callback
{
    
}

/* 5、获取父母过敏食材列表 */
+ (void)getGuoMinCallback:(void(^)(RspState *,NSArray *))callback
{
//    /mobile/getAllMaterial.do;jsessionid=
    
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getAllMaterial.do;jsessionid=%@", kBaseURL, kRequestPath];
        
        NSDictionary *para =@{@"mnames=":@""};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager GET:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            //        {"foodGenre":"谷类","foodGenreList":[["1","面粉","面粉","谷类"],["8","婴幼儿面","面粉","谷类"]
            NSMutableArray *foodGenreArray = nil;
            if(rsp.rspCode == 0)
            {
                //            "foodGenre":"谷类","foodGenreList"
                NSArray *rspList = rspDict[@"dataList"];
                foodGenreArray = [NSMutableArray array];
                for(NSDictionary *foodGenre in rspList)
                {
                    ZDFoodCategory *foodCategory = [ZDFoodCategory initWithDict:foodGenre];
                    [foodGenreArray addObject:foodCategory];
                }
            }
            
//            [self _netRspProcess:rsp];
            callback(rsp,foodGenreArray);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self _operationLog:operation];
            
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp,nil);
        }];
        
    }
}

/* 6、提交宝宝基本信息 */
+ (void)postBabyInfoWithBirthday:(NSString *)birthday nation:(NSString *)nation allergy:(NSString *)allergy CallBack:(void (^)(RspState *))callback
{
//birthday=2011/05/05&nation=1&allergy=1,2,3
    ZDBabyTool *babyTool = [ZDBabyTool sharedZDBabyTool];
    ZDBaby *baby = [babyTool account];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/postBabyInfo.do;jsessionid=%@", kBaseURL,baby.jsessionid];
    
    NSString *strUrl = [birthday stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
//    NSLog(@"%@",strUrl);
    NSDictionary *para =@{@"birthday":strUrl,
                          @"nation":nation,
                          @"allergy":allergy   
                          };
//    NSLog(@"%@,,%@,,,%@",birthday,nation,allergy);
    //  1汉族   3  回族    11 满族    0其他
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = kTimeout;
    [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self _operationLog:operation];
        NSDictionary *rspDict = responseObject;
        RspState *rsp = [[RspState alloc]initWithDict:rspDict];
        if(rsp.rspCode == 0)
        {
            
        }
        callback(rsp);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self _operationLog:operation];
        RspState *rsp = [RspState rspStateNetError];
        callback(rsp);
        
    }];
}

/* 7、获取四库未尝试库 */
+ (void)getSiKuInfoCallback:(void(^)(RspState *,NSArray *))callback
{
//    /mobile/getUserTryingMaterial2.do;jsessionid=
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getUserTryingMaterial2.do;jsessionid=%@", kBaseURL, jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        
//        manager.responseSerializer = @"text/json";
        // 1.1 修改请求的数据格式 JSON
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 1.2 修改响应的数据格式 二进制的数据
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
//        
//      [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        
        [manager GET:urlStr parameters:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
//        {"foodGenre":"谷类","foodGenreList":[["1","面粉","面粉","谷类"],["8","婴幼儿面","面粉","谷类"]
            NSMutableArray *foodGenreArray = nil;
            if(rsp.rspCode == 0)
            {
                //            "foodGenre":"谷类","foodGenreList"
                NSArray *rspList = rspDict[@"dataList"];
                foodGenreArray = [NSMutableArray array];
                for(NSDictionary *foodGenre in rspList)
                {
                    ZDFoodCategory *foodCategory = [ZDFoodCategory initWithDict:foodGenre];
                    [foodGenreArray addObject:foodCategory];
                }
            }
//            ZDLog(@"..,.,.,.,.%d,",foodGenreArray.count);
//            [self _netRspProcess:rsp];
            callback(rsp,foodGenreArray);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self _operationLog:operation];
            
            RspState *rsp = [RspState rspStateNetError];
            
            callback(rsp,nil);
        }];
    }
}


/* 7、获取四库未尝试库 */
+ (void)getSiKuCategory:(NSString *)str  Callback:(void(^)(RspState *,NSArray *))callback
{
    //    /mobile/getUserTryingMaterial2.do;jsessionid=
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSDictionary *para =@{@"tp":str};
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getUserMaterialLib.do;jsessionid=%@", kBaseURL, jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        
        //        manager.responseSerializer = @"text/json";
        // 1.1 修改请求的数据格式 JSON
        //        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 1.2 修改响应的数据格式 二进制的数据
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
        //
        //      [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        
        [manager GET:urlStr parameters:para  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            //        {"foodGenre":"谷类","foodGenreList":[["1","面粉","面粉","谷类"],["8","婴幼儿面","面粉","谷类"]
            NSMutableArray *foodGenreArray = nil;
            if(rsp.rspCode == 0)
            {
                //            "foodGenre":"谷类","foodGenreList"
                NSArray *rspList = rspDict[@"dataList"];
                foodGenreArray = [NSMutableArray array];
                for(NSDictionary *foodGenre in rspList)
                {
                    ZDFoodCategory *foodCategory = [ZDFoodCategory initWithDict:foodGenre];
                    [foodGenreArray addObject:foodCategory];
                }
            }
            //            ZDLog(@"..,.,.,.,.%d,",foodGenreArray.count);
            //            [self _netRspProcess:rsp];
            callback(rsp,foodGenreArray);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self _operationLog:operation];
            
            RspState *rsp = [RspState rspStateNetError];
            
            callback(rsp,nil);
        }];
    }
}

/* 8、提交宝宝勾选个人四库信息 */
+ (void)postBabySiKuInfoWithMids:(NSArray *)mids CallBack:(void (^)(RspState *))callback;
{
//    /mobile/iniUserFourLib.do;jsessionid=      mids=1,2,3,4&tp=1
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
//        NSCharacterSet 这是个字符集合类
//        [NSCharacterSet characterSetWithCharactersInString", "]//把字符串转化为字符集合
//        -------拼接
        NSString * str = [mids componentsJoinedByString:@","];
//        NSLog(@"str ==  %@",str);
        
//        NSString *str = @"";
//        NSMutableString *midsStr = [[NSMutableString alloc]initWithString:@""];
//        for (int i = 0; i < mids.count; i++ ) {
////            NSLog(@"===============%@",mids[i]);
//            str = [midsStr stringByAppendingString:mids[i]];
//            if (i < mids.count-1) {
//                str =[midsStr stringByAppendingString:@","];
//            }
//            NSLog(@"caocaoacoacocaocao%@",str);
//        }
//        NSLog(@"%@ ,  %@",midsStr, mids);
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/iniUserFourLib.do;jsessionid=%@", kBaseURL,jessionid];
        
        NSDictionary *para =@{@"mids":str,
                              @"tp":@"1"};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp);
        }];
    }
}

/* 9、获取今日尝试新食材信息 */
+ (void)getTodayTryInfoCallback:(void(^)(RspState *,NSArray *))callback
{
///mobile/getUserTryingMaterial.do;jsessionid=
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getUserTryingMaterial.do;jsessionid=%@", kBaseURL, jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;

        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            
            NSMutableArray *departmentList = [NSMutableArray array];
            if(rsp.rspCode == 0)
            {
                
                NSArray *rspList = rspDict[@"dataList"];
                for(NSDictionary *dict in rspList)
                {
                    ZDNewFood *newfood = [ZDNewFood initWithDict:dict];
                    [departmentList addObject:newfood];
                }
            }
            
            callback(rsp,departmentList);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self _operationLog:operation];
            
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp,nil);
        }];
    }
}

/* 10、获取可选择的今日尝试新食材列表 */
+ (void)getEditTryFoodCallback:(void (^)(RspState *,NSArray *))callback
{
//    choose
    
}

/* 11、提交今日尝试新食材 */
+ (void)postToDayTryFoodSta:(NSString *)sta mid:(NSString *)mid cycle:(NSString *)cycle grams:(NSString *)grams Callback:(void (^)(RspState *))callback
{
//   /mobile/postTryMaterial.do;jsessionid=      sta=1&mid=1&cycle=3&grams=10
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/postTryMaterial.do;jsessionid=%@", kBaseURL,jessionid];
        
        NSDictionary *para =@{@"sta":sta,
                              @"mid":mid,
                              @"cycle":cycle,
                              @"grams":grams
                              };
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp);
            
        }];
    }
}


/* 12、获取尝试记录页信息 */
+ (void)getTryRecordInfoCallback:(void (^)(RspState *,NSArray *))callback
{
///mobile/getUserMaterialTryList.do;jsessionid=
    
//    dataList=[{"mname":"面粉","cycle":3,"practice":"","tryDate":"2014-12-01","introduce":"","isTrying":2,"grams":10,"micon":""},{"mname":"面粉","cycle":3,"practice":"","tryDate":"2014-12-02","introduce":"","isTrying":1,"grams":10,"micon":""}]
//    {"mname":"面粉","cycle":3,"practice":"","tryDate":"2014-12-02","introduce":"","isTrying":1,"grams":10,"micon":""}
    
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
//        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getUserTryingMaterial.do;jsessionid=%@", kBaseURL, jessionid];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getUserMaterialTryList.do;jsessionid=%@", kBaseURL,jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            NSMutableArray *departmentList = [NSMutableArray array];
            if(rsp.rspCode == 0)
            {
                
                NSArray *rspList = rspDict[@"dataList"];
                for(NSDictionary *dict in rspList)
                {
                    if ([dict isEqual:[NSNull null]]) {
                        [departmentList addObject:@""];
                    }else if ([dict isKindOfClass:[NSNull class]]){
                        [departmentList addObject:@""];
                    }else if (dict==nil){
                        [departmentList addObject:@""];
                    }else{
                        ZDTryRecord *tryRecord = [ZDTryRecord initWithDict:dict];
                        [departmentList addObject:tryRecord];
                    }
                }
            }
            
            //        getTryRecordInfoCallback
//            [self _netRspProcess:rsp];
            callback(rsp,departmentList);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self _operationLog:operation];
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp,nil);
        }];
    }
}
-(BOOL)isNulls:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (object==nil){
        return NO;
    }
    return YES;
}
/* 13、提交尝试结果 */
+ (void)postTryResultTryState:(NSString *)tryState CallBack:(void (^)(RspState *))callback
{
///mobile/postTryResult.do;jsessionid=      tryState=
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/postTryResult.do;jsessionid=%@", kBaseURL,jessionid];
        
        NSDictionary *para =@{@"tryState":tryState};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager POST:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp);
        }];
    }
}

/* 14、获取周总结 */
+ (void)getZhouCallback:(void (^)(RspState *,NSDictionary *))callback{
//    /mobile/getWeekUserLibStat.do;jsessionid=
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getWeekUserLibStat.do;jsessionid=%@", kBaseURL,jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
//            NSLog(@"====%@",rspDict);
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp,rspDict);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp,nil);
        }];
    }
}

/* 15、获取月总结 */
+ (void)getYueCallback:(void (^)(RspState *,NSDictionary *))callback{
//    /mobile/getMonthUserLibStat.do;jsessionid=
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getMonthUserLibStat.do;jsessionid=%@", kBaseURL,jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
//            NSLog(@"=====%@",rspDict);
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp,rspDict);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp,nil);
        }];
    }
}

/* 16、获取个人四库信息列表 */
+ (void)getSikuInfoWeiChangshiCallback:(void (^)(RspState *))callback
{
//    /mobile/getUserTryingMaterial2.do;jsessionid=
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getMonthUserLibStat.do;jsessionid=%@", kBaseURL,jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp);
        }];
    }
}

+ (void)getTryingFoodCallback:(void (^)(RspState *))callback{
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getTryingMaterial.do;jsessionid=%@", kBaseURL,jessionid];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp);
        }];
    }
}
//  /mobile/getMaterialById.do;jsessionid=
/* 18、根据id获取食材信息 */
+ (void)getInfoWithId:(NSString *)mid CallBack:(void (^)(RspState *,NSDictionary *))callback{
    ZDBaby *baby =  [ZDBabyTool sharedZDBabyTool].account;
    NSString *jessionid = baby.jsessionid;
    if (jessionid == nil) {
        return;
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@/mobile/getMaterialById.do;jsessionid=%@", kBaseURL,jessionid];
        NSDictionary *para =@{@"mid":mid};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = kTimeout;
        [manager GET:urlStr parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self _operationLog:operation];
            
            NSDictionary *rspDict = responseObject;
            RspState *rsp = [[RspState alloc]initWithDict:rspDict];
            NSDictionary *dict = rspDict[@"material"];
            if(rsp.rspCode == 0)
            {
                
            }
            callback(rsp,dict);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            RspState *rsp = [RspState rspStateNetError];
            callback(rsp,nil);
        }];
    }
}


#pragma mark ------ private function
+ (void) netRspProcess:(RspState *)rsp
{
    if(rsp.rspCode==101){ //用户名或密码错误
//      [LoginAccountTool sharedLoginAccountTool].loginState = NO;
        
    }
}


+ (void) _operationLog:(AFHTTPRequestOperation *)operation;
{
    
    NSURLRequest *req = operation.request;
//   NSURLResponse *rsp = operation.response;
    NSString *reqbody = [[NSString alloc]initWithData:req.HTTPBody encoding:NSUTF8StringEncoding];
    NSString *rspbody =[[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Request URL %@ ",req.URL);
    NSLog(@"Request body %@",reqbody);
    NSLog(@"Response  %@",rspbody );
    
}

@end

