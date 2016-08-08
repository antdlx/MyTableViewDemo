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
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 708)];
    [self.view addSubview:tableView];
    
    _datas = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 15; ++i) {
        CellModel * model = [CellModel CellWithDict:[NSDictionary dictionaryWithObjectsAndKeys:@"p.png",@"image",[NSString stringWithFormat:@"item %d",i+1],@"titleLabel",@"游戏",@"kindsLabel",@"￥5.00",@"priceButtonText",[NSString stringWithFormat:@"%d",i+1],@"cellNumLabel", @300,@"starNum",nil]];
        [_datas addObject:model];
    }
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
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
    UILabel *titleLabel = [cell viewWithTag:3];
    UILabel *kindsLabel = [cell viewWithTag:4];
    StarView * starView = [cell viewWithTag:5];
    UILabel * UpNumLabel = [cell viewWithTag:6];
    UIButton *button = [cell viewWithTag:7];
    
    CellModel * model = _datas[rowCount];
    numLabel.text = model.cellNumLabel;
    titleLabel.text = model.titleLabel;
    kindsLabel.text = model.kindsLabel;
    CGFloat percent = ((CGFloat)model.starNum / 1000);
    NSLog(@"starNum is %ld ; percent is %f",(long)model.starNum,percent);
    [starView setStarPercent:percent];
    UpNumLabel.text = [NSString stringWithFormat:@"( %ld )",(long)model.starNum];
    [button setTitle:model.priceButtonText forState:UIControlStateNormal];
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
