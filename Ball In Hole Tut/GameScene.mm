//
//  GameScene.m
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-12.
//  Copyright 2011 individual. All rights reserved.
//

#import "GameScene.h"
#import "Ball.h"
#import "Hole.h"
#import "ChasingEnemy.h"
#import "Helper.h"
#import "EndGameScene.h"
#import "StaticBarrier.h"

@interface GameScene (PrivateMethods)
-(void) initBox2dWorld;
-(void) enableBox2dDebugDrawing;
@end

@implementation GameScene
@synthesize m_levelNumber;
@synthesize m_sceneNumber;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        //add the pause button
        CCMenuItem *pauseMenuItem = [CCMenuItemImage 
                                     itemFromNormalImage:@"media-pause.png" selectedImage:@"media-pause.png" 
                                     target:self selector:@selector(gameOver)];
        pauseMenuItem.position = ccp(290, 30);
        CCMenu *pauseMenu = [CCMenu menuWithItems:pauseMenuItem, nil];
        pauseMenu.position = CGPointZero;
        [self addChild:pauseMenu z:1000];

    }
    
    return self;
}

-(void) initBox2dWorld
{
	// Construct a world object, which will hold and simulate the rigid bodies.
	b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
	bool allowBodiesToSleep = false;
	world = new b2World(gravity, allowBodiesToSleep);
	
	contactListener = new ContactListener();
	world->SetContactListener(contactListener);
    
    [self enableBox2dDebugDrawing];
	
	// Define the static container body, which will provide the collisions at screen borders.
	b2BodyDef containerBodyDef;
	b2Body* containerBody = world->CreateBody(&containerBodyDef);
    
	// for the ground body we'll need these values
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	float widthInMeters = screenSize.width / [Helper pixelsToMeterRatio];
	float heightInMeters = screenSize.height / [Helper pixelsToMeterRatio];
	b2Vec2 lowerLeftCorner = b2Vec2(0, 0);
	b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 0);
	b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
	b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);
    
	// Create the screen box' sides by using a polygon assigning each side individually.
	b2PolygonShape screenBoxShape;
	int density = 0;
    
	// left side
	screenBoxShape.SetAsEdge(upperLeftCorner, lowerLeftCorner);
	containerBody->CreateFixture(&screenBoxShape, density);
    
	// right side
	screenBoxShape.SetAsEdge(upperRightCorner, lowerRightCorner);
	containerBody->CreateFixture(&screenBoxShape, density);
    
	// bottom
	screenBoxShape.SetAsEdge(lowerLeftCorner, lowerRightCorner);
	containerBody->CreateFixture(&screenBoxShape, density);
	
	// top
	screenBoxShape.SetAsEdge(upperLeftCorner, upperRightCorner);
	containerBody->CreateFixture(&screenBoxShape, density);
    
}




-(void) drawDebugGrid{
    // ...
    
    // draw a simple line
    // The default state is:
    // Line Width: 1
    // color: 255,255,255,255 (white, non-transparent)
    // Anti-Aliased
    glEnable(GL_LINE_SMOOTH);
    glColor4f(1.0, 1.0, 1.0, 0.3);  
    glLineWidth(1.0f);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    ccDrawLine(ccp(0, 0),ccp(0,480));
    ccDrawLine(ccp(50, 0),ccp(50,480));
    ccDrawLine(ccp(100, 0),ccp(100,480));
    ccDrawLine(ccp(150, 0),ccp(150,480));
    ccDrawLine(ccp(200, 0),ccp(200,480));
    ccDrawLine(ccp(250, 0),ccp(250,480));
    ccDrawLine(ccp(300, 0),ccp(300,480));
    ccDrawLine(ccp(0, 0),ccp(320,0));
    ccDrawLine(ccp(0, 50),ccp(320,50));
    ccDrawLine(ccp(0, 100),ccp(320,100));
    ccDrawLine(ccp(0, 150),ccp(320,150));
    ccDrawLine(ccp(0, 200),ccp(320,200));
    ccDrawLine(ccp(0, 250),ccp(320,250));
    ccDrawLine(ccp(0, 300),ccp(320,300));
    ccDrawLine(ccp(0, 350),ccp(320,350));
    ccDrawLine(ccp(0, 400),ccp(320,400));
    ccDrawLine(ccp(0, 450),ccp(320,450));
    
    
    // ...
    
}

-(void) addStaticBarrier:(CGPoint)pos{
    StaticBarrier *staticBarrier = [StaticBarrier newStaticBarrierInWorld:world withPos:pos];
    [self addChild:staticBarrier];
}

-(void) addBall:(CGPoint)pos{
    Ball* ball = [Ball newBallInWorld:world withPos:pos];
    [self addChild:ball z:3];
}

-(void) addHole:(CGPoint)pos{
    Hole* hole = [Hole newHoleInWorld:world withPos:pos];
    [self addChild:hole z:2];

}

- (void) addChasingEnemy:(CGPoint)pos{
    ChasingEnemy* chasingEnemy = [ChasingEnemy newChasingEnemyInWorld:world withPos:pos];
    [self addChild:chasingEnemy z:3];
}

-(void) createStaticBarriers{

}

-(void) createStaticBodyWithVertices:(b2Vec2[])vertices numVertices:(int)numVertices
{
    b2BodyDef bodyDef;
    bodyDef.position = [Helper toMeters:[Helper screenCenter]];
    b2PolygonShape shape;
    shape.Set(vertices, numVertices);
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.2f;
    fixtureDef.restitution = 0.1f;
    b2Body* body = world->CreateBody(&bodyDef);
    body->CreateFixture(&fixtureDef);
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
    
	b2Vec2 gravity = b2Vec2(accelX * 10 * CC_CONTENT_SCALE_FACTOR(), accelY * 10 * CC_CONTENT_SCALE_FACTOR());
    
	world->SetGravity( gravity );
}

-(void) enableBox2dDebugDrawing
{
	// Debug Draw functions
	debugDraw = new GLESDebugDraw(PTM_RATIO);
	world->SetDebugDraw(debugDraw);
	
	uint32 flags = 0;
	flags |= b2DebugDraw::e_shapeBit;
	flags |= b2DebugDraw::e_jointBit;
	//flags |= b2DebugDraw::e_aabbBit;
	//flags |= b2DebugDraw::e_pairBit;
	//flags |= b2DebugDraw::e_centerOfMassBit;
	debugDraw->SetFlags(flags);		
}

-(void) update:(ccTime)delta
{
	// The number of iterations influence the accuracy of the physics simulation. With higher values the
	// body's velocity and position are more accurately tracked but at the cost of speed.
	// Usually for games only 1 position iteration is necessary to achieve good results.
	float timeStep = 0.03f;
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
    
    world->Step(timeStep, velocityIterations, positionIterations);
    
    totalNumberOfHolesOccupied = 0;
    
    bool levelOver = true;
    for (b2Body* body = world->GetBodyList(); body != nil; body = body->GetNext())
	{
		BodyNode* bodyNode = (BodyNode*)body->GetUserData();
        
        if ([bodyNode isKindOfClass:[Hole class]])
        {
            Hole* ahole = (Hole*)bodyNode;
            if (ahole.isOccupied) {
                ahole.continuousTimeOccupied += timeStep;
                if (ahole.continuousTimeOccupied < 1.0f) {
                    levelOver = false;
                }
                totalNumberOfHolesOccupied++;
            }    
        }
        
	}
    
    if (totalNumberOfHolesInLevel != totalNumberOfHolesOccupied) {
        levelOver = false;
    }
	
	// for each body, get its assigned BodyNode and update the sprite's position
	for (b2Body* body = world->GetBodyList(); body != nil; body = body->GetNext())
	{
		BodyNode* bodyNode = (BodyNode*)body->GetUserData();
		if (bodyNode != NULL && bodyNode.sprite != nil)
		{
			// update the sprite's position to where their physics bodies are
			bodyNode.sprite.position = [Helper toPixels:body->GetPosition()];
			float angle = body->GetAngle();
			bodyNode.sprite.rotation = -(CC_RADIANS_TO_DEGREES(angle));
		}
        
        if ([bodyNode isKindOfClass:[Ball class]]) {
            Ball* ball = (Ball*)bodyNode;
            
            //NSString *labelString = [NSString stringWithFormat:@"X: %.2f \n Y:%.2f \n", [Helper toPixels:(ball.body->GetWorldCenter())].x, [Helper toPixels:(ball.body->GetWorldCenter())].y]; 
            //[ball.debugPositionLabel setString:labelString]; 
            //[ball.debugPositionLabel setPosition:[Helper toPixels:(ball.body->GetWorldCenter())]]; 
            
            
            if (ball.isInHole == YES)
            {
                if ((ball.getBallHoleDistance > 0.15)){
                    [ball applyForceTowardsHoleCenter];
                    body->SetLinearDamping(1.0);
                }else{
                    body->SetLinearDamping(3.0);
                }
                
                //float speedOfBall = ball.body->GetLinearVelocity().Length();
                
                //if ((totalNumberOfHolesOccupied == totalNumberOfHolesInLevel)&&((speedOfBall < 0.02))) {
                if (levelOver) {  
                    [self gameOver];
                    /*
                     id actionTo = [CCMoveTo actionWithDuration:0.5 position:[Helper toPixels:(ball.holeWithBall.body->GetWorldCenter())]];
                     id actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(gameOver)];
                     
                     [ball.holeWithBall.sprite runAction:[CCSequence actions:actionTo,actionCallFunc, nil]];
                     */
                }
                
            }else{
                
                body->SetLinearDamping(0.0);
            }
        }
        
	}
    
}


-(void) gameOver
{
    //[[CCDirector sharedDirector] replaceScene:[[EndGameScene alloc] initWithLevelAndScene: m_levelNumber scene:m_sceneNumber]];
    // Run the intro Scene
	[[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}

#ifdef DEBUG
-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    //[self drawDebugGrid];
    
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}
#endif



@end
