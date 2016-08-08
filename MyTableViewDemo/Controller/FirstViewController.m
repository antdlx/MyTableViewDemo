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
        CellModel * model = [CellModel CellWithDict:[NSDictionary dictionaryWithObjectsAndKeys:@"p.png",@"image",[NSString stringWithFormat:@"item %d",i+1],@"titleLabel",[NSString stringWithFormat:@"this is detail of item %d",i+1],@"detailLabel",@"￥5.00",@"buttonText", nil]];
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
    UILabel *titleLabel = [cell viewWithTag:2];
    UILabel *detailsLabel = [cell viewWithTag:3];
    UIButton *button = [cell viewWithTag:4];
    
    CellModel * model = _datas[rowCount];
    titleLabel.text = model.titleLabel;
    detailsLabel.text = model.detailLabel;
    [button setTitle:model.buttonText forState:UIControlStateNormal];
    NSLog(@"cellForRowAtIndexPath");
    return cell;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

@end
