//
//  MenuView.m
//  ZFMenuTableView
//
//  Created by 张锋 on 16/7/13.
//  Copyright © 2016年 张锋. All rights reserved.
//

/*
 *  推荐使用方法：将这个View设置为tableView的第一次组的组头视图
 *  目前这个demo只能实现一组下拉列表的情况，多分组的情况以后我会继续增加和优化
 */

#import "MenuListView.h"
#import "MenuButton.h"

#define kAniDuration 0.3f
#define kTitleCor [UIColor colorWithRed:0.100 green:0.700 blue:0.610 alpha:1.000]

@interface ListCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"ListCell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected) {
        [self setSelected:YES animated:YES];
    }else {
        [self setSelected:NO animated:YES];
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        CGFloat titleLabelH = self.h - 2*10.f;
        _titleLabel.frame = CGRectMake(55.f, 10.f, self.w - 100.f, titleLabelH);
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _titleLabel;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        CGFloat imgViewWH = self.h - 2*10.f;
        _imgView.contentMode = UIViewContentModeCenter;
        _imgView.frame = CGRectMake(15.f, 10.f, imgViewWH, imgViewWH);
    }
    return _imgView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];
    if (selected) {
        self.titleLabel.textColor = kTitleCor;
        self.imgView.image = [UIImage imageNamed:@"gc_navi_selected_icon"];
        // NSLog(@"选中了");
    }else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.imgView.image = nil;
        // NSLog(@"没选中");
    }
}

@end


#define kLineW 0.5f
#define kLineH 25.f
#define kLineCor [UIColor colorWithWhite:0.850 alpha:1.000]

#define kRowH 40.f

@interface MenuListView () <UITableViewDelegate, UITableViewDataSource>
{
    NSString *_currenTitle;
    MenuButton *_button;
}
@property (nonatomic, strong) UITableView *lTableView;
@property (nonatomic, strong) UITableView *rTableView;
@property (nonatomic, strong) UIView *shadow;
@end

@implementation MenuListView

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray<NSString *> *)titles defImage:(UIImage *)defImage selImage:(UIImage *)selImage
{
    self = [super initWithFrame:frame];
    if (self) {
        [self subViewsWithTitles:titles defImage:defImage selImage:selImage];
    }
    return self;
}

- (void)subViewsWithTitles:(NSArray *)titles defImage:(UIImage *)defImage selImage:(UIImage *)selImage
{
    self.backgroundColor = [UIColor whiteColor];
    
    // 上边的分割线
    CGRect topLineFrame = CGRectMake(0, 1.f, kS_W, 0.5f);
    UIView *topLine = [[UIView alloc] initWithFrame:topLineFrame];
    topLine.backgroundColor = kLineCor;
    [self addSubview:topLine];
    
    // 下边的分割线
    CGRect bottomLineFrame = CGRectMake(0, self.h-1.f, kS_W, 0.5f);
    UIView *bottomLine = [[UIView alloc] initWithFrame:bottomLineFrame];
    bottomLine.backgroundColor = kLineCor;
    [self addSubview:bottomLine];
    
    NSInteger count = [titles count];
    for (int i=0; i<count; i++) {
        // 创建按钮
        CGFloat buttonW = (self.w - (count-1)*kLineW)/count;
        CGFloat buttonH = 40.f;
        CGFloat buttonX = (buttonW+kLineW) * i;
        CGRect btnFrame = CGRectMake(buttonX, 0.f, buttonW, buttonH);
        MenuButton *button = [[MenuButton alloc] initWithFrame:btnFrame title:titles[i] defImage:defImage selImage:selImage];
        [self addSubview:button];
        
        
        __weak typeof(self)weakSelf = self;
        button.clickMenuButton = ^(MenuButton *button, NSString *title, BOOL selected){
            if (weakSelf.clickMenuButton) {
                weakSelf.clickMenuButton( button,i, selected);
            }
            
            if (!_button) {
                _button = button;
            }
            if (button != _button) {
                [_button resetStatus:_button];
            }
            else {
            }
            
            _currenTitle = title;
            // ------------------------
        
            _button = button;
            if (selected) {
                [self showListViewAnimation];
            }
            else {
                [self hideListViewAnimation];
            }
            
            // ----------------------
            
        };
        
        // 按钮之间的竖直分割线
        if (i < count-1) {
            CGFloat lineX = buttonX + buttonW;
            CGFloat lineY = (self.h-kLineH)/2;
            CGRect lineFrame = CGRectMake(lineX, lineY, kLineW, kLineH);
            UIView *line = [[UIView alloc] initWithFrame:lineFrame];
            line.backgroundColor = kLineCor;
            [self addSubview:line];
        }
    }
}

- (UIView *)shadow
{
    if (!_shadow) {
        _shadow = [[UIView alloc] init];
        _shadow.alpha = 0.f;
        _shadow.userInteractionEnabled = YES;
        _shadow.frame = CGRectMake(0, 104, kS_W, kS_H);
        _shadow.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadowViewClick)];
        [_shadow addGestureRecognizer:tap];
    }
    return _shadow;
}

- (UITableView *)lTableView
{
    if (!_lTableView) {
        CGRect frame = CGRectMake(0.f, 64 + self.h, self.w, 0.f);
        _lTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _lTableView.delegate = self;
        _lTableView.dataSource = self;
    }
    return _lTableView;
}

#pragma mark - 点击背景
- (void)shadowViewClick
{
    [self hideListViewAnimation];
}

// 隐藏下拉列表
- (void)showListViewAnimation
{
    UIView *superView = self.superview;
    [superView.window addSubview:self.shadow];
    [superView.window addSubview:self.lTableView];
    
    CGFloat height = [self maxListHeightWithModel:self.dataSource];
    
    [UIView animateWithDuration:kAniDuration animations:^{
        self.shadow.alpha = 1.f;
        self.lTableView.h = height;
    }];
}

// 显示下拉列表
- (void)hideListViewAnimation
{
    [UIView animateWithDuration:kAniDuration animations:^{
        self.shadow.alpha = 0.f;
        self.lTableView.h = 0.f;
    } completion:^(BOOL finished) {
        [self.shadow removeFromSuperview];
        [self.lTableView removeFromSuperview];
    }];
}

// 一定要重写这个方法，在这里`reloadData`
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self.lTableView reloadData];
}

// 更具数据源里边数据情况，返回TableView高度
- (CGFloat)maxListHeightWithModel:(NSArray *)dataSource
{
    NSInteger count = dataSource.count;
    CGFloat height = 0.f;
    CGFloat oriHeight = kRowH*count;
    oriHeight > kS_H/3*2 ? (height = kS_H/3*2) : (height = kRowH*count);
    
    return height;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = [ListCell cellWithTableView:tableView];
    cell.title = self.dataSource[indexPath.row];
    cell.selected = [self.dataSource[indexPath.row] isEqualToString:_currenTitle];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:0.2f animations:^{
        self.shadow.alpha = 0.f;
        self.lTableView.h = 0.f;
    } completion:^(BOOL finished) {
        [self.shadow removeFromSuperview];
        [self.lTableView removeFromSuperview];
    }];
    
    _button.isSeled = NO;
    _button.title = self.dataSource[indexPath.row];
    
    [_button resetStatus:_button];
    
    // 实现回调方法
    if (self.clickListView) {
        self.clickListView(indexPath.row, self.dataSource[indexPath.row]);
    }
}

@end
