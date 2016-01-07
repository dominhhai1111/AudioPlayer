//
//  VSModel.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/24/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "VSModel.h"

@implementation VSModel
- (instancetype) init: (NSString*) album_name
          withMeasure: (NSString*) singer
             andPhoto: (NSString*) photo {
    if (self = [super init]) {
        self.album_name = album_name;
        self.singer = singer;
        NSString* photoFile = [NSString stringWithFormat:@"%@.jpg", photo];
        self.photo = [UIImage imageNamed:photoFile];
        
        NSString* iconFile = [NSString stringWithFormat:@"%@.jpg", photo];
        self.icon = [UIImage imageNamed:iconFile];
    }
    return self;
}
@end
