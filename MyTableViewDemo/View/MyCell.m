//
//  MyCell.m
//  MyTableViewDemo
//
//  Created by 丁龙翔 on 16/8/7.
//  Copyright © 2016年 antdlx. All rights reserved.
//

#import "MyCell.h"
#import "StarView.h"
#import "CellModel.h"
#import "UIImageView+CellAsyncImage.h"

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

//渲染每个cell的UI
-(void)GenerateCellWithModel:(CellModel *)model andTableView:(UITableView *)tableview andIndexPath:(NSIndexPath *)indexPath{
    UILabel *numLabel = [self viewWithTag:1];
    UIImageView *imageView = [self viewWithTag:2];
    UILabel *titleLabel = [self viewWithTag:3];
    UILabel *kindsLabel = [self viewWithTag:4];
    StarView * starView = [self viewWithTag:5];
    UILabel * UpNumLabel = [self viewWithTag:6];
    UIButton *button = [self viewWithTag:7];

    numLabel.text = model.cell_num;
    //从网络获取图片
    //method1: 直接下载
    //    NSURL * url = [NSURL URLWithString:model.image_url];
    //    NSData *image_data = [NSData dataWithContentsOfURL:url];
    //    imageView.image = [UIImage imageWithData:image_data];
    //method2：SDWebimageView
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    [imageView setImageViewWithURL:model.image_url andTableView:tableview andIndexPath:@[indexPath] andCellAnimation:UITableViewRowAnimationNone];
    
    
    titleLabel.text = model.title;
    
    kindsLabel.text = model.kinds;
    
    CGFloat percent = ((CGFloat)model.star_num / 1000);
    [starView setStarPercent:percent];
    
    UpNumLabel.text = [NSString stringWithFormat:@"( %ld )",(long)model.star_num];
    
    if ([model.price isEqualToString:@"0"]) {
        [button setTitle:@"免费" forState:UIControlStateNormal];
    }else{
        [button setTitle:[NSString stringWithFormat:@"￥%@",model.price] forState:UIControlStateNormal];
    }
}

@end
