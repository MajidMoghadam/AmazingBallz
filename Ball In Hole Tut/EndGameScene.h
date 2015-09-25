//
//  EndGameScene.h
//  Ball In Hole Tut
//
//  Created by Bryan Weber on 8/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EndGameScene : CCLayer {
    int m_currentLevelNumber;
    int m_currentSceneNumber;
}

+(id) scene;
// Designated initializer
-(id)initWithLevelAndScene: (int)currentLevelNumber scene:(int)currentSceneNumber;
-(id)initWithLevel: (int)currentLevelNumber;
-(id)init;

@end
