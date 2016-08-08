//
//  HomeViewController.m
//  MyTableViewDemo
//
//  Created by zhangwen on 8/6/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import "HomeViewController.h"
#import "FirstViewController.h"
#import "NavigationLabel.h"

#define MAINSCREENWIDTH [UIScreen mainScreen].bounds.size.width;
#define MAINSCREENHEIGHT [UIScreen mainScreen].bounds.size.height;

@interface HomeViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation HomeViewController

-(void)viewDidLoad{
    //不要自动设置内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewControllers];
    [self addNavigationLabels];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    
}

//添加子ViewController
-(void)addChildViewControllers{
    
    FirstViewController *fvc1 = [[FirstViewController alloc] init];
    fvc1.title = @"First";
    [self addChildViewController:fvc1];
    
    FirstViewController *fvc2 = [[FirstViewController alloc] init];
    fvc2.title = @"Second";
    [self addChildViewController:fvc2];
    
    FirstViewController *fvc3 = [[FirstViewController alloc] init];
    fvc3.title = @"Third";
    [self addChildViewController:fvc3];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    //**注意：contentSize如果最后的height设置为size.height的话，在换页的时候会出现上下滑动**
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * size.width, 0);
    
    self.contentScrollView.pagingEnabled = YES;
    //防止上下两个ScrollView不协调，禁止越界行为
    self.contentScrollView.bounces = NO;
    
    
}

//添加导航栏标签
-(void)addNavigationLabels{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/3;
    CGFloat height = self.titleScrollView.frame.size.height;
    
    //添加子导航栏Label
    for(NSInteger i = 0 ; i < self.childViewControllers.count ; ++i){
        NavigationLabel * navigationLabel = [[NavigationLabel alloc]init];
        navigationLabel.tag = i;
        navigationLabel.frame = CGRectMake(i * width, 0, width, height);
        navigationLabel.text = [self.childViewControllers[i] title];
        
        //添加监听器
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [navigationLabel addGestureRecognizer:tgr];
        [self.titleScrollView addSubview:navigationLabel];
        
        if (i == 0) {
            navigationLabel.scale = 1.0;
        }
        
        //设置导航栏
        self.titleScrollView.contentSize = CGSizeMake(width * self.childViewControllers.count, height);
        self.titleScrollView.bounces = NO;
        
    }
    
}

//手势监听器
-(void)tap:(UIGestureRecognizer *)recognizer{
    NSInteger index = recognizer.view.tag;
    
    // 定位到指定位置。contentOffset是当前显示的区域的origin相对于整个scrollView的origin的位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * MAINSCREENWIDTH;
    
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

//当滑动结束时会调用这个方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //当前ViewController的索引
    NSInteger index =offsetX / width;
    
    // 让对应的顶部标题居中显示
    NavigationLabel *navigationLabel = self.titleScrollView.subviews[index];
    CGPoint titleOffsetX = self.titleScrollView.contentOffset;
    titleOffsetX.x = navigationLabel.center.x - width/2;
    // 左边偏移量边界
    if(titleOffsetX.x < 0) {
        titleOffsetX.x = 0;
    }
    
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - width;
    // 右边偏移量边界
    if(titleOffsetX.x > maxOffsetX) {
        titleOffsetX.x = maxOffsetX;
    }
    
    // 修改偏移量
    self.titleScrollView.contentOffset = titleOffsetX;
    
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 如果当前位置的控制器已经显示过了，就直接返回，不需要重复添加控制器的view
    if([willShowVc isViewLoaded]) return;
    
    // 如果没有显示过，则将控制器的view添加到contentScrollView上
    willShowVc.view.frame = CGRectMake(index * width, 0, width, height);
    
    [scrollView addSubview:willShowVc.view];
    
}

//  当手指抬起停止减速的时候会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//ScrollView滚动时调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //TitleScrollView的滑动逻辑
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 获取需要操作的的左边的Label
    NSInteger leftIndex = scale;
    NavigationLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    // 获取需要操作的右边的Label
    NSInteger rightIndex = scale + 1;
    NavigationLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ?  nil : self.titleScrollView.subviews[rightIndex];
    
    // 右边的比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1- rightScale;
    
    // 设置Label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;

}


@end
