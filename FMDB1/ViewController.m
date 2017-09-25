//
//  ViewController.m
//  FMDB1
//
//  Created by 大碗豆 on 17/6/9.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"
#import "NEWDataBase.h"

#import "SZKCleanCache.h"

@interface ViewController ()

@property (nonatomic,assign)NSInteger i;

@property (nonatomic,strong)NSMutableArray *arr1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建表 test123为表名
    NEWDataBase *dataBase = [NEWDataBase initWithBase:@"test123"];
    
    //清除表里面的数据
    [dataBase clearData];
    
    for (NSInteger i = 0; i < 20; i ++) {
        
        NSString *step = [NSString stringWithFormat:@"%ld",i];
        
        //        NSMutableDictionary *dicStepID = [NSMutableDictionary new];
        //        [dicStepID setValue:step forKey:@"dicStepID"];
        
        NSMutableDictionary *dicModel = [NSMutableDictionary new];
        [dicModel setValue:@"model" forKey:@"dicModel"];
        
        NSMutableDictionary *dicImage = [NSMutableDictionary new];
        [dicImage setValue:@"image" forKey:@"dicImage"];
        
        NSArray *arr = [NSArray new];
        arr = @[step,dicModel,dicImage];
        
        //插入数据
        dataBase.arrDataBase = arr;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    NEWDataBase *dataBase = [NEWDataBase new];
    NSArray *arr = [NSArray new];
    
    //读取数据
    arr = [NSMutableArray arrayWithArray:[dataBase arrDataBaseCache:@"test123"]];
    
//    NSLog(@"<<<<<<<<<~~~~~~~~%@",arr);
    
    NSMutableArray *arr1 = [NSMutableArray new];
    
    arr1 = arr[1];
    NSLog(@"<<<<<<<<<~~~~~~~~%@",arr1);
//
    
//    for (NSInteger i = 0; i < arr1.count; i ++) {
////        NSLog(@"%@",arr1[i]);
//        
//        NSDictionary *dic = arr1[i];
//        
//        NSLog(@"%@",dic);
//        
//        
//        [arr1 removeObjectAtIndex:i];
//        
//        NSLog(@"%zd",arr1.count);
//        
//    }
    
    
//    self.arr1 = arr1;
//
//    _i = 19;
//    
//    while (_i >0) {
//        
//        
//        NSDictionary *data = self.arr1[_i];
//        [arr1 removeObject:data];
//        
//        self.arr1 = arr1;
//        _i--;
//        NSLog(@"%@",data);
//        NSLog(@"%zd",_i);
//    }
//    NSLog(@"~~~~~%zd",self.arr1.count);
    
}



- (void)delectDatabase{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"NEWData.db"];
    
    //    NSString *documentsPath =[self dirCache];
    //    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
    
    BOOL res=[fileManager removeItemAtPath:path error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    }else{
        NSLog(@"文件删除失败");
        NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
    }
}


///清除缓存不影响数据库存储的数据，因为两个不在一个文件夹中
- (void)clearCache{
    //清楚缓存
    [SZKCleanCache cleanCache:^{
        NSString *text = [NSString stringWithFormat:@"%.2fM",[SZKCleanCache folderSizeAtPath]];
        NSLog(@"%@",text);
    }];
    
}


- (void)delectTable{
    NEWDataBase *dataBase = [NEWDataBase initWithBase:@"test123"];
    [dataBase delectTable];

}

- (void)selectData{
    
    NEWDataBase *dataBase = [NEWDataBase new];
    
    NSArray *arr = [NSArray new];
    arr = [NSMutableArray arrayWithArray:[dataBase arrDataBaseCache:@"test123"]];
    
    NSLog(@"<<<<<<<<<~~~~~~~~%@",arr);
}


- (void)delectRowData{
    
    NEWDataBase *dataBase = [NEWDataBase initWithBase:@"test123"];
    
    [dataBase clearDatarow:@"1"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
