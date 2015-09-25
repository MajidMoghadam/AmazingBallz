//
//  ContactListener.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 All rights reserved.
//

#import "ContactListener.h"
#import "cocos2d.h"
#import "BodyNode.h"
#import "Level1Scene1.h"
#import "Ball.h"
#import "Hole.h"
#import "ChasingEnemy.h"
#import "StaticBarrier.h"
#import "Helper.h"

void ContactListener::BeginContact(b2Contact* contact)
{
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
 
    if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
    {
        BodyNode* bNodeA = (BodyNode*)bodyA->GetUserData();
        BodyNode* bNodeB = (BodyNode*)bodyB->GetUserData();
    
        if ([bNodeA isKindOfClass:[Hole class]] && [bNodeB isKindOfClass:[Ball class]])
        {
            Ball* ball = (Ball*)bNodeB;
            Hole* hole = (Hole*)bNodeA;
            
            if (!hole.isOccupied) {
                ball.isInHole = YES;
                hole.isOccupied = YES;
                ball.holeWithBall = hole;
                hole.continuousTimeOccupied = 0.0;
            }
            
            PLAYSOUNDEFFECT(BALL_COLLISION);
                        
        }
        else if ([bNodeB isKindOfClass:[Hole class]] && [bNodeA isKindOfClass:[Ball class]])
        {
            Ball* ball = (Ball*)bNodeA;
            Hole* hole = (Hole*)bNodeB;
            
            if (!hole.isOccupied) {
                ball.isInHole = YES;
                hole.isOccupied = YES;
                ball.holeWithBall = hole;
                hole.continuousTimeOccupied = 0.0;
            }
            
            PLAYSOUNDEFFECT(BALL_COLLISION);
            
        }
        else if ([bNodeB isKindOfClass:[Ball class]] && [bNodeA isKindOfClass:[Ball class]])
        {
            PLAYSOUNDEFFECT(PHASER_1);
            
        }
        else if ([bNodeB isKindOfClass:[StaticBarrier class]] && [bNodeA isKindOfClass:[ChasingEnemy class]])
        {
            ChasingEnemy* chasingEnemy = (ChasingEnemy*)bNodeA;
            chasingEnemy.hasCollidedWithBarrier = YES;
        }
        else if ([bNodeB isKindOfClass:[ChasingEnemy class]] && [bNodeA isKindOfClass:[StaticBarrier class]])
        {
            ChasingEnemy* chasingEnemy = (ChasingEnemy*)bNodeB;
            chasingEnemy.hasCollidedWithBarrier = YES;
        }
        else if ([bNodeB isKindOfClass:[Ball class]] && [bNodeA isKindOfClass:[ChasingEnemy class]])
        {
            Ball* ball = (Ball*)bNodeB;
            ball.hasBeenHitByChasingEnemy = YES;
        }
        else if ([bNodeB isKindOfClass:[ChasingEnemy class]] && [bNodeA isKindOfClass:[Ball class]])
        {
            Ball* ball = (Ball*)bNodeA;
            ball.hasBeenHitByChasingEnemy = YES;
        }

        
    }
    
}


void ContactListener::EndContact(b2Contact* contact)
{
    
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
    
    if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
    {
        BodyNode* bNodeA = (BodyNode*)bodyA->GetUserData();
        BodyNode* bNodeB = (BodyNode*)bodyB->GetUserData();
        
        if ([bNodeA isKindOfClass:[Hole class]] && [bNodeB isKindOfClass:[Ball class]])
        {
            Ball* ball = (Ball*)bNodeB;
            Hole* hole = (Hole*)bNodeA;
            ball.isInHole = NO;
            hole.isOccupied = NO;
            ball.holeWithBall = nil;
            hole.continuousTimeOccupied = 0.0;
        }
        else if ([bNodeB isKindOfClass:[Hole class]] && [bNodeA isKindOfClass:[Ball class]])
        {
            Ball* ball = (Ball*)bNodeA;
            Hole* hole = (Hole*)bNodeB;
            ball.isInHole = NO;
            hole.isOccupied = NO;
            ball.holeWithBall = nil;
            hole.continuousTimeOccupied = 0.0;
        }
        
    }
     
}



