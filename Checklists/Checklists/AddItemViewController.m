//
//  AddItemViewController.m
//  Checklists
//
//  Created by 施德胜 on 15/7/8.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "AddItemViewController.h"
#import "ChecklistItem.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.itemToEdit!=nil) {//itemToEdit的属性是nil，在编辑模式下，self.itemToEdit不等于nil
        self.title=@"Edit Item";//因此，我们讲那个导航栏的标题改为Edit Item
        self.textField.text=self.itemToEdit.text;//根据item的文本属性来设置文本域中的文本内容
        self.doneBarButton.enabled=YES;//取消done的初始禁用状态
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)Cancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self];
}

- (IBAction)Done:(id)sender {
    //先检查itemToEdit属性中是否包含一个对象，如果没有，添加编辑当前项目
    if (self.itemToEdit==nil) {
        ChecklistItem *item=[[ChecklistItem alloc]init];
        item.text=self.textField.text;
        item.checked=NO;
        [self.delegate addItemViewController:self didFinishAddingItem:item];
    }else{
        self.itemToEdit.text=self.textField.text;
        [self.delegate addItemViewControllerDidCancel:self didFinshEditingItem:self.itemToEdit];
    }
    
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //去除选中变灰的效果
    return nil;
}

-(void)viewWillAppear:(BOOL)animated{
    //界面打开时自动打开虚拟键盘,viewwillappear为iOS提供的视图控制方法，作用为党界面跳转到当前界面单还没显示出其中内容时执行一些人物
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];//FirstResponder为当前空间
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //在输入文本前使用导航栏done无效
    NSString *newText=[textField.text stringByReplacingCharactersInRange:range withString:string];//获取新的文本内容
    if ([newText length]>0) {
        //根据文本长度判定是否为空
        self.doneBarButton.enabled=YES;
    }else{
        self.doneBarButton.enabled=NO;
    }
    return YES;
}
@end
