//
//  PAMonster.h
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 10/3/13.
//  Copyright (c) 2013 Agustin Marseillan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PAProjectile.h"

@interface PAMonster : CCSprite

+(id) initWithHp:(int)hp;

-(int) hp;

-(BOOL) getHit:(PAProjectile*)projectile;

@end
