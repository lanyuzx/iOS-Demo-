
//
//  ChoseView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "ChoseView.h"

@implementation ChoseView
@synthesize alphaiView,whiteView,img,lb_detail,lb_price,lb_stock,mainscrollview,sizeView,colorView,countView,bt_sure,bt_cancle,lb_line;
-(instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //半透明视图
        alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        alphaiView.backgroundColor = [UIColor blackColor];
        alphaiView.alpha = 0.2;
        [self addSubview:alphaiView];
       //装载商品信息的视图
        whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, self.frame.size.height-200)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [whiteView addGestureRecognizer:tap];
        
        //商品图片
        img = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 100, 100)];
        img.image = [UIImage imageNamed:@"1.jpg"];
        img.backgroundColor = [UIColor yellowColor];
        img.layer.cornerRadius = 4;
        img.layer.borderColor = [UIColor whiteColor].CGColor;
        img.layer.borderWidth = 5;
        [img.layer setMasksToBounds:YES];
        [whiteView addSubview:img];
        
        bt_cancle= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_cancle.frame = CGRectMake(whiteView.frame.size.width-40, 10,30, 30);
        [bt_cancle setBackgroundImage:[UIImage imageNamed:@"close@3x"] forState:0];
        [whiteView addSubview:bt_cancle];
        
        //商品价格
        lb_price = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, 10, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_price.textColor = [UIColor redColor];
        lb_price.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_price];
        //商品库存
        lb_stock = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_price.frame.origin.y+lb_price.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_stock.textColor = [UIColor blackColor];
        lb_stock.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_stock];
        //用户所选择商品的尺码和颜色
        lb_detail = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_stock.frame.origin.y+lb_stock.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 40)];
        lb_detail.numberOfLines = 2;
        lb_detail.textColor = [UIColor blackColor];
        lb_detail.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_detail];
        //分界线
        lb_line = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.origin.y+img.frame.size.height+20, whiteView.frame.size.width, 0.5)];
        lb_line.backgroundColor = [UIColor lightGrayColor];
        [whiteView addSubview:lb_line];
        
        //确定按钮
        bt_sure= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_sure.frame = CGRectMake(0, whiteView.frame.size.height-50,whiteView.frame.size.width, 50);
        [bt_sure setBackgroundColor:[UIColor redColor]];
        [bt_sure setTitleColor:[UIColor whiteColor] forState:0];
        bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_sure setTitle:@"确定" forState:0];
        [whiteView addSubview:bt_sure];
        //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
        mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lb_line.frame.origin.y+lb_line.frame.size.height, whiteView.frame.size.width, bt_sure.frame.origin.y-(lb_line.frame.origin.y+lb_line.frame.size.height))];
        mainscrollview.showsHorizontalScrollIndicator = NO;
        mainscrollview.showsVerticalScrollIndicator = NO;
        [whiteView addSubview:mainscrollview];
        //购买数量的视图
        countView = [[BuyCountView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        [mainscrollview addSubview:countView];
        [countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        countView.tf_count.delegate = self;
        [countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)add
{
    int count =[countView.tf_count.text intValue];
    if (count < self.stock) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
    }
}
-(void)reduce
{
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
    }else
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alert.tag = 100;
//        [alert show];
    }
}
#pragma mark-tf
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    mainscrollview.contentOffset = CGPointMake(0, countView.frame.origin.y);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int count =[countView.tf_count.text intValue];
    if (count > self.stock) {
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
        countView.tf_count.text = [NSString stringWithFormat:@"%d",self.stock];
        [self tap];
    }
}
-(void)tap
{
    mainscrollview.contentOffset = CGPointMake(0, 0);
    [countView.tf_count resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
