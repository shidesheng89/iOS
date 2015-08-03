//
//  AddItemViewController.h
//  Checklists
//
//  Created by 施德胜 on 15/7/8.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <UIKit/UIKit.h>

//使用代理模式
@class ItemDetailViewController;
@class ChecklistItem;//只是通知编译器，与＃import不同
@protocol itemDetailViewControllerDelegate<NSObject>//任何遵守该协议的对象要实现一下方法


-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController*)controller;
-(void)itemDetailViewController:(ItemDetailViewController*)controller didFinishAddingItem:(ChecklistItem*)item;
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller didFinshEditingItem:(ChecklistItem *)item;//编辑一个项目时调用
@end

@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>//<>中设置代理
- (IBAction)Cancel:(id)sender;

- (IBAction)Done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id<itemDetailViewControllerDelegate>delegate;//引用协议
@property (strong,nonatomic) ChecklistItem *itemToEdit;

@end
