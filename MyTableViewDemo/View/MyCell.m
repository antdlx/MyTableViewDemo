//
//  MyCell.m
//  MyTableViewDemo
//
//  Created by 丁龙翔 on 16/8/7.
//  Copyright © 2016年 antdlx. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()

@end

@implementation MyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 6, 56, 51)];
    image.image = [UIImage imageNamed:@"p.png"];
    image.tag = 1;
    [self.contentView addSubview:image];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(79, 6, 250, 20)];
    titleLabel.text = @"title";
    titleLabel.tag = 2;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:titleLabel];
    
    UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(79, 34, 250, 23)];
    detailLabel.text = @"detail";
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.font = [UIFont systemFontOfSize:17];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.tag = 3;
    [self.contentView addSubview:detailLabel];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(337, 19, 54, 26)];
    button.tag = 4;
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"btn" forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:17];

    [self.contentView addSubview:button];
    
    return self;
    
}

@end
