//
//  ZDDataTool.m
//  IOSBaoDian
//
//  Created by Dong on 14-8-12.
//  Copyright (c) 2014年 itbast. All rights reserved.
//

#import "ZDDataTool.h"
#import "FMDB.h"

@interface ZDDataTool()
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic,assign) NSInteger zanshu;
@end
@implementation ZDDataTool
static FMDatabase *_db;
static FMDatabaseQueue *_queue;
static NSArray *_menus;

+ (void)initialize{
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *fileName = [path stringByAppendingPathComponent:@"food.sqlite"];
    NSString *fileName = [[NSBundle mainBundle]pathForResource:@"food.sqlite" ofType:nil];
//    NSString *str = [NSString stringWithFormat:@"DataList%d.plist",i];
//    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
	// 1.获得数据库对象
    _db = [FMDatabase databaseWithPath:fileName];
    // 1.活的数据库队列对象
    _queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    // 2.在数据库队列中执行线程安全的操作
    [_queue inDatabase:^(FMDatabase *db) {
        if ([_db open]) {
            // 2.1创建表  
            BOOL success =  [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS food_library (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT NOT NULL COLLATE NOCASE, detail TEXT NOT NULL, itemType TEXT NOT NULL, zan INTEGER NOT NULL);"];
            if (success) {
                NSLog(@"创建表成功");
            }else
            {
                NSLog(@"创建表失败");
            }
        }
    }];
    
//    [_queue inDatabase:^(FMDatabase *db) {
//        BOOL success = [db executeUpdate:@"DELETE FROM t_t WHERE 1;"];
//        if (success) {
//            NSLog(@"删除成功");
//        }else
//        {
//            NSLog(@"删除失败");
//        }
//    }];
//    FMResultSet *set = [_db  executeQuery:@"SELECT * FROM food_library  LIMIT 1;"];
//     // 2.取出数据
//    if ([set next]) {
//        NSInteger dataID = [set intForColumn:@"id"];
//        NSString *title = [set stringForColumn:@"food_name"];
//        NSString *detail = [set stringForColumn:@"food_byname"];
//        NSInteger itemType = [set intForColumn:@"category_id"];
//        NSInteger zan = [set intForColumn:@"zan"];
//        NSDictionary *dict = @{@"dataID":@(dataID),@"title":title,@"detail":detail,@"itemType":@(itemType),@"zan":@(zan)};
//        NSLog(@"%@, %d",title,dataID);
//        return;
//    }else{
//        [_queue inDatabase:^(FMDatabase *db) {
//            for (int i=0; i<=6; i++) {
//                NSString *str = [NSString stringWithFormat:@"DataList%d.plist",i];
//                NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
//                _menus = [NSArray arrayWithContentsOfFile:path];
//                for (NSDictionary *dict in _menus) {
//                    NSString *title = dict[@"title"];
//                    NSString *detail = dict[@"detail"];
//                    NSString *itemType = dict[@"itemType"];
//                    NSNumber *zan = dict[@"zan"];
//                    [db executeUpdate:@"INSERT INTO t_t(title, detail,itemType,zan) VALUES(?,?,?,?)",title,detail,itemType,zan];
//                }
//            }
//        }];
//    }
}

+ (NSArray *)dataWithSearch:(NSString *)text{
    NSMutableArray *array = [[NSMutableArray alloc]init];
//    if ([text isEqualToString:@""]) {
//        return 0;
//    }
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_library WHERE food_name like '%%%@%%'",text];
        FMResultSet *set = [_db executeQuery:sql];
        // 2.取出数据
        while ([set next]) {
            NSInteger ids = [set intForColumn:@"id"];
            NSString *food_name = [set stringForColumn:@"food_name"];
            NSInteger category_id = [set intForColumn:@"category_id"];
            NSString *food_byname = [set stringForColumn:@"food_byname"];
            NSDictionary *dict = [[NSDictionary alloc]init];
            if (food_byname == nil) {
                dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":@""};
            }else{
                dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":food_byname};
            }
            //        NSDictionary *dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":food_byname};
            [array addObject:dict];
        }
    }];
    NSArray *arr = array;
    if (arr.count == 298) {
        return nil;
    }else{
        return arr;
    }
}

+ (NSInteger)dataWithClassID:(NSInteger)classid{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
//        if (classid == 0) {
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_category WHERE level = 0"];
            FMResultSet *set = [_db executeQuery:sql];
            // 2.取出数据
            while ([set next]) {
                NSInteger category_id = [set intForColumn:@"id"];
                NSString *name = [set stringForColumn:@"name"];
                NSInteger level = [set intForColumn:@"level"];
                NSInteger pid = [set intForColumn:@"pid"];
                NSString *code = [set stringForColumn:@"code"];
                NSDictionary *dict = [[NSDictionary alloc]init];
                if (code == nil) {
                    dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":@""};
                }else{
                    dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":code};
                }
                [array addObject:dict];
            }
//        }
    }];
    NSInteger arrCount = array.count;
    return arrCount;
}

+ (NSInteger)dataWithCategoryID:(NSInteger)classid{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
//        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_category WHERE pid = ?",@(classid+1)];
        FMResultSet *set = [_db executeQuery:@"SELECT * FROM food_category WHERE pid = ?",@(classid+1)];
        // 2.取出数据
        while ([set next]) {
            int category_id = [set intForColumn:@"id"];
            NSString *name = [set stringForColumn:@"name"];
            int level = [set intForColumn:@"level"];
            int pid = [set intForColumn:@"pid"];
            NSString *code = [set stringForColumn:@"code"];
            NSDictionary *dict = [[NSDictionary alloc]init];
            if (code == nil) {
                dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":@""};
            }else{
                dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":code};
            }
//            NSDictionary *dict = @{@"category_id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":code};
            [array addObject:dict];
        }
    }];
    NSInteger arrCount = array.count;
    return arrCount;
}

+ (NSInteger)dataWithClassID:(NSInteger)classid categoryID:(NSInteger)cotegoryid{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
//    int kID = nil;
//    __weak typeof (kID) weakID;
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
//            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_category WHERE pid = ?",classid+1];
            FMResultSet *set = [_db executeQuery:@"SELECT * FROM food_category WHERE pid = ?",@(classid+1)];
            // 2.取出数据
            while ([set next]) {
                int category_id = [set intForColumn:@"id"];
//                NSString *name = [set stringForColumn:@"name"];
//                int level = [set intForColumn:@"level"];
//                int pid = [set intForColumn:@"pid"];
//                NSString *code = [set stringForColumn:@"code"];
                NSString *kID = [NSString stringWithFormat:@"%d",category_id];
//                NSDictionary *dict = [[NSDictionary alloc]init];
//                if (code == nil) {
//                    dict = @{@"ids":kID,@"name":name,@"level":@(level),@"pid":@(pid),@"code":@""};
//                    NSLog(@"ddd====%d",(NSInteger)dict[@"ids"]);
//                }else{
//                    dict = @{@"ids":kID,@"name":name,@"level":@(level),@"pid":@(pid),@"code":code};
//                }
//            NSDictionary *dict = @{@"category_id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":code};
                [array addObject:kID];
            }
    }];
//    NSInteger arrCount = array.count;
    NSString *str = array[cotegoryid];
//    int integer = (int)dict[@"id"];
//    NSLog(@"id===%@    ",str);
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_library WHERE category_id = %@",str];
            FMResultSet *set = [_db executeQuery:sql];
            // 2.取出数据
            while ([set next]) {
                NSInteger ids = [set intForColumn:@"id"];
                NSString *food_name = [set stringForColumn:@"food_name"];
                NSInteger category_id = [set intForColumn:@"category_id"];
                NSString *food_byname = [set stringForColumn:@"food_byname"];
                NSDictionary *dict = [[NSDictionary alloc]init];
                if (food_byname == nil) {
                    dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":@""};
                }else{
                    dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":food_byname};
                }
//        NSDictionary *dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":food_byname};
                [arrayM addObject:dict];
            }
    }];
//    NSLog(@"=====%d",arrayM.count);
    return arrayM.count;
}

+ (NSArray *)dataWithStringClassID:(NSInteger)classid{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
//        if (classid == 0) {
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_category WHERE level = 0"];
            FMResultSet *set = [_db executeQuery:sql];
            // 2.取出数据
            while ([set next]) {
                NSInteger category_id = [set intForColumn:@"id"];
                NSString *name = [set stringForColumn:@"name"];
                NSInteger level = [set intForColumn:@"level"];
                NSInteger pid = [set intForColumn:@"pid"];
                NSString *code = [set stringForColumn:@"code"];
                NSDictionary *dict = [[NSDictionary alloc]init];
                if (code == nil) {
                    dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":@""};
                }else{
                    dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":code};
                }
                [array addObject:dict];
//            }
        }
    }];
    NSArray *arrays = array;
    return arrays;
}

+ (NSArray *)dataWithStringCategoryID:(NSInteger)classid{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_category WHERE pid = %d",classid+1];
            FMResultSet *set = [_db executeQuery:sql];
            // 2.取出数据
            while ([set next]) {
                NSInteger category_id = [set intForColumn:@"id"];
                NSString *name = [set stringForColumn:@"name"];
                NSInteger level = [set intForColumn:@"level"];
                NSInteger pid = [set intForColumn:@"pid"];
                NSString *code = [set stringForColumn:@"code"];
                NSDictionary *dict = [[NSDictionary alloc]init];
                if (code == nil) {
                    dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":@""};
                }else{
                    dict = @{@"id":@(category_id),@"name":name,@"level":@(level),@"pid":@(pid),@"code":code};
                }
                [array addObject:dict];
        }
    }];
    NSArray *arrays = array;
    return arrays;
}

+ (NSArray *)dataWithStringClassID:(NSInteger)classid categoryID:(NSInteger)cotegoryid{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_category WHERE pid = %d",classid+1];
            FMResultSet *set = [_db executeQuery:sql];
            // 2.取出数据
            while ([set next]) {
                int category_id = [set intForColumn:@"id"];
                //                NSString *name = [set stringForColumn:@"name"];
                //                int level = [set intForColumn:@"level"];
                //                int pid = [set intForColumn:@"pid"];
                //                NSString *code = [set stringForColumn:@"code"];
                NSString *kID = [NSString stringWithFormat:@"%d",category_id];
                [array addObject:kID];
            }
    }];
    //    NSInteger arrCount = array.count;
    NSString *dict = array[cotegoryid];
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.查询
            NSString * sql = [NSString stringWithFormat:@"SELECT * FROM food_library WHERE category_id = %@",dict];
            FMResultSet *set = [_db executeQuery:sql];
            // 2.取出数据
            while ([set next]) {
                NSInteger ids = [set intForColumn:@"id"];
                NSString *food_name = [set stringForColumn:@"food_name"];
                NSInteger category_id = [set intForColumn:@"category_id"];
                NSString *food_byname = [set stringForColumn:@"food_byname"];
                NSDictionary *dict = [[NSDictionary alloc]init];
                if (food_byname == nil) {
                    dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":@""};
                }else{
                    dict = @{@"ids":@(ids),@"food_name":food_name,@"category_id":@(category_id),@"food_byname":food_byname};
                }
                [arrayM addObject:dict];
            }
    }];
    return arrayM;
}
@end
