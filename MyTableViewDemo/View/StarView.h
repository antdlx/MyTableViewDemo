//
//  StarView.h
//  MyTableViewDemo
//
//  Created by antdlxding on 8/8/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

// 0 - 1
@property(nonatomic,assign) CGFloat starPercent;

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger) numberOfStars;

@end
