//
//  Levvel2Scene2.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"
#import "GameScene.h"


@interface Level2Scene2 : GameScene {
    
}
+ (id) scene;
+ (Level2Scene2*) sharedGameScene;
@end
