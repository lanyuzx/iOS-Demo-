//
//  LLExcelViewController.m
//  iOS表格原生实现左固定右滑动
//
//  Created by 周尊贤 on 17/9/22.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#define leftTabViewWith 100
#define titleHeight 45
#import "LLExcelViewController.h"
#import "LLLeftTableViewCell.h"
#import "LLRightTableViewCell.h"
@interface LLExcelViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView* leftTabView;
@property(nonatomic,strong) UITableView* rightTabView;
@property(nonatomic,strong) UIScrollView* rightContainerView;

@property(nonatomic,strong) NSArray* titles;
@end

@implementation LLExcelViewController

static  NSString * leftID = @"LLLeftTableViewCell";
static  NSString * rightID = @"LLRightTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"iOS表格原生实现左固定右滑动";
    self.titles = @[@"LEE.h",
                    @"LEE.m",
                    @"LEE.swift",
                    @"LEE.mm",
                    @"LEE.java",
                    @"LEE.html",
                    @"LEE.php",
                    @"LEE.exe",
                    @"LEE.dmg",
                    @"LEE.zip",
                    @"LEE.rar",
                    @"LEE.经纪人",
                    @"LEE.表姐夫",
                     @"LEE.表弟",
                     @"LEE.大妹子",
                     @"LEE.大姨夫",
                     @"LEE.小姨子",
                     @"LEE.大舅子",
                     @"LEE.大叔子",
                     @"LEE.SDEE",
                     @"LEE.藤原LEE",
                     @"LEE.表哥",
                     @"LEE.表兄",
                     @"LEE.弟妹",
                     @"LEE.lee",
                    ];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 // MARK: ---- 添加控件
-(void)setupUI {
    
    UILabel * leftTileLable = [UILabel new];
    [self.view addSubview:leftTileLable];
    leftTileLable.font = [UIFont systemFontOfSize:15];
    leftTileLable.text = @"LEE家族";
    leftTileLable.textAlignment = NSTextAlignmentCenter;
    leftTileLable.backgroundColor = [UIColor orangeColor];
    leftTileLable.textColor = [UIColor whiteColor];
    leftTileLable.frame = CGRectMake(0, 64, leftTabViewWith, titleHeight);
    
    for (int i = 0; i<self.titles.count; i++) {
        UILabel * leftTileLable = [UILabel new];
        [self.rightContainerView addSubview:leftTileLable];
        leftTileLable.font = [UIFont systemFontOfSize:15];
        leftTileLable.text = self.titles[i];
        leftTileLable.textAlignment = NSTextAlignmentCenter;
        leftTileLable.backgroundColor = [UIColor orangeColor];
        leftTileLable.textColor = [UIColor whiteColor];
        leftTileLable.frame = CGRectMake(i*leftTabViewWith, 0, leftTabViewWith, titleHeight);
    }
    self.rightContainerView.contentSize = CGSizeMake(leftTabViewWith *self.titles.count, 0);
    [self.view addSubview:self.leftTabView];
    [self.view addSubview:self.rightContainerView];
    [self.rightContainerView addSubview:self.rightTabView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTabView) {
        LLLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:leftID];
        cell.titleName = self.titles[indexPath.row];
        return cell;
    }else {
        LLRightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rightID];
        cell.titles = self.titles;
        return cell;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    static CGFloat lastOffset = 0.00;
    for (UITableView *tableView in @[_leftTabView,_rightTabView]) {
        if (scrollView == self.rightTabView) {
            if (scrollView.contentOffset.x != lastOffset) {
                lastOffset = scrollView.contentOffset.x;
            }else{
                //NSLog(@"%f",scrollView.contentOffset.y);
                if (tableView !=scrollView) {
                    tableView.contentOffset = scrollView.contentOffset;
                }
            }
        }else{
            tableView.contentOffset = scrollView.contentOffset;
        }
    }
}

 // MARK: ---- 懒加载
-(UITableView *)leftTabView {
    if (!_leftTabView) {
        _leftTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 109, leftTabViewWith, CGRectGetHeight(self.view.frame)-109) style:UITableViewStylePlain];
        _leftTabView.delegate = self;
        _leftTabView.dataSource = self;
         [_leftTabView registerClass:[LLLeftTableViewCell class] forCellReuseIdentifier:leftID];
        
    }
    return _leftTabView;
}
-(UITableView *)rightTabView {
    if (!_rightTabView) {
        _rightTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, self.titles.count*leftTabViewWith, CGRectGetHeight(self.rightContainerView.frame)-45) style:UITableViewStylePlain];
        _rightTabView.delegate = self;
        _rightTabView.dataSource = self;
        [_rightTabView registerClass:[LLRightTableViewCell class] forCellReuseIdentifier:rightID];
        
    }
    return _rightTabView;
}
-(UIScrollView *)rightContainerView {
    if (!_rightContainerView) {
        _rightContainerView = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTabView.frame), 64, CGRectGetWidth(self.view.frame)-leftTabViewWith, CGRectGetHeight(self.view.frame)-64)];
        _rightContainerView.backgroundColor = [UIColor whiteColor];
    }
    return _rightContainerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
