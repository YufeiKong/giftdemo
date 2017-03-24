//
//  ReceiveGiftCell.m
//  giftDemo
//
//  Created by Content on 17/2/14.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import "ReceiveGiftCell.h"

@implementation ReceiveGiftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(18, 15, 30, 30)];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
       // [_icon setImage:[UIImage imageNamed:@"money"]];
        [self addSubview:_icon];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, 100, 15)];
        //_name.text = @"flymanshow";
        [self addSubview:_name];
        
        _moneyNum = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 100, 15)];
        [self addSubview:_moneyNum];
        
        _introduce = [[UILabel alloc]initWithFrame:CGRectMake(300, 5, 70, 50)];
        [self addSubview:_moneyNum];
        
    }

    return self;

}

@end
