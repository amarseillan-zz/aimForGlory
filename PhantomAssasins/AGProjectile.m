//
//  PAProjectile.m
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 10/3/13.
//  Copyright (c) 2013 Agustin Marseillan. All rights reserved.
//

#import "AGProjectile.h"
#import "AGMagicProjectile.h"

@implementation AGProjectile

int _damage;
BOOL _isSharp;

+(id)initWithMagic:(BOOL)hasMagic isSharp:(BOOL)isSharp{
    if( hasMagic ){
        return [AGMagicProjectile init];
    }else{
        if( (self = [super spriteWithFile:@"arrow.png"])){
            _damage = 5;
        }
        return self;
    }
}

-(int)damage{
    return _damage;
}

-(BOOL)isSharp{
    return _isSharp;
}

@end
