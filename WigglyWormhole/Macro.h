//
//  Macro.h
//  WigglyWormhole
//
//  Created by Alex on 21/10/2014.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#ifndef WigglyWormhole_Macro_h
#define WigglyWormhole_Macro_h


#define CELL_SIZE 20

#define SCENE_WIDTH (14*20)
#define SCENE_HEIGHT (20*20)
#define SCENE_X 40
#define SCENE_Y 60
#define SCENE_CELLS_X 14
#define SCENE_CELLS_Y 20

//direction
#define UP 0
#define LEFT 1
#define RIGHT 2
#define DOWN 3
#define SPEED 1

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))




#endif