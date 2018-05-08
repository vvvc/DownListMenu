//
//  MenuView.h
//  ZFMenuTableView
//
//  Created by 张锋 on 16/7/13.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end


@class MenuButton;

@interface MenuListView : UIView

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *dataSource;

/**
 *  选中某个按钮时回调方法
 *
 *  @param button    用来标记选中的按钮
 *  @param index     用来标记`选中了第几个按钮`
 *  @param selected  用来标记`这个按钮选中状态`
 */
@property (nonatomic, copy) void (^clickMenuButton) (MenuButton *button, NSInteger index, BOOL selected);


/**
 *  选中下拉列表某行的回调方法
 *
 *  @param index  用来标记`选中了第几行`
 *  @param title  用来标记`这个这一行的标题`
 */
@property (nonatomic, copy) void (^clickListView) ( NSInteger index, NSString *title);


/**
 *  初始化菜单视图
 *
 *  @param frame    菜单视图frame(推荐x:0.f y:自定义 width:屏幕宽度 height:>=25)
 *  @param titles   要显示的按钮标题数组
 *  @param defImage 按钮没有点击之前右边那个小图片
 *  @param selImage 按钮点击之后右边那个小图片
 *
 *  @return 菜单视图
 */
- (instancetype)initWithFrame:(CGRect)frame
                       Titles:(NSArray <NSString *>*)titles
                     defImage:(UIImage *)defImage
                     selImage:(UIImage *)selImage;

@end
