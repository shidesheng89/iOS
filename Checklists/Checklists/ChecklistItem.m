//
//  ChecklistItem.m
//  Checklists
//
//  Created by 施德胜 on 15/7/7.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem


-(id)initWithCoder:(NSCoder *)aDecoder{
    //初始化，从nscoder的decoder对象中取出了对象，然后将值保存在checklistitem的属性中
    if ((self=[super init])) {//一定要用双括号
        self.text=[aDecoder decodeObjectForKey:@"Text"];
        self.checked=[aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    //实现协议的方法
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    //checklistitem有一个名为text的对象，其中包含self.text属性，还有一个名为“checked”的布尔值，其中包含了self.cheched的属性
}
-(void)toggleChecked{
    self.checked=!self.checked;
}


@end
