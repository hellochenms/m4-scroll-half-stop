//
//  M4TouchPenetrateScrollView.m
//  m4-scroll-half-stop
//
//  Created by Chen,Meisong on 2018/10/23.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "M4TouchPenetrateScrollView.h"

@implementation M4TouchPenetrateScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    NSLog(@"【chenms】point:%@  %s", NSStringFromCGPoint(point), __func__);
//    
//    UIView *view = [super hitTest:point withEvent:event];
//    NSLog(@"【chenms】view:%@  %s", view, __func__);
    if (point.y < 0) {
        return nil;
    } else {
        return [super hitTest:point withEvent:event];;
    }
}

@end

