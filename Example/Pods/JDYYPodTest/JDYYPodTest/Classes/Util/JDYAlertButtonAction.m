//
//  JDYAlertButtonAction.m
//  kdweibo
//
//  Created by zzw on 2018/7/25.
//  Copyright © 2018年 www.kingdee.com. All rights reserved.
//

#import "JDYAlertButtonAction.h"
@interface JDYAlertButtonAction()

@property (nullable, nonatomic) NSString *title;
@property (nonatomic) JDYAlertButtonActionStyle style;

@end

@implementation JDYAlertButtonAction

+ (id)actionWithTitle: (NSString *)title style: (JDYAlertButtonActionStyle)style handler: (void (^ __nullable)())handler {
    JDYAlertButtonAction *action = [[JDYAlertButtonAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    return action;
}

@end
