//
//  Game.m
//  WigglyWormhole
//
//  Created by Alex on 21/10/2014.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "Game.h"
#import "Macro.h"

//game constants



@implementation Game
{
    NSMutableArray*_wormArr;
}


-(id)init
{
    if (self=[super init]) {
        _title=GAME_TITLE;
        _score=0;
        _wormDirection=DOWN;
        [self initMap];
        
         NSMutableArray*head=[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:10],
             [NSNumber numberWithInt:7],
                              nil];
        
        _wormArr=[NSMutableArray arrayWithObjects:
                  head,
                  nil];
        
        
        
    }
    return self;
}

-(void) initMap
{
 
    _map=[NSMutableArray arrayWithCapacity:20];
    for (int i=0; i<20; i++) {
        NSMutableArray*line=[NSMutableArray arrayWithCapacity:14];
        [_map addObject:line];
        for (int j=0; j<14; j++) {
            [line addObject:[NSNumber numberWithInt:0]];
        }
    }
    
    
    for (int i=0; i<WORM_HOLE_NUMBER;) {
        int x=RAND_FROM_TO(0, 19);
        int y=RAND_FROM_TO(0, 13);
        if ([_map[x][y] integerValue]==GRASS_LAND_INDEX) {
            _map[x][y]=[NSNumber numberWithInt:WORM_HOLE_INDEX];
            i++;
        }
    }
    
    for (int i=0; i<MUSHROOM_NUMBER; ) {
        int x=RAND_FROM_TO(0, 19);
        int y=RAND_FROM_TO(0, 13);
        if ([_map[x][y] integerValue]==GRASS_LAND_INDEX) {
            _map[x][y]=[NSNumber numberWithInt:MUSHROOM_INDEX];
            i++;
        }

    }
    
    _map[10][7]=[NSNumber numberWithInt:WORM_FACE_INDEX];
    
}
-(void)update
{
    int headx=[_wormArr[0][0] integerValue];
    int heady=[_wormArr[0][1] integerValue];
    int tailx=[[_wormArr lastObject][0] integerValue];
    int taily=[[_wormArr lastObject][1] integerValue];
    int nextx,nexty;
    switch (_wormDirection) {
        case UP:
            nexty=heady;
            nextx=headx-1;
            if ([_map[nextx][nexty]integerValue]==MUSHROOM_INDEX) {
                
                //update map
                _map[nextx][nexty]=[NSNumber numberWithInt:WORM_FACE_INDEX];
                _map[headx][heady]=[NSNumber numberWithInt:WORM_BODY_INDEX];
                //add new head
                [_wormArr insertObject:[NSMutableArray arrayWithObjects:
                                        [NSNumber numberWithInt:nextx],
                                        [NSNumber numberWithInt:nexty],
                                        nil] atIndex:0];
                //leave tail there
                
            }
            else
            {
                //update map
                _map[nextx][nexty]=[NSNumber numberWithInt:WORM_FACE_INDEX];
                _map[headx][heady]=[NSNumber numberWithInt:WORM_BODY_INDEX];
                _map[tailx][taily]=[NSNumber numberWithInt:GRASS_LAND_INDEX];
                //add new head
                [_wormArr insertObject:[NSMutableArray arrayWithObjects:
                                        [NSNumber numberWithInt:nextx],
                                        [NSNumber numberWithInt:nexty],
                                        nil] atIndex:0];

                //cut tail
                [_wormArr removeLastObject];
                
                
                
            }
            
            break;
        case DOWN:
          
            break;
        case LEFT:
           
            break;
        case RIGHT:
           
        default:
            break;
    }
    _score+=10;
}

-(void)wormDown
{
    _wormDirection=DOWN;
}
-(void)wormUp
{
    _wormDirection=UP;
}
-(void)wormLeft
{
    _wormDirection=LEFT;
}
-(void)wormRight
{
    _wormDirection=RIGHT;
}
@end
