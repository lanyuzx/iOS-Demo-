//
//  PhotoViewController.m
//  相片相机
//
//  Created by ZJF on 16/6/1.
//  Copyright © 2016年 ZJF. All rights reserved.
//

#import "PhotoViewController.h"
#import "postPicViewController.h"
#import <Photos/Photos.h>
#import "PhotoCell.h"
#import "AlbumViewCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PhotoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UICollectionView * cv;

//图片数组
@property (nonatomic,strong)NSMutableArray * arr;

@property (nonatomic,strong)UIView * tview;

@property (nonatomic,assign)BOOL isup;

@property (nonatomic,strong)UITableView * tv;

@property (nonatomic,copy)NSString * identifier;


@property (nonatomic,strong)UIToolbar * tool;

//相册数组
@property (nonatomic,strong)NSMutableArray * albumArr;


@property (nonatomic,strong)UIView *background;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isup = NO;
    self.arr = [[NSMutableArray alloc]init];
    self.albumArr = [[NSMutableArray alloc]init];
    self.selectArr = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(popto)];
    
    self.navigationItem.title = @"所有图片";
   
    [self getPhotoData];
    

}

#pragma mark --- 获取所有图片资源
- (void)getPhotoData{
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
        
        PHAsset *asset = assetsFetchResults[i];
        
        //资源转图片
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            UIImage * image = [UIImage imageWithData:imageData];
            
            [self.arr addObject:image];
            
            if (self.arr.count == assetsFetchResults.count){
                
                [self.albumArr addObject:assetsFetchResults];
                
                [self getAlbumData];
                [self createUI];
                
                
            }
        }];
        
    }
    
}

#pragma mark -- 主界面
- (void)createUI{
    
    UICollectionViewFlowLayout * fl = [[UICollectionViewFlowLayout alloc]init];
    
    fl.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-100)collectionViewLayout:fl];
    
    self.cv.delegate = self;
    
    self.cv.dataSource = self;
    
    self.cv.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:1];;
    
    
    [self.cv registerClass:NSClassFromString(@"PhotoCell")forCellWithReuseIdentifier:@"cell"];

    [self.view addSubview:self.cv];
    
    
    _isup = NO;
    
    self.tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 40)];
    
    
    UIButton *attentionBar = [[UIButton alloc] initWithFrame:CGRectMake(0, 10.0, 80.0, 30.0)];
    [attentionBar setTitle:@"相册选择" forState:UIControlStateNormal];
    
    [attentionBar addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [attentionBar setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *nextStepBarBtn = [[UIBarButtonItem alloc] initWithCustomView:attentionBar];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:      UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [spaceButtonItem setWidth:10];
    
    [self.tool setItems:[NSArray arrayWithObjects:spaceButtonItem,nextStepBarBtn,nil] animated:YES];
    
    [self.view addSubview:self.tool];
    
    //创建tv
    [self createTV];
    
}

- (void)createTV{

    self.tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0)];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    self.tview.userInteractionEnabled = YES;
    self.tv.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    
    self.tview = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH,0)];
    [self.tview addSubview:self.tv];
    
    self.tview.backgroundColor = [UIColor lightGrayColor];

    [self.view addSubview:self.tview];
    
}




#pragma mark --- 获取用户相册资源
- (void)getAlbumData{

    //可以获取所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    for (PHAssetCollection * as in topLevelUserCollections) {
        
        [self.albumArr addObject:as];
    }

}

#pragma mark --- 相册选择
- (void)btnAction:(UIButton*)sender{

    if (_isup == NO) {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            //self.tview.frame = CGRectMake(0, 0, WIDTH, HEIGHT/2 -40);
            //self.tv.frame = CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT/2 -40);
            self.tview.frame = CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT/2 -40);
            self.tv.frame = CGRectMake(0, 0, WIDTH, HEIGHT/2 -40);
            
        } completion:^(BOOL finished) {
            
            _isup = YES;
        }];

    }else{
    
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            
            self.tview.frame = CGRectMake(0, HEIGHT-40, WIDTH, 0);
            self.tv.frame = CGRectMake(0, 0, WIDTH, 0);
           
            
        } completion:^(BOOL finished) {
            
            _isup = NO;
        }];
        
    
    }


}

#pragma mark ---- cv协议
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((WIDTH-2)/3, (WIDTH-2)/3);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arr.count;
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.iv.image = self.arr[indexPath.row];
    
    cell.iv.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];

    cell.iv.tag =  100+indexPath.row;
    
    [cell.iv addGestureRecognizer:tapGesture];

    
    //使cell.btn的图片在block中可修改
    
    __strong typeof(self)weakSelf = self;
    
    __strong typeof (cell)weakCell = cell;
    //判断是否选中
    cell.btnAction = ^{
        
        __weak typeof(self)strongSelf = weakSelf;
        
        __weak typeof (cell)strongCell = weakCell;
        
        if (strongCell.btn.selected == NO) {
            
            [strongCell.btn setBackgroundImage:[UIImage imageNamed:@"p.png"] forState:UIControlStateNormal];
            
            [strongSelf.selectArr addObject: strongSelf.arr[indexPath.row]];
            
           strongCell.btn.selected = YES;
            
           // NSLog(@"%ld",self.selectArr.count);
        }else{
        
            [strongCell.btn setBackgroundImage:[UIImage imageNamed:@"p1.png"] forState:UIControlStateNormal];

            [strongSelf.selectArr removeObject: strongSelf.arr[indexPath.row]];
            strongCell.btn.selected = NO;
            
          //  NSLog(@"%ld",self.selectArr.count);
            
        }
    };
    
    
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
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




#pragma mark ---- tv协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.albumArr.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * identifier = @"album";
    
    AlbumViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[AlbumViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    if (indexPath.row == 0) {
        
        PHFetchResult *assetsFetchResults = self.albumArr[0];
        
        //第一张图的资源
        PHAsset *asset = assetsFetchResults[0];
        
        //资源转图片
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            UIImage * image = [UIImage imageWithData:imageData];
          
            cell.iv.image = image;
            
            cell.lbl.text = @"所有图片";
            
        }];

    
        
    }else{
    
        PHAssetCollection * as = self.albumArr[indexPath.row];
    
        cell.lbl.text = as.localizedTitle;
        
        PHFetchResult * fetchResult = [PHAsset fetchAssetsInAssetCollection:as options:nil];
    
        //获取相册集合中的每个相册的第一个资源，形成缩略图
        PHAsset *asset = nil;
        
        if (fetchResult.count != 0) {
            asset = fetchResult[0];
            }
    
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
    
                    UIImage * image = [UIImage imageWithData:imageData];
    
                    cell.iv.image = image;
                
        }];
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.arr removeAllObjects];
    
    [self.selectArr removeAllObjects];

    
    //所有图片
    if (indexPath.row == 0) {
        
          PHFetchResult *assetsFetchResults = self.albumArr[0];
        
        self.navigationItem.title = @"所有图片";
        
        for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
            
            PHAsset *asset = assetsFetchResults[i];
            
            //资源转图片
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                
                UIImage * image = [UIImage imageWithData:imageData];
                
                [self.arr addObject:image];
                
                if (self.arr.count == assetsFetchResults.count){
                    
                    [self.cv reloadData];

                }
            }];
        }
        
    }else{//用户相册
                
        PHAssetCollection * as = self.albumArr[indexPath.row];
    
        self.navigationItem.title = as.localizedTitle;
        
        PHFetchResult * fetchResult = [PHAsset fetchAssetsInAssetCollection:as options:nil];
    
        for (PHAsset * asset in fetchResult) {
        
        
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            UIImage * image = [UIImage imageWithData:imageData];
            
                [self.arr addObject:image];
            
                if (self.arr.count == fetchResult.count) {
                
                    [self.cv reloadData];
 
                }
            
            }];

        }
    }
    
    
    self.tview.frame = CGRectMake(0, HEIGHT-40, WIDTH, 0);
    self.tv.frame = CGRectMake(0, 0, WIDTH, 0);
    _isup = NO;
    
}


#pragma mark --- 返回
- (void)popto{
    
    self.popSelectArr (self.selectArr);
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
