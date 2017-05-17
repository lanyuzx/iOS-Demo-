//
//  LLQRCodeTableViewController.m
//  iOS开发demo集锦
//
//  Created by 周尊贤 on 2017/5/17.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLQRCodeTableViewController.h"
#import "BMScanDefaultCotroller.h"
#import "LLQRDefaultController.h"
#import "LLQRStyleViewController.h"
#import "LLQRZDYViewController.h"
@interface LLQRCodeTableViewController ()<UITableViewDataSource>
@property (nonatomic,strong) NSArray * QRStyteArr;
@end

@implementation LLQRCodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.QRStyteArr = @[@"默认样式",@"扫描线条+控件颜色随机+动画速度随机",@"网扫描1+控件颜色随机+动画速度随机",@"网扫描2+控件颜色随机+动画速度随机",@"自定义样式"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
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
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.QRStyteArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.QRStyteArr[indexPath.row];
    
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[LLQRDefaultController new] animated:YES];
            break;
        case 1:
            [self pushWithScanLinAnimation:BMScanLinTypeLin];
            break;
        case 2:
            [self pushWithScanLinAnimation:BMScanLinTypeReticular1];
            break;
        case 3:
              [self pushWithScanLinAnimation:BMScanLinTypeReticular2];
            break;
        case 4:
            [self.navigationController pushViewController:[LLQRZDYViewController new] animated:YES];

            break;
            
        default:
            break;
    }
    

}

- (void)pushWithScanLinAnimation:(BMScanLin)scanLin {
    LLQRStyleViewController *scanStyle2VC = [LLQRStyleViewController new];
    scanStyle2VC.scanLin = scanLin;
    [self.navigationController pushViewController:scanStyle2VC animated:YES];
}



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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
