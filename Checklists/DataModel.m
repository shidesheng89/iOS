//
//  DataModel.m
//  Checklists
//
//  Created by 施德胜 on 15/7/15.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "DataModel.h"
#import "Checklist.h"

@implementation DataModel

-(void)sortChecklists{
    [self.lists sortUsingSelector:@selector(compare:)];//self.lists的数据类型是nsmutablearray。selector是方法的名称。这里我们高速lists数组，它需要使用compare：方法来对内容进行排序
    //selector可以在runtime提供方法的名称chapter23p3
}

#pragma mark 数据加载和保存
-(NSString*)documentsDirectory{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths firstObject];
    return documentsDirectory;
}
-(NSString *)dataFilePath{
    //创建到checklists.plist的完整路径
    
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists{
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:_lists forKey:@"Checklists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    //获取_items数组中的内容，然后分两步讲它转换成二进制数据块，然后写进到文件中，chapter13p5
}

-(void)loadChecklists{
    NSString *path=[self dataFilePath];//将应用沙河保存在path中
    //检查沙盒中是否存在该文件
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        //党应用从沙河中找到checklist.plist文件时，我们无需创建一个新的数组，可以从该文件中加载整个数组和其中内容（savechecklistitem的逆向操作）
        NSData *data=[[NSData alloc]initWithContentsOfFile:path];//将文件内容加载到nsdata对象中
        NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];//创建一个nskeyedunarchiver对象
        self.lists=[unarchiver decodeObjectForKey:@"Checklists"];//将数据集解码到_items数组中,因为array数组是现在时属性变量，因此用self.lists代替了_lists
        [unarchiver finishDecoding];
    }else{
        self.lists=[[NSMutableArray alloc]initWithCapacity:20];//创建一个空的nsmutablearray，20只是一个提示，如果超过，自动扩展
    }
    
}
#pragma mark 设置NSUserDefaults默认值
-(void)registerDefaults{
    NSDictionary *dictionary=@{@"ChecklistIndex":@-1,@"FirstTime":@YES};//对象名称前有星号，基本数据类型无，切不能使用[[allco]init]来创建基本数据类型
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
}

-(NSInteger)indexOfSelectedChecklist{
    
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"ChecklistIndex"];
}

-(void)setIndexOfSelectedChecklist:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"ChecklistIndex"];
}
//-(NSInteger)indexOfSelectedChecklist,-(void)setIndexOfSelectedChecklist:(NSInteger)index这两个方法使其他文件无需为NSUserDefaults担心，其他对象只需要在适当的文职调用datamodel的相关方法就可以了

-(void)handleFirstTime{
    //检查NSUserDefaults中"FirstTime"键的值，从NSUserDefaults中直接获取一个布尔值。仅当我们需要注册初始值的时候才需要用到nsnumber
    //如果firstTime的值时yes，就说明时应用手次运行。此时我们创建一个新的checklist对象，并将他添加到数组中，调用setIndexOfSelectedChecklist来确保应用将会自动segue到新的checklist（通过alllistsviewcontroller的viredidappear方法），最后我们需要将FirstTime设置为no，这样下次请懂的时候几句不会运行着部分代码
    BOOL firstTime=[[NSUserDefaults standardUserDefaults]boolForKey:@"FirstTime"];
    if (firstTime) {
        Checklist *checklist=[[Checklist alloc]init];
        
        checklist.name=@"List";
        
        [self.lists addObject:checklist];
        
        [self setIndexOfSelectedChecklist:0];
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"FirstTime"];
    }
}

#pragma mark 表视图数据源代理方法
-(id)init{
    //当应用从storyboard中加在视图控制器时，uikit将会自动触发该方法
//    NSLog(@"⽂文件夹的⺫⽬目录是:%@",[self documentsDirectory]);
    //    NSLog(@"数据⽂文件的最终路径是:%@",[self dataFilePath]);
    if ((self=[super init])) {//initWithCoder从storyboard众加载视图控制器
        //        _lists=[[NSMutableArray alloc]initWithCapacity:20];
        //        Checklist *list;
        //
        //        list=[[Checklist alloc]init];
        //        list.name=@"娱乐";
        //        [_lists addObject:list];
        //
        //        list=[[Checklist alloc]init];
        //        list.name=@"工作";
        //        [_lists addObject:list];
        //
        //        list=[[Checklist alloc]init];
        //        list.name=@"学习";
        //        [_lists addObject:list];
        //
        //        for (Checklist *list in _lists) {
        //            ChecklistItem *item=[[ChecklistItem alloc]init];
        //            item.text=[NSString stringWithFormat:@"Item for :%@",list.name];
        //            [list.items addObject:item];
        //        
        //        }
        [self loadChecklists];
        [self registerDefaults];
        [self handleFirstTime];
        
        
    }
    return self;
}


@end
