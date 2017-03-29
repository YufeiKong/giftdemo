//
//  ShareView.m
//  WECAST
//
//  Created by Content on 17/1/9.
//  Copyright © 2017年 YOD. All rights reserved.
//

#import "GiftView.h"
#import "CollectionViewFlowLayout.h"
#import "RechargeViewController.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define AutoSize(px) ((kScreenHeight > kScreenWidth) ? ([UIScreen mainScreen].bounds.size.width/750)*(px) : ([UIScreen mainScreen].bounds.size.height/750)*(px))
#define kUIFont(size)    [UIFont systemFontOfSize:size]
//随机色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define SCREEN_SCALE  ([ UIScreen mainScreen ].bounds.size.width/320)


@interface CollectionCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *iconImg;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *moneyNum;
@property(nonatomic,strong) UIImageView *moneyImg;
@property(nonatomic,strong) UIView *leftLine;
@property(nonatomic,strong) UIView *rightLine;
@property(nonatomic,strong) UIView *bottomLine;
@property(nonatomic,strong) UIView *around_line;
@end

@implementation CollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        _around_line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4, AutoSize(220))];
//        _around_line.layer.borderColor = [UIColor greenColor].CGColor;
//        _around_line.layer.borderWidth = AutoSize(2);
//        _around_line.hidden = YES;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize(20), kScreenWidth/4, AutoSize(28))];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        
        _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth/4-AutoSize(120))/2, AutoSize(48), AutoSize(120), AutoSize(120))];
        _iconImg.userInteractionEnabled = YES;
        
        _moneyNum = [[UILabel alloc]initWithFrame:CGRectMake(AutoSize(60), AutoSize(168), AutoSize(40), AutoSize(28))];
        _moneyNum.textColor = [UIColor whiteColor];
        _moneyNum.font = [UIFont systemFontOfSize:14];
     
        _moneyImg = [[UIImageView alloc]initWithFrame:CGRectMake(AutoSize(89), AutoSize(165), AutoSize(40), AutoSize(40))];
        
        _leftLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoSize(1), AutoSize(220))];
        _leftLine.backgroundColor = [UIColor lightGrayColor];
        _leftLine.hidden = YES;
        
        _rightLine = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4-AutoSize(1), 0, AutoSize(1), AutoSize(220))];
        _rightLine.backgroundColor = [UIColor lightGrayColor];
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, AutoSize(219), kScreenWidth/4, AutoSize(1))];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
        
        //[self.contentView addSubview:_around_line];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_iconImg];
        [self.contentView addSubview:_moneyNum];
        [self.contentView addSubview:_moneyImg];
        [self.contentView addSubview:_leftLine];
        [self.contentView addSubview:_rightLine];
        [self.contentView addSubview:_bottomLine];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
    }
    return self;
}

@end

@interface CollectionCellWhite : CollectionCell

@end

@implementation CollectionCellWhite

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
    }
    return self;
}

@end

@interface GiftView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *items;
@property(nonatomic, assign) NSUInteger pageCount;
@property(nonatomic,strong)UIPageControl *PageControl;
@end

@implementation GiftView


- (id)initWithShareViewToView:(UIView *)designView{

    self = [super initWithFrame:CGRectMake(0, kScreenHeight-AutoSize(96+220*2), kScreenWidth, AutoSize(96+220*2))];
    if (self) {
      
        self.selectedIndex = 1;
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, AutoSize(440))];
        _topView.backgroundColor  = [UIColor blackColor];
        _topView.alpha = 0.8;
        [self addSubview:_topView];
   
        self.titleArray = @[@"一堆W币", @"W币礼盒", @"小红花", @"棒棒糖", @"钻石", @"糖糖", @"星星", @"甜甜圈", @"一辆车", @"一栋别墅"];
        NSLog(@"%lu--self.titleArray.count / 10", self.titleArray.count / 8);
        
        self.imgArray_normal = @[@"gold_",@"goldgift_",@"flower_",@"lolly_",@"diamond_",@"suger_",@"star_",@"donuts_",@"car",@"bulding"];
        _pageCount = self.titleArray.count;
        
        //一页10个
        while (_pageCount % 8 != 0) {
           
            ++_pageCount;
            NSLog(@"%zd-- _pageCount1", _pageCount);
        }
        NSLog(@"%zd-- _pageCount2", _pageCount);
        
        CollectionViewFlowLayout *layout =[[CollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kScreenWidth/4, AutoSize(220));
        layout.minimumInteritemSpacing = 0*SCREEN_SCALE;
        layout.minimumLineSpacing = 0*SCREEN_SCALE;
        layout.headerReferenceSize = CGSizeMake(0*SCREEN_SCALE, 0*SCREEN_SCALE);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,AutoSize(440))
                                                             collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor blackColor];
        collectionView.alpha = 0.8;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[CollectionCellWhite class]
           forCellWithReuseIdentifier:@"CellWhite"];
        [collectionView registerClass:[CollectionCell class]
           forCellWithReuseIdentifier:@"Cell"];
        self.collectionView = collectionView;
        [_topView addSubview:self.collectionView];

        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,AutoSize(440), kScreenWidth, AutoSize(96))];
        _bottomView.backgroundColor = [UIColor blackColor];
        [self addSubview:_bottomView];
       
        _PageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, AutoSize(12), kScreenWidth, AutoSize(10))];
        _PageControl.numberOfPages = self.titleArray.count/8 + 1 ;
        _PageControl.currentPage = 0;
        _PageControl.hidesForSinglePage = YES;
        _PageControl.backgroundColor = [UIColor blackColor];
        // [_PageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
        [_bottomView addSubview:_PageControl];

        
        _moneyNum = [[UILabel alloc]initWithFrame:CGRectMake(0, AutoSize(34), AutoSize(96), AutoSize(28))];
        _moneyNum.text = @"23";
        _moneyNum.font= kUIFont(AutoSize(28));
        _moneyNum.textAlignment = NSTextAlignmentRight;
        _moneyNum.textColor = [UIColor whiteColor];
        [_bottomView addSubview:_moneyNum];
        
        _money_icon = [[UIImageView alloc]initWithFrame:CGRectMake(AutoSize(96), AutoSize(24), AutoSize(51), AutoSize(48))];
        [_money_icon setImage:[UIImage imageNamed:@"Wgold_"]];
        [_bottomView addSubview:_money_icon];
        
        _VLine = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/4, AutoSize(16), AutoSize(1), AutoSize(64))];
        _VLine.backgroundColor = [UIColor lightGrayColor];
        [_bottomView addSubview:_VLine];
        
        _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(AutoSize(576), AutoSize(18), AutoSize(154), AutoSize(60))];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [UIColor whiteColor];
        _sendBtn.enabled = YES;
        _sendBtn.layer.cornerRadius = AutoSize(28);
        _sendBtn.layer.masksToBounds = YES;
        _sendBtn.titleLabel.font = kUIFont(AutoSize(36));
        [_sendBtn addTarget:self action:@selector(sendGift) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_sendBtn];
  
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  
    return _pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierCell = @"Cell";
    CollectionCell *cell = nil;
    if (indexPath.item >= self.titleArray.count) {
       
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellWhite"
                                                         forIndexPath:indexPath];
        
    cell.userInteractionEnabled = NO;
    } else {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell
                                                         forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.titleLabel.textColor = [UIColor whiteColor];
        [cell.iconImg setImage:[UIImage imageNamed:self.imgArray_normal[indexPath.row]]];
        cell.moneyNum.text = @"17";
        [cell.moneyImg setImage:[UIImage imageNamed:@"Wgold_"]];
       
        if (indexPath.row==0||indexPath.row==4) {
            cell.leftLine.hidden = NO;
        }
        
        //选中部分边框变色
        UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
        selectedBGView.backgroundColor = [UIColor blackColor];
        selectedBGView.alpha = 0.8;
        selectedBGView.layer.borderWidth = AutoSize(3);
        selectedBGView.layer.borderColor = [UIColor greenColor].CGColor;
        cell.selectedBackgroundView = selectedBGView;

    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.item < self.titleArray.count) {
    NSLog(@"%@",self.titleArray[indexPath.row]);
   
    _sendBtn.enabled = YES;
   
    }
}
////设置点击高亮和非高亮效果
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//    if (indexPath.item < self.titleArray.count) {
//       
//        if ([collectionView isEqual:self.collectionView]) {
//            CollectionCell *cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//            cell.titleLabel.textColor = [UIColor whiteColor];
//            [cell setBackgroundColor:[UIColor blackColor]];
//            cell.contentView.alpha = 0.8;
//        }
////        } else {
//////            CollectionCell *cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//////            cell.titleLabel.textColor = [UIColor redColor];
//////            [cell setBackgroundColor:[UIColor blackColor]];
//////            cell.contentView.alpha = 0.8;
////        }
//        
//    }
//    
//    
//}
//设置页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width + 0.5)%4;
    
    self.PageControl.currentPage = page;
    
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)sendGift{

    
    UIViewController *parentViewController = [self viewController];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"余额不足" message:@"当前余额不足，充值才可以继续送礼，是否去充值" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //handler为手势方法添加处，这里就代替了之前UIAlertView中的代理协议方法,十分方便
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       // [self okDeleted];
        
        //RechargeViewController *recharge = [[RechargeViewController alloc]init];
       // [parentViewController presentViewController:recharge animated:YES completion:nil];
        
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [parentViewController presentViewController:alert animated:YES completion:nil];
}
@end
