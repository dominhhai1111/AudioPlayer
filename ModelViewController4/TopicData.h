//
//  TopicData.h
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/30/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicData : NSObject
@property (nonatomic, strong) NSArray* arrayTopic ;

+(TopicData*) sharedData;
@end
