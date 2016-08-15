//
//  UIImageView+CellAsyncImage.m
//  CellDownloadImage
//
//  Created by 丁龙翔 on 16/8/14.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import "UIImageView+CellAsyncImage.h"


static NSMutableDictionary * operations = nil;
static NSMutableDictionary * images = nil;
static NSOperationQueue * queue = nil;

@implementation UIImageView (CellAsyncImage)

+(void)SuspendQueue{
    if (queue == nil) {
        queue = [[NSOperationQueue alloc] init];
    }
    [queue setSuspended:YES];
}

+(void)RestartQueue{
    if (queue == nil) {
        queue = [[NSOperationQueue alloc] init];
    }
    [queue setSuspended:NO];
}

+(void)CancelQueueOperation{
    if (queue == nil) {
        queue = [[NSOperationQueue alloc] init];
    }
    [queue cancelAllOperations];
}

+(void)RemoveOperations{
    if (operations == nil) {
        operations = [NSMutableDictionary dictionary];
    }
    [operations removeAllObjects];
}

+(void)RemoveImages{
    if(images == nil){
        images = [NSMutableDictionary dictionary];
    }
    [images removeAllObjects];
}


-(void)setImageViewWithURL:(NSString *)url andTableView:(UITableView *)tableview andIndexPath:(NSArray<NSIndexPath *>  *)indexPath andCellAnimation:(UITableViewRowAnimation)animation{
    
    if(images == nil){
        images = [NSMutableDictionary dictionary];
    }
    if (operations == nil) {
        operations = [NSMutableDictionary dictionary];
    }
    if (queue == nil) {
        queue = [[NSOperationQueue alloc] init];
    }
    
    // 先从images缓存中取出图片url对应的UIImage
    UIImage *image = images[url];
    
    if (image) {//成功缓存过
        
        self.image = image;
        
    }else{ //缓存中没有图片
        
        // 获得caches的路径, 拼接文件路径
        NSString* CachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString* filePath = [CachesPath stringByAppendingPathComponent:[url lastPathComponent]];
        NSData* ImageData = [NSData dataWithContentsOfFile:filePath];
        
        if (ImageData) { // 缓存中有图片
            self.image = [UIImage imageWithData:ImageData];
        }else{ // 缓存中没有图片，需要下载
            
            // 显示占位图片
            self.image = [UIImage imageNamed:@"p.png"];
            //到子线程执行下载操作
            //取出当前URL对应的下载下载操作
            NSBlockOperation* operation = operations[url];
            if (nil == operation) {
                //创建下载操作
                operation = [NSBlockOperation blockOperationWithBlock:^{
                    
                    NSURL* _url = [NSURL URLWithString:url];
                    NSData* data =  [NSData dataWithContentsOfURL:_url];
                    UIImage* image = [UIImage imageWithData:data];
                    
                    //下载完成的图片放入缓存字典中
                    if (image) { //防止下载失败为空赋值造成崩溃
                        images[url] = image;
                        
                        //下载完成的图片存入沙盒中UIImage --> NSData --> File（文件）
                        NSData* ImageData = UIImagePNGRepresentation(image);
                        
                        [ImageData writeToFile:filePath atomically:YES];
                    }
                    
                    //回到主线程刷新表格
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        // 从字典中移除下载操作 (防止operations越来越大，保证下载失败后，能重新下载)
                        [operations removeObjectForKey:url];
                        //indexPath是会造成重用错位的问题的，这里不能这样写。因为这是UIImageView的category，所以直接self设置image就可以了
//                        [tableview reloadRowsAtIndexPaths:indexPath withRowAnimation:animation];
                        self.image = image;
                    }];
                }];
                //添加操作到队列中
                [queue addOperation:operation];
                //添加到字典中
                operations[url] = operation;
                
            }
        }
    }
    
}

@end
