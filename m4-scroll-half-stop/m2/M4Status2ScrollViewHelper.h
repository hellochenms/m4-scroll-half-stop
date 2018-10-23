//
//  M4Status2ScrollViewHelper.h
//  m4-scroll-half-stop
//
//  Created by Chen,Meisong on 2018/10/23.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface M4Status2ScrollViewHelper : NSObject
@property (nonatomic) CGFloat naviBarTriggerY;
@property (nonatomic) CGFloat neckY;
- (UIEdgeInsets)contentInset;
- (CGPoint)startOffset;
- (CGPoint)targetPointWithScrollView:(UIScrollView *)scrollView
                            velocity:(CGPoint)velocity
                           shouldUse:(BOOL *)shouldUse;
- (BOOL)bouncesWithScrollView:(UIScrollView *)scrollView;
- (CGFloat)naviBarProgressWithScrollView:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
