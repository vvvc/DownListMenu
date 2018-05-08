//
//  UIView+ZF.h
//  ZFMenuTableView
//
//  Created by 张锋 on 16/6/1.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZF)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (UIViewController*)viewController;
@end
