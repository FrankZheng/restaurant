//
//  LogUtil.h
//  Restaurant
//
//  Created by Frank Zheng on 15/4/11.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogUtil : NSObject

+(void)log:(NSString *)tag format:(NSString *)format, ...;

@end
