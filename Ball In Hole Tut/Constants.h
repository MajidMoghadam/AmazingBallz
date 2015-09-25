//
//  Constants.h
//  Marble Marathon 2
//
//  Created by Bryan Weber on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define PTM_RATIO 32
#define HOLE_RADIUS
#define BALL_RADIUS
#define ARC4RANDOM_MAX 4294967295
#define kVikingSpriteZValue 100
#define kVikingSpriteTagValue 0
#define kVikingIdleTimer 3.0f
#define kVikingFistDamage 10
#define kVikingMalletDamage 40
#define kRadarDishTagValue 10


#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20

typedef enum{
    kNoSceneUninitialized = 0,
    kMainMenuScene = 1,
    kOptionsScene = 2,
    kCreditsScene = 3,
    kIntroScene = 4,
    kLevelCompletedScene = 5,
    kLevel1MenuScene = 100,
    kLevel2MenuScene = 200,
    kLevel3MenuScene = 300,
    kLevel1Scene1 = 101,
    kLevel1Scene2 = 102,
    kLevel1Scene3 = 103,
    kLevel2Scene1 = 201,
    kLevel2Scene2 = 202,
    kLevel2Scene3 = 203,
    kLevel3Scene1 = 301
} SceneTypes;

typedef enum {
    kLinkTypeBookSite,
    kLinkTypeDeveloperSiteRod,
    kLinkTypeDeveloperSiteRay,
    kLinkTypeArtistSite,
    kLinkTypeMusicianSite
} LinkTypes;

//ChasingEnemy direction
typedef enum {
    kUp = 1,
    kDown = 2,
    kLeft =3,
    kRight = 4
} ChasingEnemyDirection;

// Audio Items
#define AUDIO_MAX_WAITTIME 150

typedef enum {
    kAudioManagerUninitialized=0,
    kAudioManagerFailed=1,
    kAudioManagerInitializing=2,
    kAudioManagerInitialized=100,
    kAudioManagerLoading=200,
    kAudioManagerReady=300
    
} GameManagerSoundState;

// Audio Constants
#define SFX_NOTLOADED NO
#define SFX_LOADED YES

#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect:@#__VA_ARGS__]

#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect:__VA_ARGS__]

// Background Music
// Menu Scenes
#define BALL_COLLISION @"ballCollision.mp3"

 




