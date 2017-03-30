//
//  ViewController.m
//  tableview旋转90度
//
//  Created by LJP on 17/3/29.
//  Copyright © 2017年 admin. All rights reserved.
//

#define SL_SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SL_SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)

#import "LLTransformTableViewController.h"
#import "LLTransformCell.h"

@interface LLTransformTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSMutableArray * dataArr;

@end

@implementation LLTransformTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    //旋转90度
    self.tableView.transform = CGAffineTransformRotate(_tableView.transform, M_PI_2);
    
}

- (void)initData {
    NSString * string = @"走在彷徨的路上,我的心情暗自伤,多少快乐的往事,都随风儿去远方,说好不悲伤,为何泪红了眼眶,只因对你情太深,曾经相爱到放弃";
    
    NSArray *array =  [string componentsSeparatedByString:@","];
    
    self.dataArr = [NSMutableArray arrayWithArray:array];
}

//tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SL_SCREEN_WIDTH/7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LLTransformCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.string = self.dataArr[indexPath.row];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 100, SL_SCREEN_WIDTH, SL_SCREEN_WIDTH) style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
        //取消分割线
        _tableView.separatorStyle = NO;
        
        //注册cell
        [_tableView registerClass:[LLTransformCell class] forCellReuseIdentifier:@"TableViewCell"];
        
    }
    return _tableView;
}



@end
