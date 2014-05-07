//
//  main.c
//  CommandTool
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#include <stdio.h>

struct Tree
{
    int age; // years
    float height; // meters
};

int main(int argc, const char * argv[])
{
    struct Tree tree;
    tree.age = 5;
    tree.height = 10.75f;
    
    printf("The tree is %.2f meters high and %i years old.\n", tree.height, tree.age);
    
    return 0;
}
