//
//  AddItemViewController.h
//  Checklists
//
//  Created by 施德胜 on 15/7/8.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import <UIKit/UIKit.h>

//使用代理模式
@class AddItemViewController;
@class ChecklistItem;//只是通知编译器，与＃import不同
@protocol AddItemViewControllerDelegate<NSObject>//任何遵守该协议的对象要实现一下方法


-(void)addItemViewControllerDidCancel:(AddItemViewController*)controller;
-(void)addItemViewController:(AddItemViewController*)controller didFinishAddingItem:(ChecklistItem*)item;
-(void)addItemViewControllerDidCancel:(AddItemViewController *)controller didFinshEditingItem:(ChecklistItem *)item;//编辑一个项目时调用
@end

@interface AddItemViewController : UITableViewController<UITextFieldDelegate>//<>中设置代理
- (IBAction)Cancel:(id)sender;

- (IBAction)Done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id<AddItemViewControllerDelegate>delegate;//引用协议
@property (strong,nonatomic) ChecklistItem *itemToEdit;

@end
