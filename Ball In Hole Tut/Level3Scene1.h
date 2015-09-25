//
//  Level3Scene1.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-09.
//  Copyright 2011 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"
#import "GameScene.h"


@interface Level3Scene1 : GameScene {
    
}
+ (id) scene;
+ (Level3Scene1*) sharedGameScene;

@end