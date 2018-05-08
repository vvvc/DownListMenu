//
//  NSString+ZF.m
//  ZFMenuTableView
//
//  Created by 张锋 on 16/7/13.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import "NSString+ZF.h"

@implementation NSString (ZF)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attribute = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
}

@end
