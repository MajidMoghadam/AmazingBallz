//
//  MainMenuLayer.m
//  Ball In Hole Tut
//
//  Created by Majid Moghadam on 11-09-04.
//  Copyright 2011 individual. All rights reserved.
//

#import "MainMenuLayer.h"

@interface MainMenuLayer()
    -(void)displayMainMenu;
    -(void)displayLevelSelection; 
    -(void)displaySceneSelection; 
@end

@implementation MainMenuLayer

-(id)init {
    self = [super init];
    if (self != nil) {
        CGSize screenSize = [CCDirector sharedDirector].winSize; 
        
        CCSprite *background = 
        [CCSprite spriteWithFile:@"MainMenuBackground_HD.png"];
        [background setPosition:ccp(screenSize.width/2, 
                                    screenSize.height/2)];
        [self addChild:background];
        [self displayMainMenu];
        
    }
    return self;
}

-(void)buyBook { 
    [[GameManager sharedGameManager] openSiteWithLinkType:kLinkTypeBookSite]; 
} 

-(void)showOptions { 
    CCLOG(@"Show the Options screen");
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}

-(void)playScene:(CCMenuItemFont*)itemPassedIn {
    if ([itemPassedIn tag] == 1) {
        [[GameManager sharedGameManager] runSceneWithID:kLevel1Scene1];
    } else if ([itemPassedIn tag] == 2) {
        [[GameManager sharedGameManager] runSceneWithID:kLevel1Scene2];
    } else if ([itemPassedIn tag] == 3) {
        [[GameManager sharedGameManager] runSceneWithID:kLevel1Scene3];
    } else if ([itemPassedIn tag] == 11) {
        [[GameManager sharedGameManager] runSceneWithID:kLevel2Scene1];
    } else if ([itemPassedIn tag] == 12) {
        [[GameManager sharedGameManager] runSceneWithID:kLevel2Scene2];
    } else if ([itemPassedIn tag] == 13) {
        [[GameManager sharedGameManager] runSceneWithID:kLevel2Scene3];
    } else if ([itemPassedIn tag] == 14) {
        [[GameManager sharedGameManager] runSceneWithID:kLevel3Scene1];
    } else {
        CCLOG(@"Unexpected item.  Tag was: %d", [itemPassedIn tag]);
    }
}


-(void)displayMainMenu { 
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    if (sceneSelectMenu != nil) { 
        [sceneSelectMenu removeFromParentAndCleanup:YES]; 
    }
    // Main Menu 
    CCMenuItemImage *playGameButton = [CCMenuItemImage 
                                       itemFromNormalImage:@"PlayGameButtonNormal_HD.png" 
                                       selectedImage:@"PlayGameButtonSelected_HD.png"
                                       disabledImage:nil 
                                       target:self 
                                       selector:@selector(displayLevelSelection)];
    CCMenuItemImage *buyBookButton = [CCMenuItemImage 
                                       itemFromNormalImage:@"BuyBookButtonNormal_HD.png" 
                                       selectedImage:@"BuyBookButtonSelected_HD.png"
                                       disabledImage:nil 
                                       target:self 
                                      selector:@selector(buyBook)];
    CCMenuItemImage *optionsButton = [CCMenuItemImage 
                                      itemFromNormalImage:@"OptionsButtonNormal_HD.png" 
                                      selectedImage:@"OptionsButtonSelected_HD.png"
                                      disabledImage:nil 
                                      target:self 
                                      selector:@selector(showOptions)];
    mainMenu = [CCMenu 
                menuWithItems:playGameButton,buyBookButton,optionsButton,nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
    [mainMenu setPosition:
     ccp(screenSize.width * 2.0f,
         screenSize.height / 2.0f)];
    id moveAction = 
    [CCMoveTo actionWithDuration:1.2f 
                        position:ccp(screenSize.width * 0.85f,
                                     screenSize.height/2.0f)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    //id playChorus = [CCCallFunc actionWithTarget:self selector:@selector(playChorus)];
    id sequenceAction = [CCSequence actions:moveEffect,nil];//[CCSequence actions:moveEffect,playChorus,nil];
    [mainMenu runAction:sequenceAction];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];

}

-(void)displayLevelSelection {
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    if (mainMenu != nil) {
        [mainMenu removeFromParentAndCleanup:YES];
    }
    
    CCLabelBMFont *playScene1Label = 
    [CCLabelBMFont labelWithString:@"Level 1" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene1 = 
    [CCMenuItemLabel itemWithLabel:playScene1Label target:self 
                          selector:@selector(displaySceneSelection)];
    [playScene1 setTag:1];
    
    CCLabelBMFont *playScene2Label = 
    [CCLabelBMFont labelWithString:@"Level 2" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene2 = 
    [CCMenuItemLabel itemWithLabel:playScene2Label target:self 
                          selector:@selector(displaySceneSelection2)];
    [playScene2 setTag:2];
    
    CCLabelBMFont *playScene3Label = 
    [CCLabelBMFont labelWithString:@"Level 3" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene3 = [CCMenuItemLabel itemWithLabel:playScene3Label target:self 
                                                        selector:@selector(displaySceneSelection3)];
    [playScene3 setTag:3];
    
    CCLabelBMFont *playScene4Label = 
    [CCLabelBMFont labelWithString:@"Level 4" 
                           fntFile:@"SpaceVikingFont.fnt"];
	CCMenuItemLabel *playScene4 = [CCMenuItemLabel itemWithLabel:playScene4Label target:self 
														selector:@selector(displaySceneSelection)];
	[playScene4 setTag:4];
    
    CCLabelBMFont *playScene5Label = 
    [CCLabelBMFont labelWithString:@"Level 5" 
                           fntFile:@"SpaceVikingFont.fnt"];
	CCMenuItemLabel *playScene5 = [CCMenuItemLabel itemWithLabel:playScene5Label target:self 
														selector:@selector(displaySceneSelection)];
	[playScene5 setTag:5];
    
    CCLabelBMFont *backButtonLabel = 
    [CCLabelBMFont labelWithString:@"Back" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *backButton = 
    [CCMenuItemLabel itemWithLabel:backButtonLabel target:self 
                          selector:@selector(displayMainMenu)];
    
    sceneSelectMenu = [CCMenu menuWithItems:playScene1,
                       playScene2,playScene3,playScene4,playScene5,backButton,nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.03f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, 
                                     screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5f 
                                        position:ccp(screenSize.width * 0.75f, 
                                                     screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [sceneSelectMenu runAction:moveEffect];
    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
}

-(void)displaySceneSelection {
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    if (sceneSelectMenu != nil) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    
    CCLabelBMFont *playScene1Label = 
    [CCLabelBMFont labelWithString:@"Scene 1" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene1 = 
    [CCMenuItemLabel itemWithLabel:playScene1Label target:self 
                          selector:@selector(playScene:)];
    [playScene1 setTag:1];
    
    CCLabelBMFont *playScene2Label = 
    [CCLabelBMFont labelWithString:@"Scene 2" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene2 = 
    [CCMenuItemLabel itemWithLabel:playScene2Label target:self 
                          selector:@selector(playScene:)];
    [playScene2 setTag:2];
    
    CCLabelBMFont *playScene3Label = 
    [CCLabelBMFont labelWithString:@"Scene 3" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene3 = [CCMenuItemLabel itemWithLabel:playScene3Label target:self 
                                                        selector:@selector(playScene:)];
    [playScene3 setTag:3];
    
        
    CCLabelBMFont *backButtonLabel = 
    [CCLabelBMFont labelWithString:@"Back" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *backButton = 
    [CCMenuItemLabel itemWithLabel:backButtonLabel target:self 
                          selector:@selector(displayMainMenu)];
    
    sceneSelectMenu = [CCMenu menuWithItems:playScene1,
                       playScene2,playScene3,backButton,nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.03f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, 
                                     screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5f 
                                        position:ccp(screenSize.width * 0.75f, 
                                                     screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [sceneSelectMenu runAction:moveEffect];
    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
}

-(void)displaySceneSelection2 {
    CGSize screenSize = [CCDirector sharedDirector].winSize; 
    if (sceneSelectMenu != nil) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    
    CCLabelBMFont *playScene1Label = 
    [CCLabelBMFont labelWithString:@"Scene 1" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene1 = 
    [CCMenuItemLabel itemWithLabel:playScene1Label target:self 
                          selector:@selector(playScene:)];
    [playScene1 setTag:11];
    
    CCLabelBMFont *playScene2Label = 
    [CCLabelBMFont labelWithString:@"Scene 2" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene2 = 
    [CCMenuItemLabel itemWithLabel:playScene2Label target:self 
                          selector:@selector(playScene:)];
    [playScene2 setTag:12];
    
    CCLabelBMFont *playScene3Label = 
    [CCLabelBMFont labelWithString:@"Scene 3" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene3 = [CCMenuItemLabel itemWithLabel:playScene3Label target:self 
                                                        selector:@selector(playScene:)];
    [playScene3 setTag:13];
    
    
    CCLabelBMFont *backButtonLabel = 
    [CCLabelBMFont labelWithString:@"Back" 
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *backButton = 
    [CCMenuItemLabel itemWithLabel:backButtonLabel target:self 
                          selector:@selector(displayMainMenu)];
    
    sceneSelectMenu = [CCMenu menuWithItems:playScene1,
                       playScene2,playScene3,backButton,nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.03f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, 
                                     screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5f 
                                        position:ccp(screenSize.width * 0.75f, 
                                                     screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [sceneSelectMenu runAction:moveEffect];
    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
}

-(void)displaySceneSelection3 {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if (sceneSelectMenu != nil) {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    
    CCLabelBMFont *playScene1Label =
    [CCLabelBMFont labelWithString:@"Scene 1"
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene1 =
    [CCMenuItemLabel itemWithLabel:playScene1Label target:self
                          selector:@selector(playScene:)];
    [playScene1 setTag:14];
    
    CCLabelBMFont *playScene2Label =
    [CCLabelBMFont labelWithString:@"Scene 2"
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene2 =
    [CCMenuItemLabel itemWithLabel:playScene2Label target:self
                          selector:@selector(playScene:)];
    [playScene2 setTag:12];
    
    CCLabelBMFont *playScene3Label =
    [CCLabelBMFont labelWithString:@"Scene 3"
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *playScene3 = [CCMenuItemLabel itemWithLabel:playScene3Label target:self
                                                        selector:@selector(playScene:)];
    [playScene3 setTag:13];
    
    
    CCLabelBMFont *backButtonLabel =
    [CCLabelBMFont labelWithString:@"Back"
                           fntFile:@"SpaceVikingFont.fnt"];
    CCMenuItemLabel *backButton =
    [CCMenuItemLabel itemWithLabel:backButtonLabel target:self
                          selector:@selector(displayMainMenu)];
    
    sceneSelectMenu = [CCMenu menuWithItems:playScene1,
                       playScene2,playScene3,backButton,nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height * 0.03f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2,
                                     screenSize.height / 2)];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5f
                                        position:ccp(screenSize.width * 0.75f,
                                                     screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [sceneSelectMenu runAction:moveEffect];
    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
}






@end
