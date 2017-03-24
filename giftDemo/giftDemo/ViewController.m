//
//  ViewController.m
//  giftDemo
//
//  Created by Content on 17/2/10.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "ViewController.h"
#import "GiftView.h"
#import "CollectionViewFlowLayout.h"
#import "BillViewController.h"
//随机色
#define LWLRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define SCREEN_SCALE ([ UIScreen mainScreen ].bounds.size.width/320)
#define AutoSize(px) ((kScreenHeight > kScreenWidth) ? ([UIScreen mainScreen].bounds.size.width/750)*(px) : ([UIScreen mainScreen].bounds.size.height/750)*(px))
@interface ViewController ()

@property(nonatomic, strong) GiftView *giftView;
@property(nonatomic, strong) NSArray *items;
@property(nonatomic, assign) NSUInteger pageCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *gesbView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight-AutoSize(220*2+96))];
    [self.view addSubview:gesbView];

    UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyboard)];
    [gesbView addGestureRecognizer:singalTap];
    
    UIButton *click = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, 100, 100, 100)];
    [click setTitle:@"送礼物" forState:UIControlStateNormal];
    [click setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [click addTarget:self action:@selector(clickGift) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:click];
    
    _giftView = [[GiftView  alloc]initWithShareViewToView:self.view];
    _giftView.hidden = YES;
    [self.view addSubview:_giftView];
    
    
    UIButton *billClick = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, 200, 100, 100)];
    [billClick setTitle:@"进入账单" forState:UIControlStateNormal];
    [billClick setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [billClick addTarget:self action:@selector(gotoBill) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:billClick];
    

}
- (void)hiddenKeyboard {
    
    if (!self.giftView.hidden) {
        
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.2;
        [_giftView.layer addAnimation:animation forKey:nil];
        _giftView.hidden = YES;
       
    }
    [self.view endEditing:YES];
}

-(void)clickGift{

    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
    [_giftView.layer addAnimation:animation forKey:nil];
    
    _giftView.hidden = NO;
}
-(void)gotoBill{

    BillViewController *bill = [[BillViewController alloc]init];
    [self presentViewController:bill animated:YES completion:NO];

}
@end
