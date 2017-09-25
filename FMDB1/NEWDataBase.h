//
//  NEWRecommenDataBase.h
//  News
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEWDataBase : NSObject

/** 要存储的数据 */
@property (nonatomic, copy) NSArray *arrDataBase;

///创建表
+ (instancetype)initWithBase:(NSString *)name;
///读取数据
- (NSArray *)arrDataBaseCache:(NSString *)name;
///按条件清除单条数据
- (void)clearDatarow:(NSString *)stepid;

///删除表
- (void)delectTable;

///删除表中所有数据
- (void)clearData;

@end
