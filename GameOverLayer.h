//
//  GameOverLayer.h
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 9/19/13.
//  Copyright 2013 Agustin Marseillan. All rights reserved.
//

#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor

+(CCScene *) sceneWithWon:(BOOL)won gold:(int)gold;
- (id)initWithWon:(BOOL)won gold:(int)gold;

@end
