//
//  XMGAddTagViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/8/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGAddTagViewController.h"
#import "XMGTagButton.h"
#import "XMGTagTextField.h"
#import "SVProgressHUD.h"
#import "UIView+XMGExtension.h"
#import "PrefixHeader.pch"
@interface XMGAddTagViewController () <UITextFieldDelegate>
/** 内容 */
@property (nonatomic, weak) UIView *contentView;
/** 文本输入框 */
@property (nonatomic, weak) XMGTagTextField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addButton;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation XMGAddTagViewController

#pragma mark - 懒加载
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = XMGTagFont;
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, XMGTagMargin, 0, XMGTagMargin);
        // 让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = XMGTagBg;
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextFiled];
    
    [self setupTags];
}

- (void)setupTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonClick];
    }
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = XMGTagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + XMGTagMargin;
    contentView.height = XMGScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextFiled
{
    __weak typeof(self) weakSelf = self;
    XMGTagTextField *textField = [[XMGTagTextField alloc] init];
    textField.width = self.contentView.width;
    textField.deleteBlock = ^{
        if (weakSelf.textField.hasText) return;
        
        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
    };
//    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)done
{
    // 传递数据给上一个控制器
//    NSMutableArray *tags = [NSMutableArray array];
//    for (XMGTagButton *tagButton in self.tagButtons) {
//        [tags addObject:tagButton.currentTitle];
//    }
    // 传递tags给这个block
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听文字改变
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    // 更新文本框的frame
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) { // 有文字
        // 显示"添加标签"的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + XMGTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
        // 获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len - 1];
        if ([lastLetter isEqualToString:@","]
            || [lastLetter isEqualToString:@"，"]) {
            // 去除逗号
            self.textField.text = [text substringToIndex:len - 1];
            
            [self addButtonClick];
        }
    } else { // 没有文字
        // 隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
}

#pragma mark - 监听按钮点击
/**
 * 监听"添加标签"按钮点击
 */
- (void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    // 添加一个"标签按钮"
    XMGTagButton *tagButton = [XMGTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    // 清空textField文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
    
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

/**
 * 标签按钮的点击
 */
- (void)tagButtonClick:(XMGTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 重新更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

#pragma mark - 子控件的frame处理
/**
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    // 更新标签按钮的frame
    for (int i = 0; i<self.tagButtons.count; i++) {
        XMGTagButton *tagButton = self.tagButtons[i];
        
        if (i == 0) { // 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else { // 其他标签按钮
            XMGTagButton *lastTagButton = self.tagButtons[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XMGTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) { // 按钮显示在当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            } else { // 按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + XMGTagMargin;
            }
        }
    }
}

/**
 * 更新textField的frame
 */
- (void)updateTextFieldFrame
{
    // 最后一个标签按钮
    XMGTagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XMGTagMargin;
    
    // 更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + XMGTagMargin;
    }
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}

#pragma mark - <UITextFieldDelegate>
/**
 * 监听键盘最右下角按钮的点击（return key， 比如“换行”、“完成”等等）
 */
- (BOOL)textFieldShouldReturn:(XMGTagTextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

//- (BOOL)textFieldShouldClear:(UITextField *)textField
//{
//    XMGLogFunc;
//    return YES;
//}
@end
