//
//  Tree.m
//  ObjcBasics
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#import "Tree.h"

// Private interface

@interface Tree ()

@end

@implementation Tree

- (id)initWithSpecies:(NSString *)species age:(int)age
{
    self = [super init];
    if (self)
    {
        self.species = species;
        self.age = age;
    }
    return self;
}

- (void)printDescription
{
    NSLog(@"This %@ tree is %i years old.", self.species, self.age);
}

- (void)descriptionWithBlock:(void(^)(NSString *description))block
{
    NSString *description = [NSString stringWithFormat:@"This %@ tree is %i years old.", self.species, self.age];
    
    if (block)
    {
        block(description);
    }
}

- (void)doSomething
{
    if (self.delegate)
    {
        NSString *description = [NSString stringWithFormat:@"This %@ tree is %i years old.", self.species, self.age];

        [self.delegate tree:self description:description];
    }
}

@end
