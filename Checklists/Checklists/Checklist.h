//
//  Checklist.h
//  Checklists
//
//  Created by 施德胜 on 15/7/13.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist:NSObject<NSCoding>;

@property(nonatomic,copy)NSString *name;//为checklist对象创建一个名为name的字符串属性

@property(nonatomic,strong)NSMutableArray *items;

@property(nonatomic,copy)NSString *iconName;

-(int)countUncheckItems;



@end
