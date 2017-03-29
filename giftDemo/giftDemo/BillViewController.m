//
//  BillViewController.m
//  giftDemo
//
//  Created by Content on 17/2/14.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "BillViewController.h"
#import "MJRefresh.h"
#import "ReceiveGiftCell.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define AutoSize(px) ((kScreenHeight > kScreenWidth) ? ([UIScreen mainScreen].bounds.size.width/750)*(px) : ([UIScreen mainScreen].bounds.size.height/750)*(px))
#define kUIFont(size)    [UIFont systemFontOfSize:size]

@interface BillViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIScrollView*myScrollView;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIView * bottomLine;

@property(nonatomic,strong)UITableView *tableView1;
@property(nonatomic,strong)UITableView *tableView2;
@property(nonatomic,strong)UITableView *tableView3;

@property(nonatomic,copy)NSArray *iconArray;
@property(nonatomic,copy)NSArray *nameArray;
@property(nonatomic,copy)NSArray *numArray;
@end

@implementation BillViewController
-(void)popLast{

    [self dismissViewControllerAnimated:YES completion:nil];
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _iconArray = [[NSArray alloc]init];
    _nameArray = [[NSArray alloc]init];
    _numArray = [[NSArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    back.titleLabel.font = kUIFont(15);
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(popLast) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    //title切换
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, AutoSize(72))];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, AutoSize(1))];
    [titleView addSubview:topLine];
    topLine.backgroundColor = [UIColor lightGrayColor];
    topLine.alpha = 0.5;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, AutoSize(18), kScreenWidth/3, AutoSize(36))];
    btn1.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:AutoSize(36)];
    [titleView addSubview:btn1];
    //[btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(receviewGift:) forControlEvents:UIControlEventTouchUpInside];
    _btn1 = btn1;
    btn1.selected = YES;
    [btn1 setTitle:@"收到的礼物" forState:UIControlStateNormal];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/3, AutoSize(18), kScreenWidth/3, AutoSize(36))];
    [titleView addSubview:btn2];
    btn2.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:AutoSize(28)];
    [btn2 setTitle:@"送出的礼物" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(sendGift:) forControlEvents:UIControlEventTouchUpInside];
    _btn2 = btn2;
    
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, AutoSize(18), kScreenWidth/3, AutoSize(36))];
    [titleView addSubview:btn3];
    btn3.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:AutoSize(28)];
    [btn3 setTitle:@"充值记录" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn3 addTarget:self action:@selector(rechargeRecord:) forControlEvents:UIControlEventTouchUpInside];
    _btn3 = btn3;
    
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, AutoSize(60), kScreenWidth/3, AutoSize(12))];
    bottomLine.backgroundColor = [UIColor blackColor];
    _bottomLine = bottomLine;
    [titleView addSubview:bottomLine];

    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, AutoSize(72)+64,kScreenWidth, kScreenHeight-AutoSize(72)-64)];
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.delegate = self;
    _myScrollView.contentSize = CGSizeMake(kScreenWidth *3, kScreenHeight-AutoSize(72)-64);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.scrollsToTop = NO;
    _myScrollView.scrollEnabled = NO;
    
    [self.view addSubview:_myScrollView];

    
    //电影tableView
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h-AutoSize(72)-64) style:UITableViewStylePlain];
    //_tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.separatorColor = [UIColor clearColor];
    _tableView1.backgroundColor = [UIColor whiteColor];
    //_tableView1.allowsSelectionDuringEditing = YES;
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    [_myScrollView addSubview:_tableView1];
    
    //资讯微视tableView
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, self.view.mj_w, self.view.mj_h-AutoSize(72)-64) style:UITableViewStylePlain];
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.separatorColor = [UIColor clearColor];
    _tableView2.backgroundColor = [UIColor whiteColor];
    _tableView2.allowsSelectionDuringEditing = YES;
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.tag = 1;
   // [_myScrollView addSubview:_tableView2];

    
    //第一次进入页面网络请求
    [self getData];
}
-(void)getData{

    _iconArray = @[@"bidong",@"money",@"bidong"];
    _nameArray = @[@"flymanshow",@"chenchen",@"xiaoxin"];
    _numArray = @[@(3),@(5),@(7)];
    
    [self.tableView1 reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"ReceiveGiftCell";
    
    ReceiveGiftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if(!cell){
    
        cell = [[ReceiveGiftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = NO;
        
        [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.iconArray[indexPath.row]]]];
        cell.name.text = self.nameArray[indexPath.row];
        cell.moneyNum.text = [NSString stringWithFormat:@"%@",self.numArray[indexPath.row]];
    }
   

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 60;
}
#pragma mark --收到的礼物
-(void)receviewGift:(UIButton *)sender{
    
    
   _bottomLine.mj_x = 0;
    
    _btn2.selected = NO;
    sender.selected = YES;
    sender.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:AutoSize(36)];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:AutoSize(28)];
    _btn3.titleLabel.font = [UIFont systemFontOfSize:AutoSize(28)];

    
    [_myScrollView setContentOffset:CGPointMake(0, 0)];
    
}
#pragma mark --送出的礼物
-(void)sendGift:(UIButton *)sender{
    
    _bottomLine.mj_x = kScreenWidth/3;

    sender.selected = YES;
    _btn1.selected = NO;
    
    sender.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:AutoSize(36)];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:AutoSize(28)];
    
    _btn3.titleLabel.font = [UIFont systemFontOfSize:AutoSize(28)];

    [_myScrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
   
    
    
}
#pragma mark --充值记录
-(void)rechargeRecord:(UIButton *)sender{

    _bottomLine.mj_x = kScreenWidth/3*2;
    sender.selected = YES;
    _btn1.selected = NO;
    
    sender.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:AutoSize(36)];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:AutoSize(28)];

    _btn2.titleLabel.font = [UIFont systemFontOfSize:AutoSize(28)];

    [_myScrollView setContentOffset:CGPointMake(kScreenWidth*2, 0)];


}

@end
