//
//  LeftTableViewController.m
//  WeiboHomePage
//
//  Created by Maple on 16/10/16.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "LeftTableViewController.h"


@interface LeftTableViewController ()

@property (nonatomic,assign) CGFloat  hight;
@property (nonatomic,assign) CGFloat  worksHeight;
@property (nonatomic,assign) NSInteger  page;
@property (nonatomic,assign) BOOL  isUp,isOneTime;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic, assign) BOOL canScroll;

@end

@implementation LeftTableViewController

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc]init];
    }
    return _data;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
//    [self createFootView];
    
    self.tableView.separatorStyle = UITableViewRowAnimationNone;
//    self.table.tableHeaderView = [self comstHeaderView];

}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   

    return 66;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    ;
//    if (cell == nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//    }
    cell.textLabel.text = @"333";
    

  
  return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

   
    return 66;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}






@end
