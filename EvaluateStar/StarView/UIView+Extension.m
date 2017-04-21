//
//  UIView+Extension.m
//  EvaluateStar
//
//  Created by hztuen on 2017/4/19.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

//重写x属性的 getter方法，返回控件的x值
- (CGFloat)x{
    return self.frame.origin.x;
}
//重写x属性的 setter方法  设置控件的x值
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


@end
