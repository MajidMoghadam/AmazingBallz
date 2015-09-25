//
//  Level1Scene1.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-09.
//  Copyright 2011 individual. All rights reserved.
//

#import "Level1Scene1.h"
#import "Ball.h"
#import "Hole.h"
#import "Helper.h"
#import "EndGameScene.h"
#import "StaticBarrier.h"

@interface Level1Scene1 (PrivateMethods)
- (void)createBarrier1;
- (void)createBarrier2;
- (void)createBarrier3;
@end

@implementation Level1Scene1

static Level1Scene1* instanceOfGameScene;

+(Level1Scene1*) sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

+(id) scene
{
    CCScene* scene = [CCScene node];
    Level1Scene1* layer = [Level1Scene1 node];
    [scene addChild:layer z:0];
    return scene;
}

-(id) init
{
    if (( self = [super init])) {
        instanceOfGameScene = self;
        
        m_levelNumber = 1;
        m_sceneNumber = 1;
        totalNumberOfHolesInLevel = 2;
        
        self.isAccelerometerEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [self initBox2dWorld];
        
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameSprites.plist"];
        
        //CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"GameSprites.png"];
        //[self addChild:batch z:1];
        
        CCSprite* background = [CCSprite spriteWithFile:@"back.png"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:background z:-10];
        
        Ball* ball = [Ball newBallInWorld:world withPos:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:ball z:3];
        
        Ball* ball2 = [Ball newBallInWorld:world withPos:ccp(screenSize.width/3, screenSize.height/3)];
        [self addChild:ball2 z:3];
        
        Hole* hole = [Hole newHoleInWorld:world withPos:ccp(screenSize.width/2, screenSize.height*0.1)];
        [self addChild:hole z:2];
        
        Hole* hole2 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width/2, screenSize.height*0.9)];
        [self addChild:hole2 z:2];
        
        [self createStaticBarriers];
                
        CCSprite* rectangle1 = [CCSprite spriteWithFile:@"rectangle2_HD.png"];
        rectangle1.position =ccp(160,240);
        [self addChild:rectangle1];
        
        CCSprite* rectangle2 = [CCSprite spriteWithFile:@"rectangle2_HD.png"];
        rectangle2.position =ccp(80,240);
        [self addChild:rectangle2];
        
        CCSprite* rectangle3 = [CCSprite spriteWithFile:@"rectangle2_HD.png"];
        rectangle3.position =ccp(240,240);
        [self addChild:rectangle3];
        
                        
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


- (void) createStaticBarriers{
    [self createBarrier1];
    [self createBarrier2];
    [self createBarrier3];
}

- (void)createBarrier1 { //middle barrier
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((-10.0f-80.0f) / PTM_RATIO, (5.0f - 120.0f) /PTM_RATIO),
        b2Vec2((-10.0f-80.0f) / PTM_RATIO, (-5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((10.0f-80.0f) / PTM_RATIO, (-5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((10.0f-80.0f) / PTM_RATIO, (5.0f - 120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts numVertices:num];
     
    //StaticBarrier *staticBarrier1 = [StaticBarrier newStaticBarrierInWorld:world withPos:ccp(10,240)];
    //[self addChild:staticBarrier1];
}

- (void)createBarrier2 { //left barrier
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((-50.0f-80.0f) / PTM_RATIO, (5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-50.0f-80.0f) / PTM_RATIO, (-5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-30.0f-80.0f) / PTM_RATIO, (-5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-30.0f-80.0f) / PTM_RATIO, (5.0f - 120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts numVertices:num];
}

- (void)createBarrier3 { //right barrier
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((30.0f-80.0f) / PTM_RATIO, (5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((30.0f-80.0f) / PTM_RATIO, (-5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((50.0f-80.0f) / PTM_RATIO, (-5.0f - 120.0f) / PTM_RATIO),
        b2Vec2((50.0f-80.0f) / PTM_RATIO, (5.0f - 120.0f) /PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts numVertices:num];
}

@end
