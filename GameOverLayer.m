//
//  GameOverLayer.m
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 9/19/13.
//  Copyright 2013 Agustin Marseillan. All rights reserved.
//

#import "GameOverLayer.h"
#import "MainLoopLayer.h"

@implementation GameOverLayer

+(CCScene *) sceneWithWon:(BOOL)won status:(AGGameStatus*)status{
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [[[GameOverLayer alloc] initWithWon:won status:status] autorelease];
    [scene addChild: layer];
    return scene;
}

- (id)initWithWon:(BOOL)won status:(AGGameStatus*)status{
    if ((self = [super initWithColor:ccc4(255, 255, 255, 255)])) {
        
        NSString * message;
        if (won) {
            message = @"You Won!";
        } else {
            message = [NSString stringWithFormat:@"You Lose :[, won %d gold", status.gold];
        }
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:32];
        label.color = ccc3(0,0,0);
        label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:label];
        
        [self runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:3],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [[CCDirector sharedDirector] replaceScene:[MainLoopLayer scene:status]];
         }],
          nil]];
    }
    return self;
}

@end