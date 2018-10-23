//
//  M4Status2ScrollViewHelper.m
//  m4-scroll-half-stop
//
//  Created by Chen,Meisong on 2018/10/23.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "M4Status2ScrollViewHelper.h"

@implementation M4Status2ScrollViewHelper
- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(self.neckY, 0, 0, 0);
}

- (CGPoint)startOffset {
    return CGPointMake(0, -self.neckY);
}

- (CGPoint)targetPointWithScrollView:(UIScrollView *)scrollView
                            velocity:(CGPoint)velocity
                           shouldUse:(BOOL *)shouldUse {
    CGPoint target = CGPointZero;
    if (shouldUse) {
        *shouldUse = YES;
    }
    // 加速度向下
    if (velocity.y < 0) {
        target = CGPointMake(0, -self.neckY);
    }
    // 加速度向上
    else if (velocity.y > 0) {
        *shouldUse = NO;
    }
    // 无加速度
    else {
        if (scrollView.contentOffset.y <= -self.neckY) {
            target = CGPointMake(0, -self.neckY);
        } else {
            if (shouldUse) {
                *shouldUse = NO;
            }
        }
    }
    
    return target;
}

- (BOOL)bouncesWithScrollView:(UIScrollView *)scrollView {
    BOOL bounces = (scrollView.contentOffset.y > -self.neckY);
    
    return bounces;
}

- (CGFloat)naviBarProgressWithScrollView:(UIScrollView *)scrollView {
    CGFloat progress = 0;
    if (scrollView.contentOffset.y <= self.naviBarTriggerY - self.neckY) {
        progress = 0;
    } else if (scrollView.contentOffset.y >= 0) {
        progress = 1;
    } else {
        progress = (scrollView.contentOffset.y - (self.naviBarTriggerY - self.neckY)) / -(self.naviBarTriggerY - self.neckY);
    }
    
    return progress;
}
@end
