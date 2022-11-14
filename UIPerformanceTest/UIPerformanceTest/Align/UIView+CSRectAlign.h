//
//  UIView+CSRectAlign.h
//  UIPerformanceTest
//
//  Created by Jared on 2022/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSRectAlign)

/// 调整逻辑像素，让它转换成物理像素时能够得到整数，达到像素对齐
/// 将 floatValue 进行向上增加，   在 3x 的屏幕上， 93.2 会被调整为 93.33
///                             在 2x 的屏幕上， 93.2 会被调整为 93.5
/// @param floatValue 要调整的值
CGFloat CGFloatCeilPixel(CGFloat floatValue);

/// 调整逻辑像素，让它转换成物理像素时能够得到整数，达到像素对齐
/// 将 floatValue 进行向上减少， 在 3x 的屏幕上， 100.9 会被调整为 100.66
///                           在 2x 的屏幕上， 100.9 会被调整为 100.5
/// @param floatValue 要调整的值
CGFloat CGFloatFloorPixel(CGFloat floatValue);

/// 调整逻辑像素，让它转换成物理像素时能够得到整数，达到像素对齐
/// width 与 height 进行向上增加， 在 3x 的屏幕上， 93.2 会被调整为 93.33
///                             在 2x 的屏幕上， 93.2 会被调整为 93.5
/// @param size 布局的width，height
CGSize  CGSizeCeilPixel(CGSize size);

/// 调整逻辑像素，让它转换成物理像素时能够得到整数，达到像素对齐
/// 让 x 与 y 值进行向下减少， 在 3x 的屏幕上， 100.9 会被调整为 100.66
///                        在 2x 的屏幕上， 100.9 会被调整为 100.5
/// @param origin 布局的x，y
CGPoint CGPointFloorPixel(CGPoint origin);

/// 调整逻辑像素，让它转换成物理像素时能够得到整数，达到像素对齐。以减少GPU渲染时的额外开销。
/// 让调整后的值 更接近 调整前的值，相差不超过 1 / [[UIScreen mainScreen].scale]）
/// 让 x 与 y 值进行向下减少， width 与 height 进行向上增加，使调整后的rect能够容纳调整前的rect，
///
/// 例如: 这个布局      CGRectMake(100.9,  100.4,  93.2,  21.4)
///      在 3x 的屏幕上，会被调整为 (100.66, 100.33, 93.33, 21.66)  误差不超过 1 / 3
///      在 2x 的屏幕上，会被调整为 (100.5,  100,    93.5,  21.5)   误差不超过 1 / 2
/// 如果使用floor与ceil函数，得到   (100,    100,    94,    22)     误差最大能接近 1
/// 如果使用系统的CGRectIntegral   (100,    100,    95,    22)     误差最大能超过 1
///
/// @param rect 布局frame
CGRect  CGRectAlignPixel(CGRect rect);


/// 会调用 CGRectAlignPixel 对View的frame进行重新设置，以达到达到像素对齐
- (void)alignFrame;

/// 会调用 CGSizeCeilPixel 对View的size进行重新设置，以达到达到像素对齐
- (void)alignSize;

/// 会调用 CGFloatFloorPixel 对View的origin进行重新设置，以达到达到像素对齐
- (void)alignOrigin;

@end

NS_ASSUME_NONNULL_END
