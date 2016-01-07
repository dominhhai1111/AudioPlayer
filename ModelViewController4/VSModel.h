//
//  VSModel.h
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/24/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface VSModel : NSObject
@property (nonatomic, strong) NSString* album_name;
@property (nonatomic, strong) NSString* singer;
@property (nonatomic, strong) UIImage* photo;
@property (nonatomic, strong) UIImage* icon;

- (instancetype) init: (NSString*) album_name
          withMeasure: (NSString*) singer
             andPhoto: (NSString*) photo;
@end
