//
//  ChasingEnemy.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-24.
//  Copyright 2011 individual. All rights reserved.
//

#import "ChasingEnemy.h"
#import "Helper.h"
#import "Constants.h"

@interface ChasingEnemy (PrivateMethods)
-(void) createChasingEnemyInWorld:(b2World*)world withPos:(CGPoint)pos;
@end


@implementation ChasingEnemy

@synthesize hasCollidedWithBarrier;
@synthesize constantVelocity;
@synthesize currentXvelocity;
@synthesize currentYvelocity;
@synthesize prevXvelocity;
@synthesize prevYvelocity;

-(id) initWithWorld:(b2World*)world withPos:(CGPoint)pos
{
    if ((self = [super init])) {
        [self createChasingEnemyInWorld:world withPos:pos];
    }
    [self scheduleUpdate];
    return self;
}

+(id) newChasingEnemyInWorld:(b2World*)world withPos:(CGPoint)pos
{
    return [[[self alloc] initWithWorld:world withPos:pos] autorelease];
}

-(void) createChasingEnemyInWorld:(b2World*)world withPos:(CGPoint)pos
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = [Helper toMetersFromPixels:pos];
    bodyDef.fixedRotation = true;
    
    hasCollidedWithBarrier = NO;
    constantVelocity = 1.0f;
    currentXvelocity = 0.0f;
    currentYvelocity = constantVelocity;
    prevXvelocity = 0.0f;
    prevYvelocity = constantVelocity;
         
    NSString* spriteFramName = @"bullet_HD.png";
    
    b2PolygonShape shape;
    int num = 4;
    b2Vec2 verts[] = {
        b2Vec2((-14.0f/2) / PTM_RATIO, (9.0f/2) / PTM_RATIO),
        b2Vec2((-14.0f/2) / PTM_RATIO, (-9.0f/2) / PTM_RATIO),
        b2Vec2((14.0f/2) / PTM_RATIO, (-9.0f/2) / PTM_RATIO),
        b2Vec2((14.0f/2) / PTM_RATIO, (9.0f/2) / PTM_RATIO)
    };
    // Then call this
    shape.Set(verts, num);
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 100000.0f;
    fixtureDef.friction = 60.2f;
    fixtureDef.restitution = 0.0f;
    
    [super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteName:spriteFramName];
    
    b2Vec2 vel = body->GetLinearVelocity();
    vel.y = constantVelocity;
    vel.x = 0.0f;
    body->SetLinearVelocity(vel);

}


-(void) update:(ccTime)delta
{
    self.body->ApplyForce( self.body->GetMass() * -self.body->GetWorld()->GetGravity(), self.body->GetWorldCenter() );
    b2Vec2 vel = body->GetLinearVelocity();
    if (hasCollidedWithBarrier) {
        if (prevYvelocity == constantVelocity) {
            vel.y = 0.0f;
            vel.x = constantVelocity;
            prevYvelocity = 0.0f;
            prevXvelocity = constantVelocity;
        }else if (prevYvelocity == -constantVelocity) {
            vel.y = 0.0f;
            vel.x = -constantVelocity;
            prevYvelocity = 0.0f;
            prevXvelocity = -constantVelocity;
        }else if (prevXvelocity == constantVelocity) {
            vel.y = -constantVelocity;
            vel.x = 0.0f;
            prevYvelocity = -constantVelocity;
            prevXvelocity = 0.0f;
        }else if (prevXvelocity == -constantVelocity) {
            vel.y = constantVelocity;
            vel.x = 0.0f;
            prevYvelocity = constantVelocity;
            prevXvelocity = 0.0f;
        }
        
        /*
        if ((currentXvelocity==0.0f)&&(currentYvelocity==0.0f)) {
            currentXvelocity=1.0f;
            vel.x=currentXvelocity;
        }else if ((currentXvelocity==0.0f)&&(currentYvelocity==0.0f)) {
            currentYvelocity = 1.0f;
            vel.y=currentYvelocity;
        }
         */
        
        hasCollidedWithBarrier = NO;
    }
    
    body->SetLinearVelocity(vel);
}


@end
