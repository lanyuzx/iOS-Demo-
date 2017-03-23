//
//  TableViewCell.m
//  仿微信cell小弹框
//
//  Created by JYD on 2017/2/4.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "TableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "SDTimeLineCellOperationMenu.h"
#import "LLModel.h"
#import "LLPhotoesView.h"
@implementation TableViewCell

{
    SDTimeLineCellOperationMenu * _menu;
    UIButton * _btn;
    LLPhotoesView * _photoesView;
    UIView * _lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LLModel *)model {
    _model = model;
    _txtLable.text = [NSString stringWithFormat:@"   %@",model.text];
    _photoesView.model = model;
    //150
    if (model.photoArr.count == 1) {
         _photoesView.sd_layout.heightIs(180);
    }else if (model.photoArr.count == 2) {
        _photoesView.sd_layout.heightIs(80);

    }else if (model.photoArr.count > 2) {
        _photoesView.sd_layout.heightIs(150);
        }

    
     [self setupAutoHeightWithBottomView:_lineView bottomMargin:10];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       
        UIButton * btn = [UIButton new];
        _btn = btn;
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = true;
        btn.backgroundColor = [UIColor orangeColor];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn setTitle:@"评论" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(alterView) forControlEvents:UIControlEventTouchUpInside];
        
        SDTimeLineCellOperationMenu * menu = [SDTimeLineCellOperationMenu new];
        [menu bringSubviewToFront:self.contentView];
        _menu = menu;
        __weak TableViewCell *weakSelf = self;
        [_menu setLikeButtonClickedOperation:^{
            NSLog(@"喜欢");
            weakSelf.model.isLike = !weakSelf.model.isLike;
        }];
        [_menu setCommentButtonClickedOperation:^{
            NSLog(@"评论");
        }];
        
        self.txtLable = [UILabel new];
        _txtLable.textColor = [UIColor darkGrayColor];
        _txtLable.numberOfLines = 0;
        _txtLable.font = [UIFont boldSystemFontOfSize:14];
        
        
        
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        
        LLPhotoesView * photoesView = [[LLPhotoesView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _photoesView = photoesView;
        [self.contentView sd_addSubviews:@[ self.txtLable, btn,photoesView,menu]];

        _txtLable.sd_layout
        .topSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView,10)
        .autoHeightRatio(0);
        
        photoesView.sd_layout
        .topSpaceToView(_txtLable,5)
        .leftEqualToView(_txtLable)
        .heightIs(150)
        .widthIs([UIScreen mainScreen].bounds.size.width *0.55);

        btn.sd_layout
        .topSpaceToView(photoesView,5)
        .widthIs(45)
        .heightIs(20)
        .rightSpaceToView(self.contentView,5);

        menu.sd_layout
        .rightSpaceToView(btn, 0)
        .heightIs(36)
        .centerYEqualToView(btn)
        .widthIs(0);
        
        btn.didFinishAutoLayoutBlock = ^(CGRect frame) {
        
        };
        
       _lineView = [UIView new];
        [self.contentView addSubview:_lineView];
        _lineView.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topSpaceToView(btn,5)
        .heightIs(3);
        
        [self drawDashLine:_lineView lineLength:20 lineSpacing:1 lineColor:[UIColor redColor]];

       
    }
    return self;
}
  /// MARK: ---- 画虚线

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(0 , 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:2];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,[UIScreen mainScreen].bounds.size.width, 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

-(void)alterView{
    
    _menu.show = !_menu.isShowing;
    
    

}

@end
