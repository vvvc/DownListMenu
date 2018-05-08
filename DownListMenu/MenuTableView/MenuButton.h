//
//  MenuButton.h
//  ZFMenuTableView
//
//  Created by 张锋 on 16/7/13.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIView

/** 当按钮标题改变时，要触发`setTitle:`这个方法 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSeled;

/**
 *  选中某个按钮时回调方法
 *
 *  @param button    用来标记选中的按钮
 *  @param index     用来标记`选中了第几个按钮`
 *  @param selected  用来标记`这个按钮选中状态`
 */
@property (nonatomic, copy) void (^clickMenuButton) (MenuButton *button, NSString *title, BOOL selected);

/**
 *  按钮初始化方法
 *
 *  @param frame    按钮frame
 *  @param title    按钮标题
 *  @param defImage 按钮上的默认图片
 *  @param selImage 按钮选中时的图片
 */
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                     defImage:(UIImage *)defImage
                     selImage:(UIImage *)selImage;

/**
 *  重置某个安某状态
 *
 *  @param button 要重置状态的按钮
 */
- (void)resetStatus:(MenuButton *)button;

@end
