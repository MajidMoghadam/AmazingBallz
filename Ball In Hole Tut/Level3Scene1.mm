//
//  Level3Scene1.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-09.
//  Copyright 2011 individual. All rights reserved.
//

#import "Level3Scene1.h"
#import "Ball.h"
#import "Hole.h"
#import "Helper.h"
#import "EndGameScene.h"
#import "StaticBarrier.h"

@interface Level3Scene1 (PrivateMethods)
- (void)createBarrier1; //borders
- (void)createBarrier2; //all walls attached to outer wall
- (void)createBarrier3; //inner walls
@end

@implementation Level3Scene1

static Level3Scene1* instanceOfGameScene;

+(Level3Scene1*) sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

+(id) scene
{
    CCScene* scene = [CCScene node];
    Level3Scene1* layer = [Level3Scene1 node];
    [scene addChild:layer z:0];
    return scene;
}

-(id) init
{
    if (( self = [super init])) {
        instanceOfGameScene = self;
        
        m_levelNumber = 3;
        m_sceneNumber = 1;
        totalNumberOfHolesInLevel = 1;
        
        self.isAccelerometerEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [self initBox2dWorld];
        
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameSprites.plist"];
        
        //CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"GameSprites.png"];
        //[self addChild:batch z:1];
        
        CCSprite* background = [CCSprite spriteWithFile:@"Maze7.png"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:background z:-10];
        
        Ball* ball = [Ball newBallInWorld:world withPos:ccp(screenSize.width*0.9, screenSize.height*0.78)];
        [self addChild:ball z:3];
        
        //Ball* ball2 = [Ball newBallInWorld:world withPos:ccp(screenSize.width/3, screenSize.height/3)];
        //[self addChild:ball2 z:3];
        
        Hole* hole1 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.83, screenSize.height*0.68)];
        [self addChild:hole1 z:2];
        
        Hole* hole2 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.70, screenSize.height*0.78)];
        [self addChild:hole2 z:2];
        
        Hole* hole3 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.365, screenSize.height*0.78)];
        [self addChild:hole3 z:2];
        
        Hole* hole4 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.09, screenSize.height*0.79)];
        [self addChild:hole4 z:2];
        
        Hole* hole5 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.08, screenSize.height*0.68)];
        [self addChild:hole5 z:2];
        
        Hole* hole6 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.24, screenSize.height*0.615)];
        [self addChild:hole6 z:2];
        
        Hole* hole7 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.08, screenSize.height*0.535)];
        [self addChild:hole7 z:2];
        
        Hole* hole8 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.27, screenSize.height*0.535)];
        [self addChild:hole8 z:2];
        
        [self createStaticBarriers];
        
        /*
        CCSprite* rectangle1 = [CCSprite spriteWithFile:@"rectangle2_HD.png"];
        rectangle1.position =ccp(160,240);
        [self addChild:rectangle1];
        
        CCSprite* rectangle2 = [CCSprite spriteWithFile:@"rectangle2_HD.png"];
        rectangle2.position =ccp(80,240);
        [self addChild:rectangle2];
        
        CCSprite* rectangle3 = [CCSprite spriteWithFile:@"rectangle2_HD.png"];
        rectangle3.position =ccp(240,240);
        [self addChild:rectangle3];
        */
        
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
    //row 1, col 1
    b2Vec2 verts1[] = {
        b2Vec2((-80.0f-80.0f) / PTM_RATIO, (80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-80.0f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO),
        b2Vec2((80.0f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO),
        b2Vec2((80.0f-80.0f) / PTM_RATIO, (80.0f - 120.0f) / PTM_RATIO)
    };

    [self createStaticBodyWithVertices:verts1 numVertices:num];
    
    b2Vec2 verts2[] = {
        b2Vec2((-80.0f-80.0f) / PTM_RATIO, (-75.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-80.0f-80.0f) / PTM_RATIO, (-80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((80.0f-80.0f) / PTM_RATIO, (-80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((80.0f-80.0f) / PTM_RATIO, (-75.0f - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts2 numVertices:num];
    
    b2Vec2 verts3[] = {
        b2Vec2((-80.0f-80.0f) / PTM_RATIO, (80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-80.0f-80.0f) / PTM_RATIO, (-80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-75.0f-80.0f) / PTM_RATIO, (-80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-75.0f-80.0f) / PTM_RATIO, (80.0f - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts3 numVertices:num];
    
    b2Vec2 verts4[] = {
        b2Vec2((75.0f-80.0f) / PTM_RATIO, (80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((75.0f-80.0f) / PTM_RATIO, (-80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((80.0f-80.0f) / PTM_RATIO, (-80.0f - 120.0f) / PTM_RATIO),
        b2Vec2((80.0f-80.0f) / PTM_RATIO, (80.0f - 120.0f) / PTM_RATIO)
    };
    
    [self createStaticBodyWithVertices:verts4 numVertices:num];

    
    //StaticBarrier *staticBarrier1 = [StaticBarrier newStaticBarrierInWorld:world withPos:ccp(10,240)];
    //[self addChild:staticBarrier1];
}

- (void)createBarrier2 { //left barrier
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    int num = 4;
    
    b2Vec2 verts0[] = {
        b2Vec2((61.0f-80.0f) / PTM_RATIO, (56.5f - 120.0f) / PTM_RATIO),
        b2Vec2((61.0f-80.0f) / PTM_RATIO, (25.0f - 120.0f) / PTM_RATIO),
        b2Vec2((66.0f-80.0f) / PTM_RATIO, (25.0f - 120.0f) / PTM_RATIO),
        b2Vec2((66.0f-80.0f) / PTM_RATIO, (56.5f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts0 numVertices:num];
    
    b2Vec2 verts00[] = {
        b2Vec2((61.0f-80.0f) / PTM_RATIO, (30.0f - 120.0f) / PTM_RATIO),
        b2Vec2((61.0f-80.0f) / PTM_RATIO, (25.0f - 120.0f) / PTM_RATIO),
        b2Vec2((75.0f-80.0f) / PTM_RATIO, (25.0f - 120.0f) / PTM_RATIO),
        b2Vec2((75.0f-80.0f) / PTM_RATIO, (30.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts00 numVertices:num];

    b2Vec2 verts1[] = {
        b2Vec2((43.0f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO),
        b2Vec2((43.0f-80.0f) / PTM_RATIO, (65.0f - 120.0f) / PTM_RATIO),
        b2Vec2((48.0f-80.0f) / PTM_RATIO, (65.0f - 120.0f) / PTM_RATIO),
        b2Vec2((48.0f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts1 numVertices:num];
    
    b2Vec2 verts2[] = {
        b2Vec2((5.0f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO),
        b2Vec2((5.0f-80.0f) / PTM_RATIO, (65.0f - 120.0f) / PTM_RATIO),
        b2Vec2((10.0f-80.0f) / PTM_RATIO, (65.0f - 120.0f) / PTM_RATIO),
        b2Vec2((10.0f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts2 numVertices:num];
    
    b2Vec2 verts3[] = {
        b2Vec2((-41.0f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-41.0f-80.0f) / PTM_RATIO, (63.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-35.5f-80.0f) / PTM_RATIO, (63.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-35.5f-80.0f) / PTM_RATIO, (75.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts3 numVertices:num];
    
    b2Vec2 verts4[] = {
        b2Vec2((-75.0f-80.0f) / PTM_RATIO, (63.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-75.0f-80.0f) / PTM_RATIO, (59.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-59.0f-80.0f) / PTM_RATIO, (59.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-59.0f-80.0f) / PTM_RATIO, (63.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts4 numVertices:num];
    
    b2Vec2 verts5[] = {
        b2Vec2((-75.0f-80.0f) / PTM_RATIO, (37.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-75.0f-80.0f) / PTM_RATIO, (32.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-64.5f-80.0f) / PTM_RATIO, (32.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-64.5f-80.0f) / PTM_RATIO, (37.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts5 numVertices:num];
}

- (void)createBarrier3 { //right barrier
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    int num = 4;
    b2Vec2 verts1[] = {
        b2Vec2((-45.0f-80.0f) / PTM_RATIO, (49.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-45.0f-80.0f) / PTM_RATIO, (44.0f - 120.0f) / PTM_RATIO),
        b2Vec2((43.0f-80.0f) / PTM_RATIO, (44.0f - 120.0f) / PTM_RATIO),
        b2Vec2((43.0f-80.0f) / PTM_RATIO, (49.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts1 numVertices:num];
    
    b2Vec2 verts2[] = {
        b2Vec2((23.0f-80.0f) / PTM_RATIO, (53.0f - 120.0f) / PTM_RATIO),
        b2Vec2((23.0f-80.0f) / PTM_RATIO, (49.0f - 120.0f) / PTM_RATIO),
        b2Vec2((28.0f-80.0f) / PTM_RATIO, (49.0f - 120.0f) / PTM_RATIO),
        b2Vec2((28.0f-80.0f) / PTM_RATIO, (53.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts2 numVertices:num];
    
    b2Vec2 verts3[] = {
        b2Vec2((-8.5f-80.0f) / PTM_RATIO, (53.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-8.5f-80.0f) / PTM_RATIO, (49.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-3.5f-80.0f) / PTM_RATIO, (49.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-3.5f-80.0f) / PTM_RATIO, (53.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts3 numVertices:num];
    
    b2Vec2 verts4[] = {
        b2Vec2((-35.5f-80.0f) / PTM_RATIO, (44.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-35.5f-80.0f) / PTM_RATIO, (17.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-30.5f-80.0f) / PTM_RATIO, (17.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-30.5f-80.0f) / PTM_RATIO, (44.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts4 numVertices:num];
    
    b2Vec2 verts5[] = {
        b2Vec2((-47.0f-80.0f) / PTM_RATIO, (20.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-47.0f-80.0f) / PTM_RATIO, (15.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-10.0f-80.0f) / PTM_RATIO, (15.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-10.0f-80.0f) / PTM_RATIO, (20.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts5 numVertices:num];
    
    b2Vec2 verts6[] = {
        b2Vec2((-15.0f-80.0f) / PTM_RATIO, (29.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-15.0f-80.0f) / PTM_RATIO, (15.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-9.5f-80.0f) / PTM_RATIO, (15.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-9.5f-80.0f) / PTM_RATIO, (29.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts6 numVertices:num];
    
    b2Vec2 verts7[] = {
        b2Vec2((22.5f-80.0f) / PTM_RATIO, (44.0f - 120.0f) / PTM_RATIO),
        b2Vec2((12.5f-80.0f) / PTM_RATIO, (10.0f - 120.0f) / PTM_RATIO),
        b2Vec2((17.5f-80.0f) / PTM_RATIO, (8.25f - 120.0f) / PTM_RATIO),
        b2Vec2((27.5f-80.0f) / PTM_RATIO, (44.0f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts7 numVertices:num];
    
    b2Vec2 verts8[] = {
        b2Vec2((13.0f-80.0f) / PTM_RATIO, (10.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-18.5f-80.0f) / PTM_RATIO, (-23.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-14.0f-80.0f) / PTM_RATIO, (-25.5f - 120.0f) / PTM_RATIO),
        b2Vec2((17.5f-80.0f) / PTM_RATIO, (8.25f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts8 numVertices:num];
    
    b2Vec2 verts9[] = {
        b2Vec2((-17.0f-80.0f) / PTM_RATIO, (-5.5f - 120.0f) / PTM_RATIO),
        b2Vec2((-20.5f-80.0f) / PTM_RATIO, (-9.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-10.0f-80.0f) / PTM_RATIO, (-19.0f - 120.0f) / PTM_RATIO),
        b2Vec2((-6.5f-80.0f) / PTM_RATIO, (-15.5f - 120.0f) / PTM_RATIO)
    };
    [self createStaticBodyWithVertices:verts9 numVertices:num];
}

@end
