//
//  NEWRecommenDataBase.m
//  News
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NEWDataBase.h"
#import "FMDB.h"


@implementation NEWDataBase
{
    FMDatabase *_dataBase;
    NSArray *_arrDataBase;
    NSString *_tableName;
    
}

+ (instancetype)initWithBase:(NSString *)name
{
    
    NEWDataBase *Base = [self new];
    
    [Base loadDefaultSetting:name];
    
    return Base;
}

- (void)loadDefaultSetting:(NSString *)tableName
{
    _tableName = tableName;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"NEWData.db"];
        NSLog(@"%@",path);
    _dataBase = [FMDatabase databaseWithPath:path];
    if ([_dataBase open]) {
        //        NSLog(@"打开数据库成功");
        [self creatRecommenTable];
    }else{
        //        NSLog(@"打开数据库失败");
    }
}

- (void)creatRecommenTable
{
//    AUTOINCREMENT
    NSString *sqlCreate = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID integer PRIMARY KEY ,STEPID text,MODELDIC blod,PHOTO blod);",_tableName];
    BOOL success = [_dataBase executeUpdate:sqlCreate];
    if (success) {
//                NSLog(@"执行创表语句成功");
    }
    else{
//                NSLog(@"执行创表语句失败");
    }
}



- (void)clearDatarow:(NSString *)stepid
{
//    [_dataBase executeUpdate:@"DELETE FROM User WHERE Name = ?",@"Jeffery"];
    NSString *sqlCreate = [NSString stringWithFormat:@"DELETE FROM %@ WHERE STEPID = ?",_tableName];
    
    BOOL success = [_dataBase executeUpdate:sqlCreate,stepid];
    if (success) {
                        NSLog(@"删除记录语句执行成功");
    }else{
                        NSLog(@"删除记录语句执行失败");
    }
}


- (void)clearData
{
    NSString *sqlCreate = [NSString stringWithFormat:@"DELETE FROM %@",_tableName];
    
    BOOL success = [_dataBase executeUpdate:sqlCreate];
    if (success) {
//                NSLog(@"删除记录语句执行成功");
    }else{
//                NSLog(@"删除记录语句执行失败");
    }
}



- (void)delectTable{
    
    
    NSString *sqlCreate = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@;",_tableName];
    
    BOOL success = [_dataBase executeUpdate:sqlCreate];
    if (success) {
                        NSLog(@"删除表语句执行成功");
    }else{
                        NSLog(@"删除表语句执行失败");
    }
}


/** 插入记录 增加数据 */
- (void)setArrDataBase:(NSArray *)arrRecommen
{
    _arrDataBase = arrRecommen;
    if (arrRecommen.count) {
//        [self clearData];
//        for (NSDictionary *dicData in arrRecommen) {
            NSError *error = nil;
            
            //字典转化成二进制数据
            
//        NSData *data1 = [NSJSONSerialization dataWithJSONObject:arrRecommen[0] options:NSJSONWritingPrettyPrinted error:&error];
        
        NSData *data2 = [NSJSONSerialization dataWithJSONObject:arrRecommen[1] options:NSJSONWritingPrettyPrinted error:&error];
        
        NSData *data3 = [NSJSONSerialization dataWithJSONObject:arrRecommen[2] options:NSJSONWritingPrettyPrinted error:&error];
            
            NSString *sqlCreat = [NSString stringWithFormat:@"INSERT INTO %@ (STEPID,MODELDIC,PHOTO) VALUES(?,?,?)",_tableName];
            
            //            NSString *sqlCreate = [NSString stringWithString:sqlCreat];
            
            BOOL success = [_dataBase executeUpdate:sqlCreat values:@[arrRecommen[0],data2,data3] error:&error];
            if (success) {
                                NSLog(@"插入记录语句执行成功");
            }else{
                                NSLog(@"插入记录语句执行失败");
            }
//        }
    }
}


///读取数据
- (NSArray *)arrDataBaseCache:(NSString *)name
{
    [self loadDefaultSetting:name];
    NSString *sqlCreate = [NSString stringWithFormat:@"SELECT * FROM %@;",name];
    
    NSMutableArray *arrRecommenModel = [NSMutableArray new];
    
    NSMutableArray *arr1 = [NSMutableArray new];
    NSMutableArray *arr2 = [NSMutableArray new];
    NSMutableArray *arr3 = [NSMutableArray new];
    
    FMResultSet *results = [_dataBase executeQuery:sqlCreate];
    while (results.next) {
        
        NSString *stepID = [results stringForColumn:@"STEPID"];
        
        NSData *data2 = [results dataForColumn:@"MODELDIC"];
        NSError *error2 = nil;
        //转化成字典
        NSDictionary *dicData2 = [NSJSONSerialization JSONObjectWithData:data2 options:(NSJSONReadingAllowFragments) error:&error2];
        
        NSData *data3 = [results dataForColumn:@"PHOTO"];
        NSError *error3 = nil;
        //转化成字典
        NSDictionary *dicData3 = [NSJSONSerialization JSONObjectWithData:data3 options:(NSJSONReadingAllowFragments) error:&error3];
        if (error2 && error3) {
                        NSLog(@"解析出错");
            continue;
        }else{
//            NEWHotModel *model = [NEWHotModel modelWithDictionary:dicData];
            
            
            NSLog(@"%@++++++++",stepID);
            
            [arr1 addObject:stepID];
            [arr2 addObject:dicData2];
            [arr3 addObject:dicData3];
                        NSLog(@"解析成功");
            
//            NSLog(@">>>>>>>>>>>%@",dicData);
        }
    }
    
    [arrRecommenModel addObjectsFromArray:@[arr1,arr2,arr3]];
    
    if (arrRecommenModel.count) {
        return [arrRecommenModel copy];
    }else{
        return nil;
    }
}

@end
