//
//  ChecklistTableViewController.h
//  Checklists
//
//  Created by 施德胜 on 15/7/7.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController<itemDetailViewControllerDelegate>
//- (IBAction)addItem:(id)sender;

@property(nonatomic,strong)Checklist *checklist;

@end
