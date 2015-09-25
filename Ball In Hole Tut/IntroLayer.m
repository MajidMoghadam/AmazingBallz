//
//  IntroLayer.m
//  SpaceViking
//
#import "IntroLayer.h"

@implementation IntroLayer
-(void)startGamePlay {
	CCLOG(@"Intro complete, asking Game Manager to start the Game play");
	[[GameManager sharedGameManager] runSceneWithID:kLevel1MenuScene];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CCLOG(@"Touches received, skipping intro");
	[self startGamePlay];
}


-(id)init {
	self = [super init];
	if (self != nil) {
		// Accept touch input
		self.isTouchEnabled = YES;
		
		// Create the intro image
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCSprite *introImage = [CCSprite spriteWithFile:@"intro1.png"];
		[introImage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
		[self addChild:introImage];
		
    }
	return self;
}
@end
