//
//  DataManager.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/24/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "DataManager.h"
#import "VSModel.h"
@implementation DataManager
+ (instancetype)getSingleton {
    static DataManager *dataManager = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce, ^{
        dataManager = [self new];  // settings = [[self alloc] init]
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Music"
                                                             ofType:@"plist"];
        
        NSArray* raw = [NSArray arrayWithContentsOfFile:filePath];
        NSLog(@"%@", raw);
        NSMutableArray* temp = [[NSMutableArray alloc] initWithCapacity:[raw count]];
        for (NSDictionary* item in raw) {
            
            VSModel* model = [[VSModel alloc] init:[item valueForKey:@"album_name"]
                                       withMeasure:[item valueForKey:@"singer"]
                                          andPhoto:[item valueForKey:@"photo"]];
            [temp addObject:model];
        }
        dataManager.data = [NSArray arrayWithArray:temp];
    });
    return dataManager;
}
@end
