//
//  DataModel.h
//  Checklists
//
//  Created by 施德胜 on 15/7/15.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic,strong)NSMutableArray *lists;

-(void)saveChecklists;
-(NSInteger)indexOfSelectedChecklist;
-(void)setIndexOfSelectedChecklist:(NSInteger)index;
-(void)sortChecklists;

@end
//datamodel希望可以接管当前由alllistsviewcontroller所负责的加载、保存数据信息的工作