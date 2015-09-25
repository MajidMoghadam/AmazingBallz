//
//  EndGameScene.m
//  Ball In Hole Tut
//
//  Created by Bryan Weber on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EndGameScene.h"
#import "Level1Scene1.h"
#import "Level1Scene2.h"
#import "Level1Scene3.h"
#import "Level2Scene1.h"
#import "Level2Scene2.h"
#import "Level2Scene3.h"
#import "Level3Scene1.h"

@implementation EndGameScene

+(id) scene
{
    CCScene* scene = [CCScene node];
    EndGameScene* layer = [EndGameScene node];
    [scene addChild:layer z:0];
    return scene;
}

-(id)initWithLevelAndScene: (int)currentLevelNumber scene:(int)currentSceneNumber;
{
    if (self = [super init])
    {
        m_currentLevelNumber = currentLevelNumber;
        m_currentSceneNumber = currentSceneNumber;
        
        self.isTouchEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"You Win!!" fontName:@"Marker Felt" fontSize:40];
        label.position = ccp(screenSize.width/2, screenSize.height*0.6);
        [self addChild:label z:1];
        
        CCMenuItem* playAgain = [CCMenuItemFont itemFromString:@"Play Again!" target:self selector:@selector(playAgain:)];
        
        CCMenuItem* nextScene = [CCMenuItemFont itemFromString:@"Next ->" target:self selector:@selector(loadNextScene:)];
        
        CCMenu* menu = [CCMenu menuWithItems:playAgain,nextScene, nil];
        [menu alignItemsVerticallyWithPadding:screenSize.height * 0.05f];
        menu.position = ccp(screenSize.width/2, screenSize.height/2-50);
        [self addChild:menu];

    }
    return self;
}

-(id)initWithLevel: (int)currentLevelNumber
{
    // Either of these will work
    return [self initWithLevelAndScene:currentLevelNumber scene:nil];
    //  return [self initWithStrAndDate:inString date:nil];
}

-(id)init
{
    return [self initWithLevel:nil];
}


-(void) playAgain:(id)sender
{
    if (m_currentLevelNumber == 1 && m_currentSceneNumber == 1) {
        [[CCDirector sharedDirector] replaceScene:[Level1Scene1 scene]];
    }else if (m_currentLevelNumber == 1 && m_currentSceneNumber == 2) {
        [[CCDirector sharedDirector] replaceScene:[Level1Scene2 scene]];
    }else if (m_currentLevelNumber == 1 && m_currentSceneNumber == 3) {
        [[CCDirector sharedDirector] replaceScene:[Level1Scene3 scene]];
    }else if (m_currentLevelNumber == 2 && m_currentSceneNumber == 1) {
        [[CCDirector sharedDirector] replaceScene:[Level2Scene1 scene]];
    }else if (m_currentLevelNumber == 2 && m_currentSceneNumber == 2) {
        [[CCDirector sharedDirector] replaceScene:[Level2Scene2 scene]];
    }else if (m_currentLevelNumber == 2 && m_currentSceneNumber == 3) {
        [[CCDirector sharedDirector] replaceScene:[Level2Scene3 scene]];
    }else if (m_currentLevelNumber == 3 && m_currentSceneNumber == 1) {
        [[CCDirector sharedDirector] replaceScene:[Level3Scene1 scene]];
    }
}

-(void) loadNextScene:(id)sender
{
    if (m_currentLevelNumber == 1 && m_currentSceneNumber == 1) {
        [[CCDirector sharedDirector] replaceScene:[Level1Scene2 scene]];
    }else if (m_currentLevelNumber == 1 && m_currentSceneNumber == 2) {
        [[CCDirector sharedDirector] replaceScene:[Level1Scene3 scene]];
    }else if (m_currentLevelNumber == 1 && m_currentSceneNumber == 3) {
        [[CCDirector sharedDirector] replaceScene:[Level2Scene1 scene]];
    }else if (m_currentLevelNumber == 2 && m_currentSceneNumber == 1) {
        [[CCDirector sharedDirector] replaceScene:[Level2Scene2 scene]];
    }else if (m_currentLevelNumber == 2 && m_currentSceneNumber == 2) {
        [[CCDirector sharedDirector] replaceScene:[Level2Scene3 scene]];
    }else if (m_currentLevelNumber == 2 && m_currentSceneNumber == 3) {
        [[CCDirector sharedDirector] replaceScene:[Level1Scene1 scene]];
    }

}

@end
