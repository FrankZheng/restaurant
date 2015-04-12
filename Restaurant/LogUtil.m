//
//  LogUtil.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "LogUtil.h"
#import <stdarg.h>


@implementation LogUtil

+(void)log:(NSString *)tag format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc]initWithFormat:format arguments:args];
    va_end(args);
    
    NSLog(@"[%@] %@", tag, message);
}


@end
