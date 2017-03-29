//
//  ViewController.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "LLSelectClothesController.h"

#import "ChoseView.h"

@interface LLSelectClothesController ()<UITextFieldDelegate,TypeSeleteDelegete>
{
    ChoseView *choseView;
    UIView *bgview;
    CGPoint center;
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;
}
@end

@implementation LLSelectClothesController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     这些数据应该从服务器获得 没有服务器我就只能先写死这些数据了
     */
    sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",nil];
    colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",nil];
    NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
    stockarr = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:str]];
    
    [self initview];
}
#pragma mark-method
-(void)initview
{
    /**
     *  商品信息页面内容
     */
    self.view.backgroundColor = [UIColor blackColor];
    //淘宝点击加入购物车时商品信息页面会缩小，中心点上移，背景为黑色，弹出视图为全屏，露出的一部分商品信息页面也有一层很浅的黑色透明视图盖着，所以我对商品信息页面做了以下布局，上导航栏隐藏，self.view作为那个黑色背景，bgview盖在self.view上，所有商品信息都在bgview上，choseView是弹出视图，放在屏幕下方，当点击加入购物车时从下方进入，同时bgview缩小，中心点上移
    bgview = [[UIView alloc] initWithFrame:self.view.bounds];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    
    UIButton *btn_add= [UIButton buttonWithType:UIButtonTypeCustom];
    btn_add.frame = CGRectMake(100, 80,200, 50);
    [btn_add setTitleColor:[UIColor whiteColor] forState:0];
    btn_add.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn_add setTitle:@"加入购物车" forState:0];
    btn_add.backgroundColor = [UIColor redColor];
    btn_add.layer.cornerRadius = 4;
    btn_add.layer.borderColor = [UIColor clearColor].CGColor;
    btn_add.layer.borderWidth = 1;
    [btn_add.layer setMasksToBounds:YES];
    [btn_add addTarget:self action:@selector(btnselete) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn_add];
    
    [self initChoseView];
}
/**
 *  初始化弹出视图
 */
-(void)initChoseView
{
   
    
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:choseView];
    
    //尺码
    choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
    choseView.sizeView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.sizeView];
    choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
    //颜色分类
    choseView.colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
    choseView.colorView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.colorView];
    choseView.colorView.frame = CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, choseView.colorView.height);
    //购买数量
    choseView.countView.frame = CGRectMake(0, choseView.colorView.frame.size.height+choseView.colorView.frame.origin.y, choseView.frame.size.width, 50);
    choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, choseView.countView.frame.size.height+choseView.countView.frame.origin.y);
    
    choseView.lb_price.text = @"¥100";
    choseView.lb_stock.text = @"库存100000件";
    choseView.lb_detail.text = @"请选择 尺码 颜色分类";
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [choseView.bt_sure addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    choseView.img.userInteractionEnabled = YES;
    [choseView.img addGestureRecognizer:tap1];
}
/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}
/**
 *  点击按钮弹出
 */
-(void)btnselete
{
    
    [UIView animateWithDuration: 0.35 animations: ^{
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
        choseView.center = self.view.center;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];


}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        bgview.center = self.view.center;
    } completion: nil];

}
#pragma mark-typedelegete
-(void)btnindex:(int)tag
{
    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
    if (choseView.sizeView.seletIndex >=0&&choseView.colorView.seletIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockarr objectForKey: size] objectForKey:color]];
        choseView.lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
        choseView.stock =[[[stockarr objectForKey: size] objectForKey:color] intValue];
        
        [self reloadTypeBtn:[stockarr objectForKey:size] :colorarr :choseView.colorView];
        [self reloadTypeBtn:[stockarr objectForKey:color] :sizearr :choseView.sizeView];
        NSLog(@"%d",choseView.colorView.seletIndex);
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex == -1)
    {
        //尺码和颜色都没选的时候
        choseView.lb_price.text = @"¥100";
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码 颜色分类";
        choseView.stock = 100000;
        //全部恢复可点击状态
        [self resumeBtn:colorarr :choseView.colorView];
        [self resumeBtn:sizearr :choseView.sizeView];
        
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex >= 0)
    {
        //只选了颜色
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        //根据所选颜色 取出该颜色对应所有尺码的库存字典
        NSDictionary *dic = [stockarr objectForKey:color];
        [self reloadTypeBtn:dic :sizearr :choseView.sizeView];
        [self resumeBtn:colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码";
        choseView.stock = 100000;
   
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex >= 0&&choseView.colorView.seletIndex == -1)
    {
        //只选了尺码
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        //根据所选尺码 取出该尺码对应所有颜色的库存字典
        NSDictionary *dic = [stockarr objectForKey:size];
        [self resumeBtn:sizearr :choseView.sizeView];
        [self reloadTypeBtn:dic :colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 颜色分类";
        choseView.stock = 100000;
        
//        for (int i = 0; i<colorarr.count; i++) {
//            int count = [[dic objectForKey:[colorarr objectAtIndex:i]] intValue];
//            //遍历颜色字典 库存为零则改尺码按钮不能点击
//            if (count == 0) {
//                UIButton *btn =(UIButton *) [choseView.colorView viewWithTag:100+i];
//                btn.enabled = NO;
//            }
//        }
        
    }
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
