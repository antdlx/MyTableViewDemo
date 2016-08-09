//
//  StarView.m
//  MyTableViewDemo
//
//  Created by antdlxding on 8/8/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import "StarView.h"

static const NSInteger DEAFAULT_STAR_NUM = 5;
static NSString * const ICON_STAR_YELLOW = @"icon_star_yellow.png";
static NSString * const ICON_STAR_GRAY = @"icon_star_gray.png";

@interface StarView ()

@property(nonatomic,assign) NSInteger numberOfStars;
@property(nonatomic,strong) UIView * foregroundStarView;
@property(nonatomic,strong) UIView * backgoundStarView;

@end

@implementation StarView

-(instancetype)init{
    NSAssert(NO, @"you should not use this method to init, please use initWithFrame:numberOfStars");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:DEAFAULT_STAR_NUM];
}


- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        [self initUi];
    }
    return self;
}

-(void)initUi{
    //默认4.5颗星
    _starPercent = 0.9;
    
    _foregroundStarView = [self createStarWithImageName:ICON_STAR_YELLOW];
    _backgoundStarView = [self createStarWithImageName:ICON_STAR_GRAY];
    
    [self addSubview:_backgoundStarView];
    [self addSubview:_foregroundStarView];
}


-(UIView *)createStarWithImageName:(NSString *) imageName{
    UIView * view = [[UIView alloc] initWithFrame:self.bounds];
    //子视图超过父视图边界的部分会被裁剪
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    
    for(int i = 0 ; i < _numberOfStars ; ++i){
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake( i * self.bounds.size.width / _numberOfStars, 0, self.bounds.size.width / _numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    
    return view;
}

-(void)setStarPercent:(CGFloat)starPercent{
    _starPercent = starPercent;
    if (_starPercent > 1) {
        _starPercent = 1;
    }
    if (_starPercent < 0) {
        _starPercent = 0;
    }
     _foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width * self.starPercent, self.bounds.size.height);
}

@end
