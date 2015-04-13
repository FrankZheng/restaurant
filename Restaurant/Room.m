//
//  Room.m
//  Restaurant
//
//  Created by Frank Zheng on 15/4/12.
//  Copyright (c) 2015年 Frank Zheng. All rights reserved.
//

#import "Room.h"

#define kName @"name"
#define kTables @"tables"

@interface Room()
@property(nonatomic, strong, readwrite) NSMutableArray *tables;

@end

@implementation Room



-(instancetype)init {
    if(self = [super init]) {
        
    }
    return self;
}

-(void)setup {
    _tables = [[NSMutableArray alloc] init];
}

-(void)addTable:(DiningTable *)table {
    [_tables addObject:table];
}

-(NSArray*)getTables {
    return [_tables copy];
}


//persistence
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _name = [aDecoder decodeObjectForKey:kName];
        _tables = [aDecoder decodeObjectForKey:kTables];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:kName];
    [encoder encodeObject:_tables forKey:kTables];
}



@end
