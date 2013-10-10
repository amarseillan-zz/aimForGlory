//
//  HelloWorldLayer.h
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 9/12/13.
//  Copyright Agustin Marseillan 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

int _monstersDestroyed;
int _totalLives;
int _gold;


// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
