//
//  GameAI.h
//  WigglyWormhole
//
//  Created by Alex on 09/11/2014.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameAI : NSObject
@property(weak) NSMutableArray* map;
@property(weak) NSMutableArray* headpos;

-(int)shouldMoveDirection;
@end