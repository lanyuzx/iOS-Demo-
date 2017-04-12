//
//  ViewController.m
//  DeviceInfoDemo
//
//  Created by Daniel Yao on 17/3/23.
//  Copyright © 2017年 Daniel Yao. All rights reserved.
//

#import "LLUDIDViewController.h"
#import "DYDeviceInfo.h"

@interface LLUDIDViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UILabel *infoLab;
@property(nonatomic,strong)UILabel *infoDescribLab;
@property(nonatomic,strong)NSArray *infoCellArr;

@end

@implementation LLUDIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.infoCellArr = [NSArray arrayWithObjects:@"获取IDFV",@"获取IDFA",@"获取IMEI",@"获取MAC",@"获取UUID",@"获取UDID", nil];
    [self.view addSubview:self.infoTableView];
    
    [self.view addSubview:self.infoDescribLab];
    [self.view addSubview:self.infoLab];
}
-(UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetHeight(self.view.frame)-150, CGRectGetWidth(self.view.frame)-30, 60)];
        _infoLab.backgroundColor    = [UIColor lightGrayColor];
        _infoLab.textColor          = [UIColor whiteColor];
        _infoLab.numberOfLines      = 0;
        _infoLab.textAlignment      = NSTextAlignmentCenter;
        _infoLab.layer.cornerRadius = 5.0;
        _infoLab.layer.masksToBounds= YES;
    }
    return _infoLab;
}
-(UILabel *)infoDescribLab{
    if (!_infoDescribLab) {
        _infoDescribLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-75, CGRectGetHeight(self.view.frame)-150-60, 150, 40)];
        _infoDescribLab.backgroundColor = [UIColor lightGrayColor];
        _infoDescribLab.textColor       = [UIColor whiteColor];
        _infoDescribLab.numberOfLines   = 0;
        _infoDescribLab.textAlignment   = NSTextAlignmentCenter;
        _infoDescribLab.layer.cornerRadius = 5.0;
        _infoDescribLab.layer.masksToBounds= YES;
    }
    return _infoDescribLab;
}
-(UITableView *)infoTableView{
    if (!_infoTableView){
        _infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-250) style:UITableViewStylePlain];
        _infoTableView.delegate         = self;
        _infoTableView.dataSource       = self;
        _infoTableView.separatorStyle   = UITableViewCellSeparatorStyleSingleLine;
        _infoTableView.tableFooterView  = [[UIView alloc]init];
    }
    return _infoTableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoCellArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text          = self.infoCellArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell       = [tableView cellForRowAtIndexPath:indexPath];
    self.infoDescribLab.text    = cell.textLabel.text;

    switch (indexPath.row) {
        case 0:
            self.infoLab.text = [DYDeviceInfo dy_getDeviceIDFV];
            break;
        case 1:
            self.infoLab.text = [DYDeviceInfo dy_getDeviceIDFA];
            break;
        case 2:
            self.infoLab.text = [DYDeviceInfo dy_getDeviceIMEI];
            break;
        case 3:
            self.infoLab.text = [DYDeviceInfo dy_getDeviceMAC];
            break;
        case 4:
            self.infoLab.text = [DYDeviceInfo dy_getDeviceUUID];
            break;
        case 5:
            self.infoLab.text = [DYDeviceInfo dy_getDeviceUDID];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
