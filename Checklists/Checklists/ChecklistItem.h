//
//  ChecklistItem.h
//  Checklists
//
//  Created by 施德胜 on 15/7/7.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>//让ckecklistitem对象遵从nscoding协议
@property(nonatomic,copy)NSString *text;//text属性涌来保存代办事务项目的具体描述
@property(nonatomic,assign)BOOL checked;//判断是否需要显示一个勾选标志
@property(nonatomic,strong)NSMutableArray *items;
-(void)toggleChecked;
@end
