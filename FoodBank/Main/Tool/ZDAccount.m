//
//  ZDAccount.m
//
//  Created by Dong on 14-7-24.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDAccount.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation ZDAccount
/**
 *  归档一个数据到文件中会调用
 *
 *  @param encoder 告诉系统如何归档
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count = 0;
    // 1.获取指定类中所有的属性
    Ivar * vars = class_copyIvarList([self class], &count);
    // 2.遍历取出每一个属性
    for (int i = 0; i < count; i++) {
        Ivar var = vars[i];
        // 根据属性取出属性的名称
        const char * varName = ivar_getName(var);
        // 将属性名称转换为OC字符串
        NSString *name = [NSString stringWithUTF8String:varName];
        // 根据属性名称利用KVC取出对应的值
        id value = [self valueForKeyPath:name];
        // 归档
        [encoder encodeObject:value forKey:name];
    }
}

/**
 *  解档一个数据时候会调用
 *
 *  @param decoder 需要解档的数据
 *
 *  @return 返回一个解好的数据类型
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        // 1.获取指定类中所有的属性   Ivar运行时成员变量
        Ivar * vars = class_copyIvarList([self class], &count);
        // 2.遍历取出每一个属性
        for (int i = 0; i < count; i++) {
            Ivar var = vars[i];
            // 根据属性取出属性的名称
            const char * varName = ivar_getName(var);
            // 将属性名称转换为OC字符串
            NSString *name = [NSString stringWithUTF8String:varName];
            // 根据属性的值解归档对象
            id value = [decoder decodeObjectForKey:name];
            // 设置对象属性的值
            [self setValue:value forKeyPath:name];
        }
    }
    return self;
}

/** 通过类方法实例化一个模型数据 通过传过来的字典 */
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    ZDAccount *account = [[ZDAccount alloc]init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.remind_in = dict[@"remind_in"];
    account.uid = dict[@"uid"];
    // 获取当前的时间
    NSDate *now = [NSDate date];
    // 最终过期的时间 = 当前时间+多少秒之后过期
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}

@end
