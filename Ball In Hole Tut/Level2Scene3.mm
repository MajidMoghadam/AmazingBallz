//
//  Level2Scene3.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-10-02.
//  Copyright 2011 individual. All rights reserved.
//

#import "Level2Scene3.h"
#import "Ball.h"
#import "Hole.h"
#import "Helper.h"
#import "EndGameScene.h"
#import "MovingBarrier1.h"


@implementation Level2Scene3

static Level2Scene3* instanceOfGameScene;

+(Level2Scene3*) sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

+(id) scene
{
    CCScene* scene = [CCScene node];
    Level2Scene3* layer = [Level2Scene3 node];
    [scene addChild:layer z:0];
    return scene;
}

-(id) init
{
    if (( self = [super init])) {
        instanceOfGameScene = self;
        
        m_levelNumber = 2;
        m_sceneNumber = 3;
        totalNumberOfHolesInLevel = 1;
        
        self.isAccelerometerEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [self initBox2dWorld];
        
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameSprites.plist"];
        
        //CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"GameSprites.png"];
        //[self addChild:batch z:1];
        
        CCSprite* background = [CCSprite spriteWithFile:@"back.png"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:background z:-10];
        
        [self addBall:ccp(40, 30)];
        [self addBall:ccp(120, 30)];
        [self addBall:ccp(200, 30)];
        [self addBall:ccp(280, 30)];
                
        MovingBarrier1* movingBarrier1 = [MovingBarrier1 newMovingBarrier1InWorld:world withPos:ccp(160, 240)];
        [self addChild:movingBarrier1 z:3];
        
                
        [self scheduleUpdate];
    }
    return self;
}

-(void) dealloc
{
	
	delete debugDraw;
	debugDraw = NULL;
	
	instanceOfGameScene = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
    
    delete world;
	world = NULL;
}

@end
