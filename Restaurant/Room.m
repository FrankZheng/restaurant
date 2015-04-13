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
        [self setup];
    }
    return self;
}

-(void)setup {
    if(_tables == nil) {
        _tables = [[NSMutableArray alloc] init];
    }
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
        
        [self setup];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:kName];
    [encoder encodeObject:_tables forKey:kTables];
}

-(NSUInteger)getTablesCount {
    return _tables.count;
}

-(BOOL)hasTheTable:(DiningTable *)table {
    return [_tables indexOfObject:table] != NSNotFound;
}


@end
