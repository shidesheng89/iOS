//
//  Checklist.m
//  Checklists
//
//  Created by 施德胜 on 15/7/13.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"

@implementation Checklist

-(NSComparisonResult)compare:(Checklist*)otherChecklists{
    return [self.name localizedStandardCompare:otherChecklists.name];//比较Checklists和otherChecklists对象名称的差异，name属性属于nsstring，可以使用localizedStandardCompare，chapter23p2
}

-(int)countUncheckItems{
    int count=0;
    for (ChecklistItem *items in self.items) {
        if (!items.checked) {//如果item对象的checked属性设置为no
            count+=1;
        }
    }
    return count;
}
-(id)init{
    //当用户添加一个新的checklist到应用中时会调用常规init方法
    if ((self=[super init])) {
       self.items=[[NSMutableArray alloc]initWithCapacity:20];
        self.iconName=@"No Icon";//No Icon为源泉透明的图片，使格式对齐
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    //用于当应用启动时加载已有的checklists
    if ((self=[super init])) {
        self.name=[aDecoder decodeObjectForKey:@"Name"];
        self.name=[aDecoder decodeObjectForKey:@"Items"];
        
        self.iconName=[aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    //name与items属性都属于对象，可以用decodeObjectForKey:和encodeObject:来加载喝保存
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.name forKey:@"Items"];
    
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}
@end
