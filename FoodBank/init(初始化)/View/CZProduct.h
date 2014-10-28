//
//  CZProduct.h
//  04-UICollectionView
//
//  Created by LNJ on 14-6-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 <dict>
 <key>ID</key>
 <string>com.netease.movie</string>
 <key>customUrl</key>
 <string>movieticket163</string>
 <key>icon</key>
 <string>movie</string>
 <key>title</key>
 <string>网易电影票</string>
 <key>url</key>
 <string>http://itunes.apple.com/app/id583784224?mt=8</string>
 </dict>
 */
@interface CZProduct : NSObject

// 应用程序本机的标识
@property (nonatomic, copy) NSString *ID;
// 应用程序本机的协议头
@property (nonatomic, copy) NSString *customUrl;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
// appStore下载的url
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)productWithDict:(NSDictionary *)dict;

/** 返回所有产品 */
+ (NSArray *)products;

@end
