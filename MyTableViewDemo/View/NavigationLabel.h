//
//  NavigationLabel.h
//  MyTableViewDemo
//
//  Created by antdlxding on 8/6/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationLabel : UILabel

//缩放动画比例
@property(nonatomic,assign) CGFloat scale;
-(instancetype)initWithFrame:(CGRect)frame withIndex:(NSInteger) index;
@end
