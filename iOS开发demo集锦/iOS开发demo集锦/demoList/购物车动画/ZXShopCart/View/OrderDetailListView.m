//
//  OrderDetailListView.m
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//

#import "OrderDetailListView.h"
#import "GoodsModel.h"
#import "DetailListCell.h"

@implementation OrderDetailListView

- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects {
    
    return [self initWithFrame:frame withObjects:objects canReorder:NO];
}

- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.objects = [NSMutableArray arrayWithArray:objects];
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    _listTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _listTableView.bounces = NO;
    _listTableView.showsHorizontalScrollIndicator = NO;
    _listTableView.showsVerticalScrollIndicator = NO;
    _listTableView.backgroundColor = [UIColor clearColor];
//    [_listTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DetailListCell class]) bundle:nil] forCellReuseIdentifier:@"DetailListCell"];
    [self addSubview:_listTableView];
}

@end
