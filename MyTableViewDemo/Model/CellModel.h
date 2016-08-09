//
//  CellModel.h
//  MyTableViewDemo
//
//  Created by zhangwen on 8/7/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property(nonatomic,copy) NSString * image_url;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * kinds;
@property(nonatomic,copy) NSString * price;
@property(nonatomic,copy) NSString * cell_num;
@property(nonatomic,assign) NSInteger star_num;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)CellWithDict:(NSDictionary *)dict;

@end
