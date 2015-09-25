//
//  Level1Scene2.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-09.
//  Copyright 2011 individual. All rights reserved.
//

#import "Level1Scene2.h"
#import "Ball.h"
#import "Hole.h"
#import "Helper.h"
#import "EndGameScene.h"



@interface Level1Scene2 (PrivateMethods)
- (void)createBarrier1;
- (void)createBarrier2;
@end

@implementation Level1Scene2

static Level1Scene2* instanceOfGameScene;

+(Level1Scene2*) sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
    return instanceOfGameScene;
}

+(id) scene
{
    CCScene* scene = [CCScene node];
    Level1Scene2* layer = [Level1Scene2 node];
    [scene addChild:layer z:0];
    return scene;
}

-(id) init
{
    if (( self = [super init])) {
        instanceOfGameScene = self;
        
        m_levelNumber = 1;
        m_sceneNumber = 2;
        totalNumberOfHolesInLevel = 3;
        
        self.isAccelerometerEnabled = YES;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        [self initBox2dWorld];
        
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameSprites.plist"];
        
        //CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"GameSprites.png"];
        //[self addChild:batch z:1];
        
        CCSprite* background = [CCSprite spriteWithFile:@"cherry-wood-background_HD.png"];
        background.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:background z:-10];
        
        Ball* ball = [Ball newBallInWorld:world withPos:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:ball z:3];
        
        Ball* ball2 = [Ball newBallInWorld:world withPos:ccp(screenSize.width/3, screenSize.height/3)];
        [self addChild:ball2 z:3];
        
        Ball* ball3 = [Ball newBallInWorld:world withPos:ccp(screenSize.width/1.5, screenSize.height/1.5)];
        [self addChild:ball3 z:3];
        
        Hole* hole = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.3, screenSize.height*0.75)];
        [self addChild:hole z:2];
        
        Hole* hole2 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.7, screenSize.height*0.75)];
        [self addChild:hole2 z:2];
        
        Hole* hole3 = [Hole newHoleInWorld:world withPos:ccp(screenSize.width*0.5, screenSize.height*0.2)];
        [self addChild:hole3 z:2];
        
        [self createStaticBarriers];
        
        CCSprite* rectangle1 = [CCSprite spriteWithFile:@"rectangle3_HD.png"];
        rectangle1.position =ccp(160,300);
        [self addChild:rectangle1];
        
        CCSprite* rectangle2 = [CCSprite spriteWithFile:@"rectangle4_HD.png"];
        rectangle2.position =ccp(160,200);
        [self addChild:rectangle2];
        
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
}
- (void)createBarrier1 {
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((-50.0f-80.0f) / PTM_RATIO, (-15.0f-120.0f) / PTM_RATIO),
        b2Vec2((-50.0f-80.0f) / PTM_RATIO, (-25.0f-120.0f) / PTM_RATIO),
        b2Vec2((50.0f-80.0f) / PTM_RATIO, (-25.0f-120.0f) / PTM_RATIO),
        b2Vec2((50.0f-80.0f) / PTM_RATIO, (-15.0f-120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts numVertices:num];
} 

- (void)createBarrier2 {
    // Replace with your values from Vertex Helper, but replace all
    // instances of PTM_RATIO with 100.0
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((-5.0f-80.0f) / PTM_RATIO, (50.0f-120.0f) / PTM_RATIO),
        b2Vec2((-5.0f-80.0f) / PTM_RATIO, (10.0f-120.0f) / PTM_RATIO),
        b2Vec2((5.0f-80.0f) / PTM_RATIO, (10.0f-120.0f) / PTM_RATIO),
        b2Vec2((5.0f-80.0f) / PTM_RATIO, (50.0f-120.0f) / PTM_RATIO)
    };        
    [self createStaticBodyWithVertices:verts numVertices:num];
}

@end
