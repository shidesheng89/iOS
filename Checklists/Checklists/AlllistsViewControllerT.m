//
//  AlllistsViewControllerTableViewController.m
//  Checklists
//
//  Created by 施德胜 on 15/7/13.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "AlllistsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"

@interface AlllistsViewController ()

@end

@implementation AlllistsViewController{
    
    NSMutableArray *_lists;//添加一个新的实例变量，用于保存checklist对象
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    //当应用从storyboard中加在视图控制器时，uikit将会自动触发该方法
    if ((self=[super initWithCoder:aDecoder])) {//initWithCoder从storyboard众加载视图控制器
        _lists=[[NSMutableArray alloc]initWithCapacity:20];
        Checklist *list;
        
        list=[[Checklist alloc]init];
        list.name=@"娱乐";
        [_lists addObject:list];
        
        list=[[Checklist alloc]init];
        list.name=@"工作";
        [_lists addObject:list];
        
        list=[[Checklist alloc]init];
        list.name=@"学习";
        [_lists addObject:list];
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //用户触碰视表图中的某一行就会触发这个代理方法
    Checklist *checklist=_lists[indexPath.row];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_lists count];//返回固定数值出错
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //将checklist对象放入sender对象并没有将该对象传递给checklistviewcontroller
    if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
        ChecklistViewController *controller=segue.destinationViewController;
        controller.checklist=sender;
    }else if([segue.identifier isEqualToString:@"AddChecklist"]){
        UINavigationController *navigationController =segue.destinationViewController;
        
        ListDetailViewController *controller=(ListDetailViewController *)navigationController.topViewController;
        controller.delegate=self;
        controller.checklistToEdit=nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //与默认模版相似
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
     //Configure the cell...
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Checklist *checklist=_lists[indexPath.row];
    cell.textLabel.text=checklist.name;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


//关闭add item界面
-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist{
    //与addItem方法类似，在AddItemViewController添加对象。我们只需要把新的对象添加到_items数组中就可以了。我们通知表视图有一个新的行，然后关闭add items界面
    NSInteger newRowIndex=[_lists count];
    [_lists addObject:checklist];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexPaths=@[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist{
    //有了这个方法代理对象就知道如何在编辑完成后进行相应处理
    NSInteger index=[_lists indexOfObject:checklist];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text=checklist.name;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除行
    [_lists removeObjectAtIndex:indexPath.row];//在数据模型中删除该项目
    
    NSArray *indexPaths=@[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];//通知表视图以动画形式删除这些行
}



-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    //手动加载一个新的视图控制器，在checklistviewcontroller中，通过触发一个segue来实现
    //为add／editchecklist界面创建了视图控制器对象，并将其显示（present）在屏幕上
    UINavigationController *navigationController=[self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller=(ListDetailViewController*)navigationController.topViewController;
    controller.delegate=self;
    Checklist *checklist=_lists[indexPath.row];
    controller.checklistToEdit=checklist;
    
    [self presentViewController:navigationController animated:YES completion:nil];
}


@end
