//
//  MainMenuLayer.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-04.
//  Copyright 2011 individual. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "cocos2d.h" 
#import "Constants.h" 
#import "GameManager.h" 
@interface MainMenuLayer : CCLayer{
    CCMenu *mainMenu; 
    CCMenu *levelSelectMenu;
    CCMenu *sceneSelectMenu;
}
@end