//
//  ChecklistTableViewController.m
//  Checklists
//
//  Created by 施德胜 on 15/7/7.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"


@interface ChecklistViewController ()

@end

@implementation ChecklistViewController

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller didFinshEditingItem:(ChecklistItem *)item{
    //有了这个方法代理对象就知道如何在编辑完成后进行相应处理
    NSInteger index=[self.checklist.items indexOfObject:item];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withChecklistItem:item];
  
    [self dismissViewControllerAnimated:YES completion:nil];
}
//之前从文件中加载和保存checklist items，最好让checklist对象可以自行完成这些工作，而不是控制器来做这些－chapter17p5
//-(void)loadChecklistItems{
//    NSString *path=[self dataFilePath];//将应用沙河保存在path中
//    //检查沙盒中是否存在该文件
//    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
//        //党应用从沙河中找到checklist.plist文件时，我们无需创建一个新的数组，可以从该文件中加载整个数组和其中内容（savechecklistitem的逆向操作）
//        NSData *data=[[NSData alloc]initWithContentsOfFile:path];//将文件内容加载到nsdata对象中
//        NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];//创建一个nskeyedunarchiver对象
//        _items=[unarchiver decodeObjectForKey:@"ChecklistItems"];//将数据集解码到_items数组中
//        [unarchiver finishDecoding];
//    }else{
//        _items=[[NSMutableArray alloc]initWithCapacity:20];//创建一个空的nsmutablearray
//    }
//}

//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if ((self=[super initWithCoder:aDecoder])) {//通过调用[super initwithcoder]确保视图控制器的其他部分可以从storyboard文件中顺利解冻
//        [self loadChecklistItems];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title=self.checklist.name;//当用户触碰不同的checklist时会显示不同的标题。这个标题会显示在导航栏中，其内容就是checklist 对象的名称
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//之前从文件中加载和保存checklist items，最好让checklist对象可以自行完成这些工作，而不是控制器来做这些－chapter17p5
//-(NSString *)documentsDirectory{
//    //获取到documents文件夹的完整路径
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//注意不是NSDocumentationDirectory
//    NSString *documentsDirectory=[paths firstObject];
//    
//    return documentsDirectory;
//}

//-(NSString *)dataFilePath{
//    //创建到checklists.plist的完整路径
//    
//    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
//}

//-(void)saveChecklistItems{
//    NSMutableData *data=[[NSMutableData alloc]init];
//    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [archiver encodeObject:_items forKey:@"ChecklistItems"];
//    [archiver finishEncoding];
//    [data writeToFile:[self dataFilePath] atomically:YES];
//    //获取_items数组中的内容，然后分两步讲它转换成二进制数据块，然后写进到文件中，chapter13p5
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {//1

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {//1

    // Return the number of rows in the section.
    return [self.checklist.items count];
}
-(void)configureCheckmarkForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{//2
    //设置勾选标志
    
    //ChecklistItem *item=_items[indexPath.row];//从数组中请求具备喝行编号相同的index的checklistitem对象,withChecklistItem:(ChecklistItem*)item可代替该语句
    UILabel *label=(UILabel *)[cell viewWithTag:1001];//选tag为1001的label
    
    if (item.checked) {
        label.text=@"√";
    }else{
        label.text=@"";
    }
    label.textColor=self.view.tintColor;

}

-(void)configureTextForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{
    //设置cell中标签的文本内容
    UILabel *label=(UILabel*)[cell viewWithTag:1000];//与tag为1000的label关联
    label.text=item.text;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];//与storyboard关联
    
    ChecklistItem *item=self.checklist.items[indexPath.row];


    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //开启关闭勾选标志
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];//对tableView调用cellForRowAtIndexPath
    
    ChecklistItem *item=self.checklist.items[indexPath.row];
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
    [self.checklist.items removeObjectAtIndex:indexPath.row];//在数据模型中删除该项目
    
    
    NSArray *indexPaths=@[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];//通知表视图以动画形式删除这些行
}


//关闭add item界面
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
    //与addItem方法类似，在AddItemViewController添加对象。我们只需要把新的对象添加到_items数组中就可以了。我们通知表视图有一个新的行，然后关闭add items界面
    NSInteger newRowIndex=[self.checklist.items count];
    [self.checklist.items addObject:item];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexPaths=@[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //通知additemviewcontroller，checklistsviewcontroller是它的代理
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        
        UINavigationController *navigationController=segue.destinationViewController;//新的视图控制器可以在segue.destinationViewController中找到
        
        ItemDetailViewController *controller=(ItemDetailViewController*)navigationController.topViewController;//为了获取AddItemViewController对象，我们可以查看导航控制器的topViewController属性，该属性指向导航控制器的当前活跃界面

        controller.delegate=self;//一旦我们获得了到AddItemViewController对象的引用，就需要将deledgate属性设置为self，而self其实值得是checklistsviewcontroller
        
    }else if([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController=segue.destinationViewController;
        
        ItemDetailViewController *controller=(ItemDetailViewController*)navigationController.topViewController;
        
        controller.delegate=self;
        
        NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];//sender参数启示指的就是触发了该segue的控件，在这里就是table view cell中的细节显示按钮。通过它可以找到对应的nidex－path，然后获取要编辑的checklistitem对象的行编号
        
        controller.itemToEdit=self.checklist.items[indexPath.row];
        
    }
    
}
@end
