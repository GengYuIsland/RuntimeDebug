//
//  Debug.m
//  Tinghao
//
//  Created by Shadow on 2017/7/5.
//  Copyright © 2017年 inpark. All rights reserved.
//

#import "UIViewController+Debug.h"
#import <objc/runtime.h>

@implementation UIViewController (Debug)

+ (void)load {
    
#ifdef DEBUG
    Method viewDidAppear = class_getInstanceMethod(self, @selector(viewDidAppear:));
    Method debugViewDidAppear = class_getInstanceMethod(self, @selector(debugViewDidAppear:));
    method_exchangeImplementations(viewDidAppear, debugViewDidAppear);
    
    Method viewDidDisappear = class_getInstanceMethod(self, @selector(viewDidDisappear:));
    Method debugViewDidDisappear = class_getInstanceMethod(self, @selector(debugViewDidDisappear:));
    method_exchangeImplementations(viewDidDisappear, debugViewDidDisappear);
#endif
    
}

- (void)debugViewDidAppear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    //过滤一些类，比如UI打头的。
    if ([className hasPrefix:@"UI"] == NO) {
        DLog(@"%@ Did Appear",className);
    }
    //调用viewDidAppear(替换后的)
    [self debugViewDidAppear:YES];
}

- (void)debugViewDidDisappear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    //过滤一些类，比如UI打头的。
    if ([className hasPrefix:@"UI"] == NO) {
        DLog(@"%@ Did Disappear",className);
    }
    //调用viewDidAppear(替换后的)
    [self debugViewDidDisappear:YES];
}

@end
