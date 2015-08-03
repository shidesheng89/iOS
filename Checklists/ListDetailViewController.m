//
//  ListDetailViewController.m
//  Checklists
//
//  Created by 施德胜 on 15/7/13.
//  Copyright (c) 2015年 施德胜. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController{
    NSString *_iconName;//使用该变量来保持所选中的图标名称
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self=[super initWithCoder:aDecoder])) {
        _iconName=@"Folder";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.checklistToEdit!=nil) {
        self.title=@"Edit Checklist";
        self.textField.text=self.checklistToEdit.name;
        self.doneBarButton.enabled=YES;
        
        _iconName=self.checklistToEdit.iconName;
    }
    self.iconImageView.image=[UIImage imageNamed:_iconName];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Cancel:(id)sender {
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)Done:(id)sender {
    
    if (self.checklistToEdit==nil) {
        Checklist *checklist=[[Checklist alloc]init];
        checklist.name=self.textField.text;
        checklist.iconName=_iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }else{
        self.checklistToEdit.name=self.textField.text;
        self.checklistToEdit.iconName=_iconName;
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
    
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //去除选中变灰的效果
    if (indexPath.section==1) {//允许用户在碰触icon所在的cell，并在该方法中返回cell的index－path。因为icon cell是第二个section中的唯一行，我们只需要检查indexpath.section久可以了
        return indexPath;
    }else{
        return nil;}
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

#pragma mark  实现add／editchecklist界面代理

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //为了通知IconPickerViewController add／editchecklist界面会成为它的代理，需要实现prepareForSegue方法
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller=segue.destinationViewController;
        controller.delegate=self;
    }
}

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName{
    //通过该代理协议方法，将选中的图标名称保存到——iconname中，并使用新的图片更新了image view视图
    _iconName=iconName;
    self.iconImageView.image=[UIImage imageNamed:_iconName];
    [self.navigationController popViewControllerAnimated:YES];//这里使用popViewControllerAnimated而不是dismissViewController的原因是icon picker现在位于导航视图的堆栈上（segue类型是push而不是modal）
}
@end
