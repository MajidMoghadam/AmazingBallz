#import "cocos2d.h"
#import "BodyNode.h"
#import "Box2D.h"

@interface Gravity : BodyNode {
    int intensity;
}

+(id) gravityWithWorld:(b2World*)world withPos:(CGPoint)pos withSprite:(NSString*)spriteName withIntesity:(int)inten;

@end
