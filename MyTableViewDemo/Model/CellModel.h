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
@property(nonatomic,copy) NSString * detailLabel;
@property(nonatomic,copy) NSString * buttonText;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)CellWithDict:(NSDictionary *)dict;

@end
