//
//  MenuButton.m
//  ZFMenuTableView
//
//  Created by 张锋 on 16/7/13.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import "MenuButton.h"

#define kFontSize 13.f
#define kTriangleWH 20.f
#define kDefTitleCor [UIColor colorWithRed:0.560 green:0.550 blue:0.520 alpha:1.000]
#define kSelTitleCor [UIColor colorWithRed:0.980 green:0.440 blue:0.270 alpha:1.000]

@interface MenuButton ()
{
    NSString *_title;  // 按钮标题
    UIImage *_defImg;  // 按钮没有选中时右边图片
    UIImage *_selImg;  // 按钮选中时右边图片
}
@property (nonatomic, strong) MenuButton *selectedBtn;
@property (nonatomic, assign) BOOL selected;
/** 用来设置按钮标题 */
@property (nonatomic, strong) UILabel *titLabel;
/** 用来设置图片 */
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation MenuButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title defImage:(UIImage *)defImage selImage:(UIImage *)selImage
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _defImg = defImage;
        _selImg = selImage;
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titLabel
{
    if (!_titLabel) {
        _titLabel = [[UILabel alloc] init];
        _titLabel.text = _title;
        _titLabel.textColor = kDefTitleCor;
        UIFont *font = [UIFont systemFontOfSize:kFontSize];
        _titLabel.font = font;
        CGSize size = [_title sizeWithFont:font maxSize:CGSizeMake(self.w, self.h)];
        _titLabel.center = CGPointMake(self.w/2 - kTriangleWH/2, self.h/2);
        _titLabel.bounds = CGRectMake(0, 0, size.width, size.height);
    }
    return _titLabel;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = _defImg;
        _imgView.contentMode = UIViewContentModeCenter;
        _imgView.frame = CGRectMake(CGRectGetMaxX(self.titLabel.frame), (self.h-kTriangleWH)/2, kTriangleWH, kTriangleWH);
    }
    return _imgView;
}

- (void)setupSubViews
{
    self.selected = NO;
    
    [self addSubview:self.titLabel];
    [self addSubview:self.imgView];
    // self.backgroundColor = [UIColor colorWithWhite:0.960 alpha:1.000];
    
    // 给视图添加手势，当我们点击视图是触发`menuButtonClicked`方法
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonClicked)];
    [self addGestureRecognizer:tap];
}

#pragma mark - 手势点击事件
- (void)menuButtonClicked
{
    _selected = ! _selected;
    
    if (_selected) {
        self.titLabel.textColor = kSelTitleCor;
        self.imgView.image = _selImg;
    }
    else {
        self.titLabel.textColor = kDefTitleCor;
        self.imgView.image = _defImg;
    }
    
    if (self.clickMenuButton) {
        self.clickMenuButton(self, self.titLabel.text,_selected);
    }
}

- (void)setIsSeled:(BOOL)isSeled
{
    if (!isSeled) {
        _selectedBtn.titLabel.textColor = kDefTitleCor;
        _selectedBtn.imgView.image = _defImg;
    }
}

- (void)setTitle:(NSString *)title
{
    self.titLabel.text = title;
    UIFont *font = [UIFont systemFontOfSize:kFontSize];
    _titLabel.font = font;
    
    // 为了不至于让标题和图片由于位置变化而太难看，我们需要在按钮标题每次改变时重新设置它的frame
    CGSize size = [title sizeWithFont:font maxSize:CGSizeMake(self.w, self.h)];
    _titLabel.center = CGPointMake(self.w/2 - kTriangleWH/2, self.h/2);
    _titLabel.bounds = CGRectMake(0, 0, size.width, size.height);
    _imgView.frame = CGRectMake(CGRectGetMaxX(self.titLabel.frame), (self.h-kTriangleWH)/2, kTriangleWH, kTriangleWH);
    [self setNeedsLayout];
    [self setIsSeled:NO];
}

- (void)resetStatus:(MenuButton *)button
{
    NSLog(@"resetStatus");
    
    button.titLabel.textColor = kDefTitleCor;
    button.imgView.image = _defImg;
    button.selected = NO;
}

@end
