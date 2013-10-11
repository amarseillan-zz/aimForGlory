//
//  GameOverLayer.h
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 9/19/13.
//  Copyright 2013 Agustin Marseillan. All rights reserved.
//

#import "cocos2d.h"
#import "AGGameStatus.h"

@interface GameOverLayer : CCLayerColor

+(CCScene *) sceneWithWon:(BOOL)won status:(AGGameStatus*)status;
- (id)initWithWon:(BOOL)won status:(AGGameStatus*)status;

@end
