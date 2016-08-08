//
//  NavigationLabel.m
//  MyTableViewDemo
//
//  Created by zhangwen on 8/6/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import "NavigationLabel.h"

static const CGFloat RED = 0.4;
static const CGFloat GREEN = 0.6;
static const CGFloat BLUE = 0.7;

@implementation NavigationLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        self.textColor = [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1.0];
        
    }
    return self;
}

//重写设置scale的方法，使得在外部修改scale的时候可以实现渐变的效果
-(void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    //颜色渐变，从默认的 0.4-0.6-0.7 变成 1.0 - 0.0 -0.0
    CGFloat red = RED + (1 - RED) * scale;
    CGFloat green = GREEN + (- GREEN) * scale;
    CGFloat blue = BLUE + (- BLUE) * scale;
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    //大小缩放
    CGFloat transformScale = 1 + (scale * 0.35);
    //x,y方向的放缩倍数
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
    
    
}

@end
