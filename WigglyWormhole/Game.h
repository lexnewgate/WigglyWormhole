//
//  Game.h
//  WigglyWormhole
//
//  Created by Alex on 21/10/2014.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Game : NSObject

@property (strong) NSString*title;
@property (assign) int score;
@property (assign) int wormSpeed;
@property (assign) int wormDirection;
@property (assign) int wormPosX;
@property (assign) int wormPosY;

-(void)update;
-(void)wormDown;
-(void)wormUp;
-(void)wormLeft;
-(void)wormRight;



@end