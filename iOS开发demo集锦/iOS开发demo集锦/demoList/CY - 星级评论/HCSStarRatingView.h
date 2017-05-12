// HCSStarRatingView.h
//
// Copyright (c) 2015 Hugo Sousa
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;

typedef BOOL(^HCSStarRatingViewShouldBeginGestureRecognizerBlock)(UIGestureRecognizer *gestureRecognizer);

IB_DESIGNABLE
@interface HCSStarRatingView : UIControl
//设置最大值
@property (nonatomic) IBInspectable NSUInteger maximumValue;
//设置最小值
@property (nonatomic) IBInspectable CGFloat minimumValue;
//星级视图当前值
@property (nonatomic) IBInspectable CGFloat value;
//星星间间距
@property (nonatomic) IBInspectable CGFloat spacing;
//是否允许选择半星
@property (nonatomic) IBInspectable BOOL allowsHalfStars;
//是否是否允许精确选择 可以根据选择位置进行精确
@property (nonatomic) IBInspectable BOOL accurateHalfStars;
//是否连续调用回调方法 如果设置为YES 则在手指拖动时 会持续调用回调方法 如果设置为NO，则只有拖动结束后才调用回调
@property (nonatomic) IBInspectable BOOL continuous;
//是否允许成为第一响应
@property (nonatomic) BOOL shouldBecomeFirstResponder;

//添加手势时使用
// Optional: if `nil` method will return `NO`.
@property (nonatomic, copy) HCSStarRatingViewShouldBeginGestureRecognizerBlock shouldBeginGestureRecognizerBlock;

@property (nonatomic, strong) IBInspectable UIColor *starBorderColor;
@property (nonatomic) IBInspectable CGFloat starBorderWidth;

@property (nonatomic, strong) IBInspectable UIColor *emptyStarColor;
//设置空星的图片
@property (nonatomic, strong) IBInspectable UIImage *emptyStarImage;
//设置半星的图片
@property (nonatomic, strong) IBInspectable UIImage *halfStarImage;
//设置全星时的图片
@property (nonatomic, strong) IBInspectable UIImage *filledStarImage;
@end

