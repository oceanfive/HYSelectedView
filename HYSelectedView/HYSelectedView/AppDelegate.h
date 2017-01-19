//
//  AppDelegate.h
//  HYSelectedView
//
//  Created by wuhaiyang on 2017/1/19.
//  Copyright © 2017年 wuhaiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

