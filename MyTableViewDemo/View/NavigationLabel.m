//
//  NavigationLabel.m
//  MyTableViewDemo
//
//  Created by antdlxding on 8/6/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import "NavigationLabel.h"

static const CGFloat RED = 0.0;
static const CGFloat GREEN = 0.0;
static const CGFloat BLUE = 1.0;

@interface NavigationLabel ()
@property (nonatomic,assign) NSInteger LabelIndex;
@end

@implementation NavigationLabel

-(instancetype)initWithFrame:(CGRect)frame{
//    NSAssert(NO, @"you shoule not use this function, please use 'initWithFrame:withIndex' instead");
    return [self initWithFrame:frame withIndex:0];
}

-(instancetype)initWithFrame:(CGRect)frame withIndex:(NSInteger)index{
    _LabelIndex = index;
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        //如果是中间的标签就不设置圆角
        if (index != 1) {
            self.layer.cornerRadius = 5;
        }
        self.layer.borderWidth = 1.0;
        self.textColor = [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1.0];
        
    }
    return self;
}

//重写设置scale的方法，使得在外部修改scale的时候可以实现渐变的效果
-(void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    //颜色渐变，字体从默认的 0-0-1 变成 1.0 - 1.0 -1.0 ,背景相反
    CGFloat red = RED + scale;
    CGFloat green = GREEN +scale;
    CGFloat blue = BLUE;
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.layer.backgroundColor = [UIColor colorWithRed:(1-red) green:(1-green) blue:blue alpha:1.0].CGColor;
//    NSLog(@"LABEL_INDEX:%ld || scale is %f ; || red is %f ; green is %f", _LabelIndex,_scale,1-red,1-green);
    
    //大小缩放
    CGFloat transformScale = 1 + (scale * 0.15);
    //x,y方向的放缩倍数
//    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
    self.font = [UIFont systemFontOfSize:14 * transformScale];
    
}

@end
