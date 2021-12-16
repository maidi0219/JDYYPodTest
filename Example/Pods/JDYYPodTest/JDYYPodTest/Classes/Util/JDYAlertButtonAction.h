//
//  JDYAlertButtonAction.h
//  kdweibo
//
//  Created by zzw on 2018/7/25.
//  Copyright © 2018年 www.kingdee.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    JDYAlertButtonActionStyleDefault,
    JDYAlertButtonActionStyleDestructive,
    JDYAlertButtonActionStyleCancel,
} JDYAlertButtonActionStyle;

@interface JDYAlertButtonAction : NSObject

+ (id)actionWithTitle: (NSString *)title style: (JDYAlertButtonActionStyle)style handler: (void (^ __nullable)())handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) JDYAlertButtonActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, assign) BOOL closeBtnEnable;

@property (nonatomic, copy) void (^ __nullable handler)();

@end
