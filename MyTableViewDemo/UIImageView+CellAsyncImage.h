//
//  UIImageView+CellAsyncImage.h
//  CellDownloadImage
//
//  Created by 丁龙翔 on 16/8/14.
//  Copyright © 2016年 洪峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CellAsyncImage)

//从外部终止队列继续加载任务
+(void)SuspendQueue;
//重启队列加载任务
+(void)RestartQueue;
//异步下载的方法
-(void)setImageViewWithURL:(NSString *) url andTableView:(UITableView *)tableview andIndexPath:(NSArray<NSIndexPath *>  *)indexPath andCellAnimation:(UITableViewRowAnimation) animation;
//资源清理的三个方法
+(void)CancelQueueOperation;
+(void)RemoveImages;
+(void)RemoveOperations;

@end
