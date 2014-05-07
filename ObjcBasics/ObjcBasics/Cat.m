//
//  Cat.m
//  ObjcBasics
//
//  Created by Alfred Hanssen on 5/6/14.
//  Copyright (c) 2014 Alfred Hanssen. All rights reserved.
//

#import "Cat.h"

@implementation Cat

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        _name = name;
    }
    return self;
}

- (void)makeSomeNoise
{
    NSLog(@"Meow!");
}

@end
