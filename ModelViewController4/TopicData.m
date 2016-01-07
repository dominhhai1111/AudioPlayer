//
//  TopicData.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/30/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "TopicData.h"
#import "Topic.h"
#import "Songs.h"
@implementation TopicData
+(TopicData*) sharedData
{
    static TopicData *topicData = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        topicData = [[TopicData alloc] init];
    });
    return topicData;
}

-(instancetype)init
{
    if (self=[super init]) {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"MusicAddTableView"
                     ofType:@"plist"];
        NSArray* array = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray* tempArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
        
        for (NSDictionary* item in array) {
            NSArray* tempSongs = [item objectForKey:@"songs"];
            NSMutableArray* arraySongs = [[NSMutableArray alloc] initWithCapacity:[tempSongs count]];
            for (NSDictionary*  dict in tempSongs ) {
                [arraySongs addObject:[[Songs alloc]init:[dict valueForKey:@"name"]
                                              withSinger:[dict valueForKey:@"singer"]
                                                andPhoto:[dict valueForKey:@"photo"]
                                                andMusic:[dict valueForKey:@"music"]]];
            }
            [tempArray addObject:[[Topic alloc] initWithName:[item objectForKey:@"topic"] andSongs:[NSArray arrayWithArray:arraySongs]]];
        }
        _arrayTopic = [NSArray arrayWithArray: tempArray];
    }
    return self;
}
@end
