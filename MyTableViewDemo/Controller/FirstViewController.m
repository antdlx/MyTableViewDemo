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
//    for (int i = 0; i < 15; ++i) {
//        CellModel * model = [CellModel CellWithDict:[NSDictionary dictionaryWithObjectsAndKeys:@"p.png",@"image",[NSString stringWithFormat:@"item %d",i+1],@"titleLabel",@"游戏",@"kindsLabel",@"￥5.00",@"priceButtonText",[NSString stringWithFormat:@"%d",i+1],@"cellNumLabel", @300,@"starNum",nil]];
//        [_datas addObject:model];
//    }
    
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
    NSLog(@"numberOfRowsInSection %lu",(unsigned long)[_datas count]);
    return [_datas count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * index = @"cell";
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:index];
    }
    
    NSInteger rowCount = indexPath.row;
    UILabel *numLabel = [cell viewWithTag:1];
    UIImageView *imageView = [cell viewWithTag:2];
    UILabel *titleLabel = [cell viewWithTag:3];
    UILabel *kindsLabel = [cell viewWithTag:4];
    StarView * starView = [cell viewWithTag:5];
    UILabel * UpNumLabel = [cell viewWithTag:6];
    UIButton *button = [cell viewWithTag:7];
    
    
    CellModel * model = _datas[rowCount];
    numLabel.text = model.cell_num;
    //从网络获取图片
    NSURL * url = [NSURL URLWithString:model.image_url];
    NSData *image_data = [NSData dataWithContentsOfURL:url];
    imageView.image = [UIImage imageWithData:image_data];
    
    titleLabel.text = model.title;
    
    kindsLabel.text = model.kinds;
    
    CGFloat percent = ((CGFloat)model.star_num / 1000);
    [starView setStarPercent:percent];
    
    UpNumLabel.text = [NSString stringWithFormat:@"( %ld )",(long)model.star_num];
    
    if ([model.price isEqualToString:@"0"]) {
        [button setTitle:@"免费" forState:UIControlStateNormal];
    }else{
        [button setTitle:[NSString stringWithFormat:@"￥%@",model.price] forState:UIControlStateNormal];
    }
    
    NSLog(@"cellForRowAtIndexPath");
    return cell;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
}

@end
