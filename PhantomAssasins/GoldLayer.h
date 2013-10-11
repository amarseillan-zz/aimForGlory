//
//  GoldLayer.h
//  AimForGlory
//
//  Created by Agustin Marseillan on 10/10/13.
//  Copyright (c) 2013 Agustin Marseillan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GoldLayer : CCLayerColor

- (id)initWithGold:(int)gold;

- (void)updateWithGold:(int)gold;

@end
