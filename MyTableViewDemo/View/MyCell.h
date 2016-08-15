//
//  MyCell.h
//  MyTableViewDemo
//
//  Created by 丁龙翔 on 16/8/7.
//  Copyright © 2016年 antdlx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellModel;

@interface MyCell : UITableViewCell

//渲染cell的UI
-(void)GenerateCellWithModel:(CellModel * )model andTableView:(UITableView *)tableview andIndexPath:(NSIndexPath *)indexPath;

@end
