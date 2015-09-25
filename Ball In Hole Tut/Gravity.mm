#import "Gravity.h"

#define PTM_RATIO 32

@interface Gravity (PrivateMethods)
-(void) createSmallGravInWorld:(b2World *)world withPos:(CGPoint)pos withSprite:(NSString *)spriteName withIntesity:(int)inten;
@end

@implementation Gravity

-(id) initWithWorld:(b2World*)world withPos:(CGPoint)pos withSprite:(NSString*)spriteName withIntesity:(int)inten
{
    if ((self = [super init])) {
        [self createSmallGravInWorld:world withPos:pos withSprite:spriteName withIntesity:inten];
        
        [self scheduleUpdate];
    }
    
    return self;
}

+(id) gravityWithWorld:(b2World*)world withPos:(CGPoint)pos withSprite:(NSString*)spriteName withIntesity:(int)inten
{
    return [[[self alloc] initWithWorld:world withPos:pos withSprite:spriteName withIntesity:inten] autorelease];
}

-(void) dealloc
{
    [super dealloc];
}

-(void) createSmallGravInWorld:(b2World*)world withPos:(CGPoint)pos withSprite:(NSString*)spriteName withIntesity:(int)inten
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    // Create a body definition and set it to be a dynamic body
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position = b2Vec2(pos.x / PTM_RATIO, pos.y / PTM_RATIO);
    bodyDef.angularDamping = 0.9f;
    
    CCSprite* tempSprite = [CCSprite spriteWithFile:spriteName];
    
    b2CircleShape shape;
    float radiusInMeters = (tempSprite.contentSize.width / PTM_RATIO) * 0.5f;
    shape.m_radius = radiusInMeters;
    
    // Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 2.0f;
    fixtureDef.friction = 0.7f;
    fixtureDef.restitution = 0.3f;
    
    intensity = inten;
    
    [super createBodyInWorld:world bodyDef:&bodyDef fixtureDef:&fixtureDef spriteName:spriteName];
}

-(void)update:(ccTime)delta
{
    for (b2Body* b = self.body->GetWorld()->GetBodyList(); b; b = b->GetNext())
    {
        //b2Body* ground = self.body;
        //b2CircleShape* circle = (b2CircleShape*)self.body->GetShape();
        // Get position of our orb
        b2Vec2 center = self.body->GetPosition();
        // Get position of the current body in the iteration
        b2Vec2 position = b->GetPosition();
        // Get the distance between the two objects.
        b2Vec2 d = center - position;
        // The gravitational force gets stronger as the body gets closer
        float force = intensity / d.LengthSquared(); // intensity can be changed to adjust the amount of force
        d.Normalize();
        b2Vec2 F = force * d;
        // Finally apply a force on the body in the direction of the orb
        b->ApplyForce(F, position);
    }
}

@end