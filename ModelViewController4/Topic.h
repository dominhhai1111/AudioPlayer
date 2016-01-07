//
//  Topic.h
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/30/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSArray* arraySongs;

-(instancetype)initWithName:(NSString*) name andSongs: (NSArray*)songs;

@end
