//
//  ChecklistTableViewController.m
//  Checklists
//
//  Created by 施德胜 on 15/7/7.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "ChecklistTableViewController.h"
#import "ChecklistItem.h"


@interface ChecklistTableViewController ()

@end

@implementation ChecklistTableViewController{
    NSMutableArray *_items;//使用NSMutableArray代替实例变量
    

}
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller didFinshEditingItem:(ChecklistItem *)item{
    //有了这个方法代理对象就知道如何在编辑完成后进行相应处理
    NSInteger index=[_items indexOfObject:item];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _items=[[NSMutableArray alloc]initWithCapacity:20];
    
    ChecklistItem *item;
    
    item=[[ChecklistItem alloc]init];
    item.text=@"观看嫦娥飞天喝玉兔升空视频";
    item.checked=NO;
    [_items addObject:item];
    
    item=[[ChecklistItem alloc]init];
    item.text=@"观看嫦娥飞天喝玉兔";
    item.checked=NO;
    [_items addObject:item];
    
    item=[[ChecklistItem alloc]init];
    item.text=@"观看嫦娥飞天";
    item.checked=NO;
    [_items addObject:item];
    
    item=[[ChecklistItem alloc]init];
    item.text=@"观看嫦娥";
    item.checked=NO;
    [_items addObject:item];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_items count];
}
-(void)configureCheckmarkForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{
    //设置勾选标志
    
    //ChecklistItem *item=_items[indexPath.row];//从数组中请求具备喝行编号相同的index的checklistitem对象,withChecklistItem:(ChecklistItem*)item可代替该语句
    UILabel *label=(UILabel *)[cell viewWithTag:1001];//选tag为1001的label
    
    if (item.checked) {
        label.text=@"√";
    }else{
        label.text=@"";
    }

}

-(void)configureTextForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{
    UILabel *label=(UILabel*)[cell viewWithTag:1000];//与tag为1000的label关联
    label.text=item.text;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];//与storyboard关联
    
    ChecklistItem *item=_items[indexPath.row];


    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistItem *item=_items[indexPath.row];
    [item toggleChecked];//item.checked=!item.checked;更改之后不再直接修改checklist的选中属性，而是通过调用方法完成
    
    
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)addItem:(id)sender {
//    //关联加号
//    NSInteger newRowIndex=[_items count];//新行的编号等于表中的当前项目数
//    ChecklistItem *item=[[ChecklistItem alloc]init];//创建对象
//    item.text=@"我是一个菜鸟";
//    item.checked=NO;
//    [_items addObject:item];//把对象添加到数组的最后，在数据模型中
//    
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:newRowIndex inSection:0];//创建一个新的nsindexpath对象指向新的行，使用的参数为newrowindex这个行编号
//    NSArray *indexPaths=@[indexPath];//创建一个新的临时性数组
//    
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//}//调用insertrowsatindexpaths插入新的行，还带有一个动画效果

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除行
    [_items removeObjectAtIndex:indexPath.row];//在数据模型中删除该项目
    NSArray *indexPaths=@[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];//通知表视图以动画形式删除这些行
}


//关闭add item界面
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
    //与addItem方法类似，在AddItemViewController添加对象。我们只需要把新的对象添加到_items数组中就可以了。我们通知表视图有一个新的行，然后关闭add items界面
    NSInteger newRowIndex=[_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexPaths=@[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        
        UINavigationController *navigationController=segue.destinationViewController;//新的视图控制器可以在segue.destinationViewController中找到
        
        ItemDetailViewController *controller=(ItemDetailViewController*)navigationController.topViewController;//为了获取AddItemViewController对象，我们可以查看导航控制器的topViewController属性，该属性指向导航控制器的当前活跃界面

        controller.delegate=self;//一旦我们获得了到AddItemViewController对象的引用，就需要将deledgate属性设置为self，而self其实值得是checklistsviewcontroller
        
    }else if([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController=segue.destinationViewController;
        
        ItemDetailViewController *controller=(ItemDetailViewController*)navigationController.topViewController;
        
        controller.delegate=self;
        
        NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];//sender参数启示指的就是触发了该segue的控件，在这里就是table view cell中的细节显示按钮。通过它可以找到对应的nidex－path，然后获取要编辑的checklistitem对象的行编号
        
        controller.itemToEdit=_items[indexPath.row];
        
    }
    
}
@end
