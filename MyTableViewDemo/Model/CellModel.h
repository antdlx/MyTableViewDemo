//
//  CellModel.h
//  MyTableViewDemo
//
//  Created by zhangwen on 8/7/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property(nonatomic,copy) NSString * image;
@property(nonatomic,copy) NSString * titleLabel;
@property(nonatomic,copy) NSString * kindsLabel;
@property(nonatomic,copy) NSString * priceButtonText;
@property(nonatomic,copy) NSString * cellNumLabel;
@property(nonatomic,assign) NSInteger starNum;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)CellWithDict:(NSDictionary *)dict;

@end
