//
//  MyCell.m
//  MyTableViewDemo
//
//  Created by 丁龙翔 on 16/8/7.
//  Copyright © 2016年 antdlx. All rights reserved.
//

#import "MyCell.h"
#import "StarView.h"

@interface MyCell ()

//通常会将cell中的组件通过属性的形式进行调用，而不是使用tag
//@property (nonatomic , strong) UILabel * cellNum;

@end

@implementation MyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UILabel * cellNum = [[UILabel alloc] initWithFrame:CGRectMake(8, 34, 23, 34)];
    cellNum.text = @"6";
    cellNum.font = [UIFont systemFontOfSize:20];
    cellNum.textAlignment = NSTextAlignmentCenter;
    cellNum.tag = 1;
    cellNum.backgroundColor  = [UIColor clearColor];
    cellNum.textColor = [UIColor grayColor];
    [self addSubview:cellNum];
    
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(37, 18, 64, 60)];
    image.image = [UIImage imageNamed:@"p.png"];
    image.tag = 2;
    [self.contentView addSubview:image];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(109, 7, 212, 40)];
    titleLabel.text = @"title";
    titleLabel.tag = 3;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.numberOfLines = 2;
    [self.contentView addSubview:titleLabel];
    
    UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(109, 54, 67, 23)];
    detailLabel.text = @"kinds";
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.tag = 4;
    [self.contentView addSubview:detailLabel];
    
    StarView *starView = [[StarView alloc ]initWithFrame:CGRectMake(109, 80, 84, 14) numberOfStars:5];
    starView.tag = 5;
    [self addSubview:starView];
    
    UILabel * upNum = [[UILabel alloc] initWithFrame:CGRectMake(214, 80, 50, 14)];
    upNum.text = @"( 666 )";
    upNum.textColor = [UIColor grayColor];
    upNum.textAlignment = NSTextAlignmentLeft;
    upNum.font = [UIFont systemFontOfSize:12];
    upNum.backgroundColor = [UIColor clearColor];
    upNum.tag = 6;
    [self.contentView addSubview:upNum];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(329, 33, 69, 30)];
    button.tag = 7;
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"btn" forState:UIControlStateNormal];
    //设置文字
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    //注意：设置按钮字体颜色不能使用button.titleLabel.textColor方式
    [button setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    button.titleLabel.text = @"￥ 18.00";
    //设置边框
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5.0];
    [button.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 1, 1 });
    //这里不支持UIColor，所以只能使用调色板自己用RGBA设置
    [button.layer setBorderColor:colorref];

    [self.contentView addSubview:button];
    
    return self;
    
}

@end
