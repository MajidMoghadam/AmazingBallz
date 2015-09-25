//
//  GameScene.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-12.
//  Copyright 2011 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"

@interface GameScene : CCLayer{
    int m_levelNumber;
    int m_sceneNumber;
    b2World* world;
    ContactListener* contactListener;
    GLESDebugDraw* debugDraw;
    int totalNumberOfHolesInLevel;
    int totalNumberOfHolesOccupied;
}
@property (readwrite,assign) int m_levelNumber;
@property (readwrite,assign) int m_sceneNumber;

- (void) initBox2dWorld;
- (void) gameOver;
- (void) createStaticBodyWithVertices:(b2Vec2[])vertices numVertices:(int)numVertices;
- (void) createStaticBarriers;
- (void) drawDebugGrid;
- (void) addStaticBarrier:(CGPoint)pos;
- (void) addBall:(CGPoint)pos;
- (void) addHole:(CGPoint)pos;
- (void) addChasingEnemy:(CGPoint)pos;
@end
