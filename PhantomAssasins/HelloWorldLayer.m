//
//  HelloWorldLayer.m
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 9/12/13.
//  Copyright Agustin Marseillan 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "GameOverLayer.h"
#import "PAMonster.h"
#import "PAProjectile.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


// Audio files
#import "SimpleAudioEngine.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

NSMutableArray * _monsters;
NSMutableArray * _projectiles;
NSMutableArray * _lives;
int _projectilesFired;
long _time;



// on "init" you need to initialize your instance
- (id) init
{
    if ((self = [super initWithColor:ccc4(255,255,255,255)])) {
        _monsters = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        _monstersDestroyed = 0;
        _lives = [[NSMutableArray alloc] init];
        _gold = 0;
        _projectilesFired = 0;
        _time = 0;
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        int i = 0;
        for( i=0; i<3; i++ ){
            CCSprite *life = [CCSprite spriteWithFile:@"heart.png"];
            life.position = ccp(winSize.width/2 - (i-1)*life.contentSize.width, winSize.height - life.contentSize.height/2);
            
            [_lives addObject:life];
        }
        _totalLives = 3;
        CCSprite *player = [CCSprite spriteWithFile:@"player.png"];
        player.position = ccp(player.contentSize.width/2, winSize.height/2);
        [self addChild:player];
        [self addChild:_lives[0]];
        [self addChild:_lives[1]];
        [self addChild:_lives[2]];
        [self schedule:@selector(gameLogic:) interval:1.0];
        [self setIsTouchEnabled:YES];
        [self schedule:@selector(update:)];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
    }
    return self;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (void) addMonster {
    
    PAMonster * monster = [PAMonster initWithHp:_time];
    
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = monster.contentSize.height / 2;
    int maxY = winSize.height - monster.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = ccp(winSize.width + monster.contentSize.width/2, actualY);
    [self addChild:monster];
    
    // Determine speed of the monster
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(-monster.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        _totalLives--;
        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"heartempty.png"];
        [_lives[_totalLives] setTexture:tex];
        if( _totalLives <= 0 ){
            CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO gold:_gold];
            [[CCDirector sharedDirector] replaceScene:gameOverScene];
        }
        [_monsters removeObject:node];
    }];
    [monster runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    monster.tag = 1;
    [_monsters addObject:monster];
    
}

-(void)gameLogic:(ccTime)dt {
    [self addMonster];
    _time++;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    [_monsters release];
    _monsters = nil;
    [_projectiles release];
    _projectiles = nil;
    [_lives release];
    _lives = nil;
	[super dealloc];
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    // Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    PAProjectile *projectile = [PAProjectile initWithMagic:((_projectilesFired++%5)==0)];
    projectile.position = ccp(20, winSize.height/2);
    
    // Determine offset of location to projectile
    CGPoint offset = ccpSub(location, projectile.position);
    
    // Bail out if you are shooting down or backwards
    if (offset.x <= 0) return;
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];
    
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offset.y / (float) offset.x;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    [projectile setRotation:asin(ratio)];
    
    
    // Determine the length of how far you're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    // Move projectile to actual endpoint
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
         [_projectiles removeObject:node];
     }],
      nil]];
    
    projectile.tag = 2;
    [_projectiles addObject:projectile];
    [[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
    
}

- (void)update:(ccTime)dt {
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    for (PAProjectile *projectile in _projectiles) {
        
        NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
        for (PAMonster *monster in _monsters) {
            
            if (CGRectIntersectsRect(projectile.boundingBox, monster.boundingBox)) {
                if( [monster getHit:projectile] ){
                    [monstersToDelete addObject:monster];
                }
            }
        }
        
        for (PAMonster *monster in monstersToDelete) {
            [_monsters removeObject:monster];
            _gold = _time;
            [self removeChild:monster cleanup:YES];
            _monstersDestroyed++;
            //winning condition...
            /*if (_monstersDestroyed > 5) {
                CCScene *gameOverScene = [GameOverLayer sceneWithWon:YES];
                [[CCDirector sharedDirector] replaceScene:gameOverScene];
            }*/
        }
        
        if (monstersToDelete.count > 0) {
            [projectilesToDelete addObject:projectile];
        }
        [monstersToDelete release];
    }
    
    for (CCSprite *projectile in projectilesToDelete) {
        [_projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
    [projectilesToDelete release];
}


#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
