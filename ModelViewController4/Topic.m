//
//  Topic.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/30/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "Topic.h"

@implementation Topic
-(instancetype)initWithName:(NSString *)name andSongs:(NSArray *)songs
{
    if (self=[super init]) {
        self.name = name;
        self.arraySongs= songs;
    }
    return self;
}
@end
