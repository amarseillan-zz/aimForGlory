//
//  PAMagicProjectile.m
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 10/3/13.
//  Copyright (c) 2013 Agustin Marseillan. All rights reserved.
//

#import "AGMagicProjectile.h"

@implementation AGMagicProjectile

int _damage;

+(id)init{
    if( (self = [super spriteWithFile:@"magic-arrow.png"])){
        _damage = 7;
    }
    return self;
}

-(int)damage{
    return _damage;
}

@end
