//
//  AlllistsViewControllerTableViewController.h
//  Checklists
//
//  Created by 施德胜 on 15/7/13.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
@class DataModel;

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelrgate>

@property(nonatomic,strong)DataModel *dataModel;
//-(void)saveChecklists;

@end
