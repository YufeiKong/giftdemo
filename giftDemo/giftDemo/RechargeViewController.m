//
//  RechargeViewController.m
//  giftDemo
//
//  Created by Content on 17/2/14.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "RechargeViewController.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define AutoSize(px) ((kScreenHeight > kScreenWidth) ? ([UIScreen mainScreen].bounds.size.width/750)*(px) : ([UIScreen mainScreen].bounds.size.height/750)*(px))
#define kUIFont(size)    [UIFont systemFontOfSize:size]
@interface RechargeViewController ()
@property(nonatomic,strong)UIButton *moneyBtn;
@property(nonatomic,assign)NSInteger selectedIndex;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.selectedIndex = 0;
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIImageView *money = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-AutoSize(100))/2, AutoSize(200), AutoSize(100), AutoSize(100))];
    [money setImage:[UIImage imageNamed:@"money2"]];
    [self.view addSubview:money];
    
    UILabel *moneyNUM = [[UILabel alloc]initWithFrame:CGRectMake(0, AutoSize(300), kScreenWidth, AutoSize(100))];
    moneyNUM.textAlignment = NSTextAlignmentCenter;
    moneyNUM.textColor = [UIColor yellowColor];
    moneyNUM.font = [UIFont systemFontOfSize:60];
    moneyNUM.text = @"130";
    [self.view addSubview:moneyNUM];
    
    UILabel *moneyName = [[UILabel alloc]initWithFrame:CGRectMake(0, AutoSize(430), kScreenWidth, AutoSize(60))];
    moneyName.textAlignment = NSTextAlignmentCenter;
    moneyName.textColor = [UIColor whiteColor];
    moneyName.font = [UIFont systemFontOfSize:14];
    moneyName.text = @"W币";
    [self.view addSubview:moneyName];
   
    NSInteger margin_x = (kScreenWidth/3-AutoSize(200))/2;

    for (int i=0; i<6; i++) {
        
        if (i<3) {
            
         _moneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin_x+2*i*margin_x+AutoSize(200)*i, AutoSize(500), AutoSize(200), AutoSize(88))];
        }else{
            
            _moneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin_x+2*(i-3)*margin_x+AutoSize(200)*(i-3), AutoSize(500+150), AutoSize(200), AutoSize(88))];
        }
       
        _moneyBtn.tag = i+1221;
        if (i==0) {
            
            _moneyBtn.backgroundColor = [UIColor whiteColor];
            [_moneyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [_moneyBtn addTarget:self action:@selector(chooseMoneybtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_moneyBtn];
        _moneyBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _moneyBtn.layer.borderWidth = AutoSize(2);
        _moneyBtn.layer.masksToBounds = YES;
        _moneyBtn.layer.cornerRadius = 20;
        _moneyBtn.backgroundColor = [UIColor blackColor];
        _moneyBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_moneyBtn setTitle:@"11W币\n￥0.00" forState:UIControlStateNormal];
        [_moneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
    
    UIButton * buyBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-AutoSize(300))/2, AutoSize(1000), AutoSize(300), AutoSize(70))];
    [buyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buyBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor whiteColor];
    buyBtn.enabled = YES;
    buyBtn.layer.cornerRadius = AutoSize(36);
    buyBtn.layer.masksToBounds = YES;
    buyBtn.titleLabel.font = kUIFont(AutoSize(36));
    [buyBtn addTarget:self action:@selector(rechargeMoney) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    
    
    UIButton *isChoose = [[UIButton alloc]initWithFrame:CGRectMake(AutoSize(20), AutoSize(1150), AutoSize(30), AutoSize(30))];
    [isChoose setImage:[UIImage imageNamed:@"ischoose"] forState:UIControlStateNormal];
    [self.view addSubview:isChoose];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(AutoSize(55), AutoSize(1150), AutoSize(300), AutoSize(30))];
    title1.text = @"我已阅读并同意";
    title1.textColor = [UIColor whiteColor];
    [self.view addSubview:title1];
    
    UIButton *protocol = [[UIButton alloc]initWithFrame:CGRectMake(AutoSize(280), AutoSize(1150), AutoSize(300), AutoSize(30))];
    [protocol setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [protocol setTitle:@"《用户充值协议》" forState:UIControlStateNormal];
    //protocol.titleLabel.font = kUIFont(AutoSize(30));
    [self.view addSubview:protocol];
    
    UIButton *helpBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-AutoSize(200))/2, AutoSize(1250), AutoSize(200), AutoSize(30))];
    [helpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [helpBtn setTitle:@"充值帮助" forState:UIControlStateNormal];
    helpBtn.titleLabel.font = kUIFont(AutoSize(30));
    [self.view addSubview:helpBtn];
}
#pragma mark ----选择金币种类
-(void)chooseMoneybtn:(UIButton *)sender{
   
    if (sender.tag-1221 == self.selectedIndex) {
        return;
    }
    //sender.selected = YES;
    NSLog(@"%ld",(long)sender.tag-1221);
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  
    UIView *view = sender.superview;
    UIButton *btn = (UIButton *)(view.subviews[self.selectedIndex+3]);
    
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // btn.selected = NO;
    self.selectedIndex = sender.tag-1221;
}
#pragma mark ---充值
-(void)rechargeMoney{

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请确认您的App内购买项目" message:@"您相以￥00.00的价格买一个W币吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //handler为手势方法添加处，这里就代替了之前UIAlertView中的代理协议方法,十分方便
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
