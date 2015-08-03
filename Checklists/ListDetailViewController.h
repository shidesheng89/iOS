//
//  ListDetailViewController.h
//  Checklists
//
//  Created by 施德胜 on 15/7/13.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelrgate <NSObject>

-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist;
-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist;

@end

@interface ListDetailViewController : UITableViewController<UITextFieldDelegate,IconPickerViewControllerDelegate>

@property(nonatomic,weak)IBOutlet UITextField *textField;
@property(nonatomic,weak)IBOutlet UIBarButtonItem *doneBarButton;
@property(nonatomic,weak)id<ListDetailViewControllerDelrgate>delegate;

@property(nonatomic,strong)Checklist *checklistToEdit;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

-(IBAction)Cancel:(id)sender;
-(IBAction)Done:(id)sender;
//上述所有代码与itemdetailviewcontroller相似
@end
