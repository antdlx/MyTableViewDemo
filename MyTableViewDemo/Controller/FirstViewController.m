//
//  FirstViewController.m
//  MyTableViewDemo
//
//  Created by zhangwen on 8/6/16.
//  Copyright © 2016 antdlx. All rights reserved.
//

#import "FirstViewController.h"
#import "CellModel.h"
#import "MyCell.h"
#import "StarView.h"
//#import "UIImageView+WebCache.h"
#import "UIImageView+CellAsyncImage.h"

@interface FirstViewController() <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic) NSMutableArray *datas;
@end

@implementation FirstViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    

    NSLog(@"First Load");
    self.view.backgroundColor = [UIColor blueColor];
    //106是从storyboard中看到的y的偏移量
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-106)];
    [self.view addSubview:tableView];
    
    _datas = [[NSMutableArray alloc]init];
    
    [self initDatas];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
}

//加载plist中的数据
-(void)initDatas{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"list_datas" ofType:@"plist"];
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    for (int i = 1 ; i  <= [root count] ; ++i) {
        CellModel *model = [CellModel CellWithDict:root[[NSString stringWithFormat:@"cell_data%d",i]]];
        [_datas addObject:model];
    }
}


#pragma mark - <UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * index = @"cell";
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
    }
    
    NSInteger rowCount = indexPath.row;
    CellModel * model = _datas[rowCount];
    //最好不要在这里渲染cell的代码可以写到MyCell中去，传一个cellModel过去,所以使用以下这个方法
    [cell GenerateCellWithModel:model andTableView:tableView andIndexPath:indexPath];
    
    return cell;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    //内存警告时释放占用的资源
    [UIImageView CancelQueueOperation];
    [UIImageView RemoveImages];
    [UIImageView RemoveOperations];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
}

//为了防止cell重用导致的错位加载问题，只有在滑动结束的时候才继续下载任务
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [UIImageView RestartQueue];
}

//为了防止cell重用导致的错位加载问题，在滑动的时候暂停任务队列中的任务（其实是不添加新的任务）
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIImageView SuspendQueue];
}

@end
