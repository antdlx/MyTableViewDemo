//
//  CellModel.m
//  MyTableViewDemo
//
//  Created by zhangwen on 8/7/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import "CellModel.h"

@interface CellModel()

@end



@implementation CellModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

+(instancetype)CellWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end
