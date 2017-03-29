//
//  ViewController.m
//  相片相机
//
//  Created by ZJF on 16/5/31.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "postPicViewController.h"
#import "PhotoViewController.h"
#import "SelectedCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height




@interface postPicViewController ()<UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UITextView * MsTextView;

@property (nonatomic,strong)UIButton * addButton;

@property (nonatomic,strong)NSMutableArray * imgArr;

@property (nonatomic,strong)UICollectionView * cv;

@property (nonatomic,strong)UIView * background;

@end

@implementation postPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgArr = [[NSMutableArray alloc]init];
    
    UIImage * img = [UIImage imageNamed:@"add-img.png"];
    
    [self.imgArr addObject:img];
    
    self.view.backgroundColor= [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(shangchuan)];
    //self.navigationItem.rightBarButtonItem.tintColor=[UIColor cyanColor];
    [self createUI];
}



- (void)createUI{
    self.MsTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, 70, WIDTH-40, 80)];
    self.MsTextView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.MsTextView];
    
    UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc]init];
    fl.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.cv = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 160, WIDTH -40,HEIGHT- 160 ) collectionViewLayout:fl];
    self.cv.backgroundColor= self.view.backgroundColor;
    
    
    self.cv.delegate = self;
    self.cv.dataSource = self;
    
    [self.cv registerClass:NSClassFromString(@"SelectedCell") forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.cv];
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat w = (WIDTH-40)/4-5;
    
    return CGSizeMake(w, w);

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.imgArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    SelectedCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.iv.image = self.imgArr[indexPath.row];
    
    if (indexPath.row != self.imgArr.count-1) {
        
        cell.iv.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        
        cell.iv.tag =  100+indexPath.row;
        
        [cell.iv addGestureRecognizer:tapGesture];
        
    }
    
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == self.imgArr.count -1) {
        
        [self toChoose];
    }


}


- (void)toChoose{

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        PhotoViewController * photo = [[PhotoViewController alloc]init];
        
        __weak typeof(self)weakSelf = self;
        
        photo.popSelectArr = ^(NSMutableArray*arr ){
        
            __strong typeof(self)strongSelf = weakSelf;
            
            strongSelf.imgArr = arr;
            
            UIImage * img = [UIImage imageNamed:@"add-img.png"];
            
            [strongSelf.imgArr addObject:img];
           
            [strongSelf.cv reloadData];
            
          //  NSLog(@"%ld",self.imgArr.count);
        
        };
        
        [self.navigationController pushViewController:photo animated:NO];
        
    }];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"相机没写");
        
    }];
    
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction: action1];
    [alert addAction: action2];
    [alert addAction: action3];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}



- (void)tapAction:(UITapGestureRecognizer*)sender{
    
    // NSLog(@"%ld",[sender view].tag);
    UIImageView * iv = (UIImageView*)[sender view];
    
    UIImage * img = iv.image;
    
    //创建一个黑色背景
    _background = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH , HEIGHT)];
    
    [ _background setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview: _background];
    
    
    CGFloat h = WIDTH*img.size.height/img.size.width;
    // NSLog(@"h = %lf",h);
    
    //创建显示图像的视图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (HEIGHT-h)/2, WIDTH, h)];
    //要显示的图片，即要放大的图片
    imgView.image = img;
    [ _background addSubview:imgView];
    
    imgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [imgView addGestureRecognizer:tapGesture];
    
    [self shakeToShow: _background];//放大过程中的动画
    
}

-(void)closeView{
    self.navigationController.navigationBarHidden = NO;
    [_background removeFromSuperview];
}
//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    
    self.navigationController.navigationBarHidden = YES;
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.1;
    NSMutableArray *values = [NSMutableArray array];
    //  [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


-(void)shangchuan{

    NSLog(@"没服务器你传哪去");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
