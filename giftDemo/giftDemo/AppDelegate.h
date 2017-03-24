//
//  AppDelegate.h
//  giftDemo
//
//  Created by Content on 17/2/10.
//  Copyright © 2017年 flymanshow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnimOperationManager;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)AnimOperationManager *manager;
@end

