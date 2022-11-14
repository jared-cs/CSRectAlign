# 介绍
调整逻辑像素，让它转换成物理像素时能够得到整数，达到像素对齐。以减少GPU渲染时的额外开销。
<br>让调整后的值 更接近 调整前的值，相差不超过 1 / [[UIScreen mainScreen].scale]
<br>让 x 与 y 值进行向下减少， width 与 height 进行向上增加，使调整后的rect能够容纳调整前的rect
<br>
<br>例如: 这个布局      CGRectMake(100.9,  100.4,  93.2,  21.4)
<br>     在 3x 的屏幕上，会被调整为 (100.66, 100.33, 93.33, 21.66)  误差不超过 1 / 3
<br>     在 2x 的屏幕上，会被调整为 (100.5,  100,    93.5,  21.5)   误差不超过 1 / 2
<br>如果使用floor与ceil函数，得到   (100,    100,    94,    22)     误差最大能接近 1
<br>如果使用系统的CGRectIntegral   (100,    100,    95,    22)     误差最大能超过 1

# 使用方式
// 一、导入头文件
<br>#import "UIView+CSRectAlign.h"
<br>
<br>UILabel *label = [UILabel new];
<br>label.text = @"你吃了么.nn";
<br>CGRect rect  = CGRectMake(100.9, 100.4, 93.2, 21.4);

<br>// 二、调用CGRectAlignPixel调整frame
<br>label.frame = CGRectAlignPixel(rect);
<br>// 或者 label.frame = rect;
<br>//      [label alignFrame];
<br>[self.view addSubview:label];

<br>//三、调用CGSizeCeilPixel调整size
<br>CGSize labelSize = [label.text boundingRectWithSize:CGSizeMake(1000, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
<br>labelSize = CGSizeCeilPixel(labelSize);
