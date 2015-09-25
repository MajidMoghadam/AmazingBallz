//
//  StaticBarrier.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-22.
//  Copyright 2011 individual. All rights reserved.
//

#import "StaticBarrier.h"
#import "Helper.h"
#import "Constants.h"

@interface StaticBarrier (PrivateMethods)
-(void) createStaticBarrierInWorld:(b2World*)world withPos:(CGPoint)pos;
@end

@implementation StaticBarrier

-(id) initWithWorld:(b2World*)world withPos:(CGPoint)pos
{
    if ((self = [super init])) {
        [self createStaticBarrierInWorld:world withPos:pos];
    }
    return self;
}

+(id) newStaticBarrierInWorld:(b2World*)world withPos:(CGPoint)pos
{
    return [[[self alloc] initWithWorld:world withPos:pos] autorelease];
}

-(void) createStaticBarrierInWorld:(b2World*)world withPos:(CGPoint)pos
{
    b2BodyDef staticBodyDef;
    staticBodyDef.type = b2_staticBody;
    staticBodyDef.position = [Helper toMetersFromPixels:pos];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"GameSprites.plist"];
    
    //CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"GameSprites.png"];
    //[self addChild:batch z:1];
    
    //NSString* spriteFramName = @"blackrectangle20-20.png";
    
    NSString* spriteFrameName = @"blackrectangle20-20.png";
   // CCSprite* tempSprite = [CCSprite spriteWithSpriteFrameName:spriteFramName];
    
    b2PolygonShape shape;
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((-20.0f/4) / PTM_RATIO, (20.0f/4) / PTM_RATIO),
        b2Vec2((-20.0f/4) / PTM_RATIO, (-20.0f/4) / PTM_RATIO),
        b2Vec2((20.0f/4) / PTM_RATIO, (-20.0f/4) / PTM_RATIO),
        b2Vec2((20.0f/4) / PTM_RATIO, (20.0f/4) / PTM_RATIO)
    };
    // Then call this
    shape.Set(verts, num);
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.2f;
    fixtureDef.restitution = 0.1f;
    
    [super createBodyInWorld:world bodyDef:&staticBodyDef fixtureDef:&fixtureDef spriteName:spriteFrameName];
    
}

@end
