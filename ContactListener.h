//
//  ContactListener.h
//  Ball In Hole
//
//  Created by Majid Moghadam on 11-09-23.
//  Copyright 2011 All rights reserved.
//

#import "Box2D.h"
#import "GameManager.h"

class ContactListener : public b2ContactListener 
{
private: 
    b2World* world;
    void BeginContact(b2Contact* contact);
    void EndContact(b2Contact* contact);
};

