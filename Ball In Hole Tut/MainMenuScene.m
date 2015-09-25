//
//  MainMenuScene.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-04.
//  Copyright 2011 individual. All rights reserved.
//

#import "MainMenuScene.h"

@implementation MainMenuScene

- (id)init
{
    self = [super init];
    if (self!=nil) {
        mainMenuLayer = [MainMenuLayer node]; 
        [self addChild:mainMenuLayer]; 
    }
    
    return self;
}

@end
