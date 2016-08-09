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

//bug1：从标签1跳至标签3，标签1来不及完全变成白色。修复思路：在滑动结束的方法中判断当前是否是【滑动过后】的【第1/3】个标签，手动将另外一个来不及变色的设Scale为0；
//修复bug1需要使用到的标记当前标签号的
static NSInteger currentLabel = 0;
//修补bug1使用到的标记scroll是否滑动过
static bool isScrolled = NO;

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
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-120)/3;
    CGFloat height = self.titleScrollView.frame.size.height;
    
    //**frame是相对于父组件的**
    //设置左边的导航标签
    NavigationLabel * navigationLeft = [[NavigationLabel alloc] initWithFrame:CGRectMake(0, 0, width, height) withIndex:0];
    navigationLeft.tag = 0;
    navigationLeft.text = [self.childViewControllers[0] title];
    //添加监听器
    UITapGestureRecognizer *tgrL = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [navigationLeft addGestureRecognizer:tgrL];
    navigationLeft.scale = 1.0;
    
    //设置中间的导航标签
    NavigationLabel * navigationMiddle = [[NavigationLabel alloc] initWithFrame:CGRectMake(width-5, 0, width-5, height) withIndex:1];
    navigationMiddle.tag = 1;
    navigationMiddle.text = [self.childViewControllers[1] title];
    UITapGestureRecognizer *tgrM = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [navigationMiddle addGestureRecognizer:tgrM];
    
    //设置右边的导航标签
    NavigationLabel * navigationLabelRight = [[NavigationLabel alloc]initWithFrame:CGRectMake(2 * width-15, 0, width, height) withIndex:2];
    navigationLabelRight.tag = 2;
    navigationLabelRight.text = [self.childViewControllers[2] title];
    UITapGestureRecognizer *tgrR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [navigationLabelRight addGestureRecognizer:tgrR];
    
    //添加标签
    [self.titleScrollView addSubview:navigationLeft];
    [self.titleScrollView addSubview:navigationLabelRight];
    [self.titleScrollView addSubview:navigationMiddle];
    
    //设置导航栏
    self.titleScrollView.contentSize = CGSizeMake(width * self.childViewControllers.count, height);
    self.titleScrollView.bounces = NO;
    
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
    
    //修复bug1，如果是滑动之后停下来的，且滑动最后停止在第一（三）个标签，就手动把第三（一）个设置Scale=0；
    if (currentLabel  == 2 && isScrolled) {
        NavigationLabel * label = self.titleScrollView.subviews[0];
        label.scale = 0.0;
    }
    if (currentLabel == 0 && isScrolled) {
        NavigationLabel * label = self.titleScrollView.subviews[1];
        label.scale = 0.0;
    }
    isScrolled = NO;
    
    //需要的临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //当前ViewController的索引
    NSInteger index =offsetX / width;
    
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

//ScrollView滚动时调用，所有滚动的切显示出的scrollView的内容都会调用这个方法，通常是两个页面（正在切换的左右两个页面）执行这个方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //TitleScrollView的滑动逻辑
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
//    NSLog(@"contentOffset.X is %f ; frameSizeWidth is %f ; scale is %f",scrollView.contentOffset.x ,scrollView.frame.size.width,scale);
    
    //修补bug1需要使用的全局变量
    currentLabel = scale;
    isScrolled = YES;
    
    // 获取需要操作的的左边的Label
    NSInteger leftIndex = scale;
    // 获取需要操作的右边的Label
    NSInteger rightIndex = scale + 1;
    //因为上面初始化的时候采用的方案：中间标签在最上面覆盖圆角，subviews的顺序需要作出一些调整
    NSInteger leftIndexOffset = leftIndex;
    NSInteger rightIndexOffset = rightIndex;
    switch (leftIndex) {
        case 0:
            rightIndexOffset = 2;
            break;
        case 1:
            ++leftIndexOffset;
            rightIndexOffset = 1;
            break;
        case 2:
            --leftIndexOffset;
            rightIndexOffset = 3;
            break;
        default:
            break;
    }
    
    NavigationLabel *leftLabel = self.titleScrollView.subviews[leftIndexOffset];
    
    NavigationLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count ) ?  nil : self.titleScrollView.subviews[rightIndexOffset];
    // 右边的比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1- rightScale;
    
    // 设置Label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
    
}


@end
