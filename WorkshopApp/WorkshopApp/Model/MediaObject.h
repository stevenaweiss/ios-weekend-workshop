//
//  MediaObject.h
//  WorkshopApp-noxib
//
//  Created by Alfred Hanssen on 11/13/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaObject : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSURL *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
