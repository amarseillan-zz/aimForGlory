//
//  GoldLayer.m
//  AimForGlory
//
//  Created by Agustin Marseillan on 10/10/13.
//  Copyright (c) 2013 Agustin Marseillan. All rights reserved.
//

#import "GoldLayer.h"

@implementation GoldLayer

CCSprite * _coin;
CCLabelTTF * _label;

- (id)initWithGold:(int)gold{
    if ((self = [super initWithColor:ccc4(255, 255, 255, 255)])) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *coin = [CCSprite spriteWithFile:@"coin.jpg"];
        coin.position = ccp(coin.contentSize.width/2, size.height - coin.contentSize.height/2);
        _coin = coin;
        [self addChild: _coin];
        
        NSString * message = [NSString stringWithFormat:@"%010d", gold];
        CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:12];
        label.color = ccc3(0,0,0);
        label.position = ccp(_coin.contentSize.width + 50, size.height - _coin.contentSize.height/2);
        _label = label;
        [self addChild:_label];
        [self updateWithGold:gold];
    }
    return self;
}
                 
- (void)updateWithGold:(int)gold{
    NSString * message = [NSString stringWithFormat:@"%010d", gold];
    [_label setString:message];
}

@end
