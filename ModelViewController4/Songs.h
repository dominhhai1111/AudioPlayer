//
//  Songs.h
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/30/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Songs : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* singer;
@property (nonatomic, strong) UIImage* photo;
@property (nonatomic, strong) UIImage* icon;
@property (nonatomic, strong) NSString* mp3_name;

- (instancetype) init: (NSString*) name
          withSinger: (NSString*) singer
             andPhoto: (NSString*) photo
             andMusic:(NSString*) mp3_name ;
@end
