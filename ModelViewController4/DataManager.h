//
//  DataManager.h
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/24/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DataManager : NSObject
@property (nonatomic, strong) NSArray* data;
+ (instancetype)getSingleton;
@end