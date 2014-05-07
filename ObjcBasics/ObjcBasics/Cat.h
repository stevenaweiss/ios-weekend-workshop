//
//  Cat.h
//  ObjcBasics
//
//  Created by Alfred Hanssen on 5/6/14.
//  Copyright (c) 2014 Alfred Hanssen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cat : NSObject

@property (nonatomic, strong) NSString *name;

- (id)initWithName:(NSString *)name;

- (void)makeSomeNoise;

@end
