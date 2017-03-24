//
//  GiftView.h
//  WECAST
//
//  Created by Content on 17/1/9.
//  Copyright © 2017年 YOD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShareBtnClick) (UIButton * button);

@interface GiftView : UIView

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *imgArray_normal;
@property(nonatomic,strong)NSArray *imgArray_selected;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)UIView *topView;//顶部礼物区
@property(nonatomic,strong)UIView *bottomView;//底部功能区
@property(nonatomic,strong)UILabel *moneyNum;
@property(nonatomic,strong)UIImageView *money_icon;
@property(nonatomic,strong)UIView *VLine;//底部竖线
@property(nonatomic,strong)UIButton *sendBtn;//发送


@property(nonatomic,copy)ShareBtnClick click_Share;


- (id)initWithShareViewToView:(UIView *)designView;
- (UIViewController*)viewController;
@end
