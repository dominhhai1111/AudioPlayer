//
//  Songs.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/30/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "Songs.h"

@implementation Songs
- (instancetype) init: (NSString*) name
           withSinger: (NSString*) singer
             andPhoto: (NSString*) photo
             andMusic:(NSString *)mp3_name{
    if (self = [super init]) {
        self.name = name;
        self.singer = singer;
        NSString* photoFile = [NSString stringWithFormat:@"%@.jpg", photo];
        self.photo = [UIImage imageNamed:photoFile];
        
        NSString* iconFile = [NSString stringWithFormat:@"%@.jpg", photo];
        self.icon = [UIImage imageNamed:iconFile];
        
        self.mp3_name = mp3_name;
    }
    return self;
}

@end
