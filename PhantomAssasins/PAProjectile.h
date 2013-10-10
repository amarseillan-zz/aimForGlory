//
//  PAProjectile.h
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 10/3/13.
//  Copyright (c) 2013 Agustin Marseillan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCSprite.h"

@interface PAProjectile : CCSprite

+(id)initWithMagic:(BOOL)hasMagic;

-(int)damage;

@end
