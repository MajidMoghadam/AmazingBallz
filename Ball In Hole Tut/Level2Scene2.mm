//
//  Level2Scene2.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 individual. All rights reserved.
//

#import "Level2Scene2.h"
#import "Ball.h"
#import "Hole.h"
#import "Helper.h"
#import "EndGameScene.h"
#import "ChasingEnemy.h"


@implementation Level2Scene2

static Level2Scene2* instanceOfGameScene;

+(Level2Scene2*) sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

+(id) scene
{
    CCScene* scene = [CCScene node];
    Level2Scene2* layer = [Level2Scene2 node];
    [scene addChild:layer z:0];
    return scene;
}

-(id) init
{
    if (( self = [super init])) {
        instanceOfGameScene = self;
        
        m_levelNumber = 2;
        m_sceneNumber = 2;
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
        
        [self addBall:ccp(20, 20)];
        [self addHole:ccp(70, 410)];
        [self addChasingEnemy:ccp(300,20)];
        
        [self addStaticBarrier:ccp(40,440)];
        [self addStaticBarrier:ccp(60,440)];
        [self addStaticBarrier:ccp(80,440)];
        [self addStaticBarrier:ccp(100,440)];
        [self addStaticBarrier:ccp(40,420)];
        [self addStaticBarrier:ccp(40,400)];
        [self addStaticBarrier:ccp(40,380)];
        [self addStaticBarrier:ccp(40,330)];
        [self addStaticBarrier:ccp(40,280)];
        
        [self addStaticBarrier:ccp(60,330)];
        [self addStaticBarrier:ccp(80,330)];
        [self addStaticBarrier:ccp(100,330)];
        [self addStaticBarrier:ccp(100,390)];
        [self addStaticBarrier:ccp(100,370)];
        [self addStaticBarrier:ccp(100,350)];
        
        [self addStaticBarrier:ccp(10,280)];
        [self addStaticBarrier:ccp(30,280)];
        [self addStaticBarrier:ccp(50,280)];
        [self addStaticBarrier:ccp(70,280)];
        [self addStaticBarrier:ccp(90,280)];
        [self addStaticBarrier:ccp(110,280)];
        [self addStaticBarrier:ccp(130,280)];
        [self addStaticBarrier:ccp(150,280)];
        [self addStaticBarrier:ccp(150,300)];
        [self addStaticBarrier:ccp(150,320)];
        [self addStaticBarrier:ccp(150,340)];
        [self addStaticBarrier:ccp(150,390)];
        [self addStaticBarrier:ccp(150,410)];
        [self addStaticBarrier:ccp(150,430)];
        [self addStaticBarrier:ccp(150,450)];
        [self addStaticBarrier:ccp(150,470)];
        
        [self addStaticBarrier:ccp(200,440)];
        [self addStaticBarrier:ccp(200,420)];
        [self addStaticBarrier:ccp(200,400)];
        [self addStaticBarrier:ccp(200,380)];
        [self addStaticBarrier:ccp(200,360)];
        [self addStaticBarrier:ccp(200,340)];
        [self addStaticBarrier:ccp(220,440)];
        [self addStaticBarrier:ccp(240,440)];
        [self addStaticBarrier:ccp(260,440)];
        [self addStaticBarrier:ccp(280,440)];
        
        [self addStaticBarrier:ccp(200,290)];
        [self addStaticBarrier:ccp(200,270)];
        [self addStaticBarrier:ccp(200,250)];
        [self addStaticBarrier:ccp(220,250)];
        [self addStaticBarrier:ccp(240,250)];
        [self addStaticBarrier:ccp(260,250)];
        
        [self addStaticBarrier:ccp(40,230)];
        [self addStaticBarrier:ccp(60,230)];
        [self addStaticBarrier:ccp(80,230)];
        [self addStaticBarrier:ccp(100,230)];
        [self addStaticBarrier:ccp(120,230)];
        [self addStaticBarrier:ccp(140,230)];
        [self addStaticBarrier:ccp(140,210)];
        [self addStaticBarrier:ccp(140,190)];
        [self addStaticBarrier:ccp(160,190)];
        [self addStaticBarrier:ccp(180,190)];
        [self addStaticBarrier:ccp(200,190)];
        [self addStaticBarrier:ccp(220,190)];
        [self addStaticBarrier:ccp(240,190)];
        [self addStaticBarrier:ccp(260,190)];
        [self addStaticBarrier:ccp(260,170)];
        [self addStaticBarrier:ccp(260,150)];
        [self addStaticBarrier:ccp(260,130)];
        [self addStaticBarrier:ccp(260,110)];
        [self addStaticBarrier:ccp(260,90)];
        [self addStaticBarrier:ccp(260,70)];
        
        [self addStaticBarrier:ccp(10,180)];
        [self addStaticBarrier:ccp(30,180)];
        [self addStaticBarrier:ccp(50,180)];
        [self addStaticBarrier:ccp(70,180)];
        [self addStaticBarrier:ccp(90,180)];
        [self addStaticBarrier:ccp(90,160)];
        [self addStaticBarrier:ccp(90,140)];
        [self addStaticBarrier:ccp(90,120)];
        [self addStaticBarrier:ccp(110,140)];
        [self addStaticBarrier:ccp(130,140)];
        [self addStaticBarrier:ccp(150,140)];
        [self addStaticBarrier:ccp(150,120)];
        [self addStaticBarrier:ccp(150,100)];
        [self addStaticBarrier:ccp(150,80)];
        [self addStaticBarrier:ccp(150,60)];
        [self addStaticBarrier:ccp(150,40)];
        
        [self addStaticBarrier:ccp(40,130)];
        [self addStaticBarrier:ccp(40,110)];
        [self addStaticBarrier:ccp(40,90)];
        [self addStaticBarrier:ccp(40,70)];
        [self addStaticBarrier:ccp(40,50)];

        [self addStaticBarrier:ccp(90,70)];
        [self addStaticBarrier:ccp(90,50)];
        [self addStaticBarrier:ccp(90,30)];
        [self addStaticBarrier:ccp(90,10)];
        
        [self addStaticBarrier:ccp(200,130)];
        [self addStaticBarrier:ccp(200,110)];
        [self addStaticBarrier:ccp(200,90)];
        [self addStaticBarrier:ccp(200,70)];
        [self addStaticBarrier:ccp(200,50)];
        [self addStaticBarrier:ccp(200,30)];
        [self addStaticBarrier:ccp(200,10)];
        
        [self addStaticBarrier:ccp(250,390)];
        [self addStaticBarrier:ccp(250,370)];
        [self addStaticBarrier:ccp(250,350)];
        [self addStaticBarrier:ccp(250,330)];
        [self addStaticBarrier:ccp(250,310)];
        [self addStaticBarrier:ccp(270,350)];
        [self addStaticBarrier:ccp(290,350)];
        [self addStaticBarrier:ccp(310,350)];
        
        [self addStaticBarrier:ccp(250,-10)];
        [self addStaticBarrier:ccp(270,-10)];
        [self addStaticBarrier:ccp(290,-10)];
        [self addStaticBarrier:ccp(310,-10)];
        
        [self addStaticBarrier:ccp(330,400)];
        [self addStaticBarrier:ccp(330,380)];
        [self addStaticBarrier:ccp(330,360)];
        [self addStaticBarrier:ccp(330,340)];
        [self addStaticBarrier:ccp(330,320)];
        [self addStaticBarrier:ccp(330,300)];
        [self addStaticBarrier:ccp(330,280)];
        [self addStaticBarrier:ccp(330,260)];
        [self addStaticBarrier:ccp(330,240)];
        [self addStaticBarrier:ccp(330,220)];
        [self addStaticBarrier:ccp(330,200)];
        [self addStaticBarrier:ccp(330,180)];
        [self addStaticBarrier:ccp(330,160)];
        [self addStaticBarrier:ccp(330,140)];
        [self addStaticBarrier:ccp(330,120)];
        [self addStaticBarrier:ccp(330,100)];
        [self addStaticBarrier:ccp(330,80)];
        [self addStaticBarrier:ccp(330,60)];
        [self addStaticBarrier:ccp(330,40)];
        [self addStaticBarrier:ccp(330,20)];
        [self addStaticBarrier:ccp(330,0)];

        
        
        
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
