//
//  Level2Scene1.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-20.
//  Copyright 2011 individual. All rights reserved.
//

#import "Level2Scene1.h"
#import "Ball.h"
#import "Hole.h"
#import "RotatingBarrier.h"
#import "StaticBarrier.h"
#import "MovingBarrier1.h"
#import "Helper.h"
#import "EndGameScene.h"



@implementation Level2Scene1

static Level2Scene1* instanceOfGameScene;

+(Level2Scene1*) sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

+(id) scene
{
    CCScene* scene = [CCScene node];
    Level2Scene1* layer = [Level2Scene1 node];
    [scene addChild:layer z:0];
    return scene;
}

-(id) init
{
    if (( self = [super init])) {
        instanceOfGameScene = self;
        
        m_levelNumber = 2;
        m_sceneNumber = 1;
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
        
        Ball* ball = [Ball newBallInWorld:world withPos:ccp(screenSize.width/2, screenSize.height*0.1)];
        [self addChild:ball z:3];
        
        Hole* hole = [Hole newHoleInWorld:world withPos:ccp(screenSize.width/2, screenSize.height*0.9)];
        [self addChild:hole z:2];
        
        [self addStaticBarrier:ccp(10,240)];
        [self addStaticBarrier:ccp(30,240)];
        [self addStaticBarrier:ccp(50,240)];
        [self addStaticBarrier:ccp(70,240)];
        [self addStaticBarrier:ccp(85,240)];
        
        RotatingBarrier *rotatingBarrier1 = [RotatingBarrier newRotatingBarrierInWorld:world withPos:ccp(150,240)];
        [self addChild:rotatingBarrier1];
        
        [self addStaticBarrier:ccp(215,240)];
        [self addStaticBarrier:ccp(230,240)];
        [self addStaticBarrier:ccp(250,240)];
        [self addStaticBarrier:ccp(270,240)];
        [self addStaticBarrier:ccp(290,240)];
        [self addStaticBarrier:ccp(310,240)];
        
        /***************************************/
        
        [self addStaticBarrier:ccp(10,120)];
        [self addStaticBarrier:ccp(25,120)];
        
        RotatingBarrier *rotatingBarrier2 = [RotatingBarrier newRotatingBarrierInWorld:world withPos:ccp(90,120)];
        [self addChild:rotatingBarrier2];
        
        [self addStaticBarrier:ccp(155,120)];
        [self addStaticBarrier:ccp(170,120)];
        [self addStaticBarrier:ccp(190,120)];
        [self addStaticBarrier:ccp(210,120)];
        [self addStaticBarrier:ccp(230,120)];
        [self addStaticBarrier:ccp(250,120)];
        [self addStaticBarrier:ccp(270,120)];
        [self addStaticBarrier:ccp(290,120)];
        [self addStaticBarrier:ccp(310,120)];
        
        /***************************************/
        
        [self addStaticBarrier:ccp(110,430)];
        [self addStaticBarrier:ccp(110,410)];
        [self addStaticBarrier:ccp(110,390)];
        [self addStaticBarrier:ccp(130,390)];
        [self addStaticBarrier:ccp(150,390)];
        [self addStaticBarrier:ccp(170,390)];
        [self addStaticBarrier:ccp(190,390)];
        [self addStaticBarrier:ccp(210,390)];
        [self addStaticBarrier:ccp(210,410)];
        [self addStaticBarrier:ccp(210,430)];

        
        
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
