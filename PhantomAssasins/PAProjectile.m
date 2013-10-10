//
//  PAProjectile.m
//  PhantomAssasins
//
//  Created by Agustin Marseillan on 10/3/13.
//  Copyright (c) 2013 Agustin Marseillan. All rights reserved.
//

#import "PAProjectile.h"
#import "PAMagicProjectile.h"

@implementation PAProjectile

int _damage;

+(id)initWithMagic:(BOOL)hasMagic{
    if( hasMagic ){
        return [PAMagicProjectile init];
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

@end
