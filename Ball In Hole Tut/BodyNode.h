//
//  BodyNode.h
//  Ball in Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"


@interface BodyNode : CCNode {
	b2Body* body;
	CCSprite* sprite;
}

@property (readonly, nonatomic) b2Body* body;
@property (readonly, nonatomic) CCSprite* sprite;

-(void) createBodyInWorld:(b2World*)world bodyDef:(b2BodyDef*)bodyDef fixtureDef:(b2FixtureDef*)fixtureDef spriteName:(NSString*)spriteName;

-(void) removeSprite;
-(void) removeBody;

@end