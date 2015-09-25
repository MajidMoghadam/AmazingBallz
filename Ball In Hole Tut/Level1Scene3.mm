//
//  Level1Scene3.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-12.
//  Copyright 2011 individual. All rights reserved.
//

#import "Level1Scene3.h"
#import "Ball.h"
#import "Hole.h"
#import "Helper.h"
#import "EndGameScene.h"

@implementation Level1Scene3

static Level1Scene3* instanceOfGameScene;

+(Level1Scene3*) sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

+(id) scene
{
    CCScene* scene = [CCScene node];
    Level1Scene3* layer = [Level1Scene3 node];
    [scene addChild:layer z:0];
    return scene;
}

-(id) init
{
    if (( self = [super init])) {
        instanceOfGameScene = self;
        
        m_levelNumber = 1;
        m_sceneNumber = 3;
        totalNumberOfHolesInLevel = 4;
        
        self.isAccelerometerEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [self initBox2dWorld];
        
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameSprites.plist"];
        
        //CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"GameSprites.png"];
        //[self addChild:batch z:1];
        
        CCSprite* background = [CCSprite spriteWithFile:@"back.png"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:background z:-10];
        
        Ball* ball1 = [Ball newBallInWorld:world withPos:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:ball1 z:3];
        
        Ball* ball2 = [Ball newBallInWorld:world withPos:ccp(screenSize.width/3, screenSize.height/3)];
        [self addChild:ball2 z:3];
        
        Ball* ball3 = [Ball newBallInWorld:world withPos:ccp(screenSize.width*0.1, screenSize.height*0.1)];
        [self addChild:ball3 z:3];
        
        Ball* ball4 = [Ball newBallInWorld:world withPos:ccp(screenSize.width*0.9, screenSize.height*0.9)];
        [self addChild:ball4 z:3];

        
        Hole* hole1 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width/2, screenSize.height*0.1)];
        [self addChild:hole1 z:2];
        
        Hole* hole2 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width/2, screenSize.height*0.9)];
        [self addChild:hole2 z:2];
        
        Hole* hole3 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.2, screenSize.height*0.5)];
        [self addChild:hole3 z:2];
        
        Hole* hole4 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.8, screenSize.height*0.5)];
        [self addChild:hole4 z:2];
        
        [self createStaticBarriers];
        
        CCSprite* staticBarriersL1S3 = [CCSprite spriteWithFile:@"staticBarriersL1S3_HD.png"];
        staticBarriersL1S3.position =ccp(160,240);
        [self addChild:staticBarriersL1S3 z:0];
        
        [self scheduleUpdate];
    }
    return self;
}

- (void) createStaticBarriers{
    //from vertex helper
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    int num1 = 4;
    b2Vec2 verts1[] = {
        b2Vec2((-50.0f/2 - 80.0f) / PTM_RATIO, (-138.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-51.0f/2 - 80.0f) / PTM_RATIO, (-199.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-30.5f/2 - 80.0f) / PTM_RATIO, (-199.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-31.0f/2 - 80.0f) / PTM_RATIO, (-139.0f/2 - 120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts1 numVertices:num1];
    
    int num2 = 4;
    b2Vec2 verts2[] = {
        b2Vec2((-31.5f/2 - 80.0f) / PTM_RATIO, (-139.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-30.5f/2 - 80.0f) / PTM_RATIO, (-158.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((29.5f/2 - 80.0f) / PTM_RATIO, (-158.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((29.0f/2 - 80.0f) / PTM_RATIO, (-139.0f/2 - 120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts2 numVertices:num2];
    
    int num3 = 4;
    b2Vec2 verts3[] = {
        b2Vec2((30.0f/2 - 80.0f) / PTM_RATIO, (-139.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((30.0f/2 - 80.0f) / PTM_RATIO, (-198.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((49.5f/2 - 80.0f) / PTM_RATIO, (-198.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((49.5f/2 - 80.0f) / PTM_RATIO, (-139.0f/2 - 120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts3 numVertices:num3];
    
    int num4 = 4;
    b2Vec2 verts4[] = {
        b2Vec2((-49.0f/2 - 80.0f) / PTM_RATIO, (190.2f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-49.2f/2 - 80.0f) / PTM_RATIO, (130.2f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-29.5f/2 - 80.0f) / PTM_RATIO, (130.2f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-29.2f/2 - 80.0f) / PTM_RATIO, (190.0f/2 - 120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts4 numVertices:num4];
    
    int num5 = 4;
    b2Vec2 verts5[] = {
        b2Vec2((-29.2f/2 - 80.0f) / PTM_RATIO, (150.2f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-29.5f/2 - 80.0f) / PTM_RATIO, (130.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((30.7f/2 - 80.0f) / PTM_RATIO, (130.2f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((30.7f/2 - 80.0f) / PTM_RATIO, (150.0f/2 - 120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts5 numVertices:num5];
    
    int num6 = 4;
    b2Vec2 verts6[] = {
        b2Vec2((31.0f/2 - 80.0f) / PTM_RATIO, (190.2f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((31.5f/2 - 80.0f) / PTM_RATIO, (130.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((50.7f/2 - 80.0f) / PTM_RATIO, (130.2f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((50.7f/2 - 80.0f) / PTM_RATIO, (190.0f/2 - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts6 numVertices:num6];
    
    int num7 = 4;
    b2Vec2 verts7[] = {
        b2Vec2((-115.4f/2 - 80.0f) / PTM_RATIO, (46.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-115.4f/2 - 80.0f) / PTM_RATIO, (26.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-55.3f/2 - 80.0f) / PTM_RATIO, (26.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-55.3f/2 - 80.0f) / PTM_RATIO, (46.0f/2 - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts7 numVertices:num7];
    
    int num8 = 4;
    b2Vec2 verts8[] = {
        b2Vec2((-75.5f/2 - 80.0f) / PTM_RATIO, (26.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-75.5f/2 - 80.0f) / PTM_RATIO, (-33.6f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-55.0f/2 - 80.0f) / PTM_RATIO, (-33.9f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-55.3f/2 - 80.0f) / PTM_RATIO, (25.8f/2 - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts8 numVertices:num8];
    
    int num9 = 4;
    b2Vec2 verts9[] = {
        b2Vec2((-115.1f/2 - 80.0f) / PTM_RATIO, (-33.6f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-115.4f/2 - 80.0f) / PTM_RATIO, (-54.1f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-55.3f/2 - 80.0f) / PTM_RATIO, (-54.1f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((-55.3f/2 - 80.0f) / PTM_RATIO, (-34.3f/2 - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts9 numVertices:num9];
    
    int num10 = 4;
    b2Vec2 verts10[] = {
        b2Vec2((58.2f/2 - 80.0f) / PTM_RATIO, (49.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((57.8f/2 - 80.0f) / PTM_RATIO, (29.3f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((117.9f/2 - 80.0f) / PTM_RATIO, (29.0f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((117.6f/2 - 80.0f) / PTM_RATIO, (49.1f/2 - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts10 numVertices:num10];
    
    int num11 = 4;
    b2Vec2 verts11[] = {
        b2Vec2((57.8f/2 - 80.0f) / PTM_RATIO, (29.3f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((57.8f/2 - 80.0f) / PTM_RATIO, (-31.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((78.0f/2 - 80.0f) / PTM_RATIO, (-31.1f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((77.6f/2 - 80.0f) / PTM_RATIO, (29.0f/2 - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts11 numVertices:num11];
    
    int num12 = 4;
    b2Vec2 verts12[] = {
        b2Vec2((58.2f/2 - 80.0f) / PTM_RATIO, (-31.5f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((58.2f/2 - 80.0f) / PTM_RATIO, (-50.6f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((117.6f/2 - 80.0f) / PTM_RATIO,(-50.9f/2 - 120.0f) / PTM_RATIO),
        b2Vec2((117.6f/2 - 80.0f) / PTM_RATIO, (-31.1f/2 - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts12 numVertices:num12];


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
