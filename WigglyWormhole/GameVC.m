//
//  ViewController.m
//  WigglyWormhole
//
//  Created by Alex on 21/10/2014.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "GameVC.h"
#import "Macro.h"





#define _DEBUG
@interface GameVC ()


@end

@implementation GameVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initial game
    _game=[[Game alloc]initWithCofig:self.appDataModel];
    
  
    

    
    //initial view
    self.view.backgroundColor=[UIColor blackColor];
    self.uiGameTitle.text=_game.title;
    self.uiGameTitle.textColor=[UIColor whiteColor];
    self.uiGameScore.text=[[NSString alloc]initWithFormat:@"%d",_game.score];
    self.uiGameScore.textColor=[UIColor whiteColor];
    
    //init gesture
    [self initGestureRecognizer];
    
    //initial scene
    CGPoint sceneOrigin=CGPointMake(SCENE_X, SCENE_Y);
    CGSize  sceneSize=CGSizeMake(SCENE_WIDTH, SCENE_HEIGHT);
    CGRect  sceneRect=CGRectMake(sceneOrigin.x, sceneOrigin.y, sceneSize.width, sceneSize.height);
    _gameScene=[[GameScene alloc]initWithFrame:sceneRect withMap:self.game.map];
    _gameScene.backgroundColor=[UIColor whiteColor];
    
    //gameai
    if (self.aiEnabled) {
        _gameAI=[[GameAI alloc]init];
    }
    
    //gameScene adjust
    _gameScene.transform=CGAffineTransformScale(_gameScene.transform, 0.8, 0.8);
    _gameScene.transform=CGAffineTransformTranslate(_gameScene.transform, -35, -60);
    [self.view addSubview:_gameScene];
    [self loadGame];
    self.navigationController.navigationBarHidden=YES;
    
  
    
    

    
    
}

-(void)loadGame
{
    _game=[[Game alloc]initWithCofig:self.appDataModel];
    self.gameScene.map=self.game.map;
    self.uiGameScore.text=[NSString stringWithFormat:@"%5d",self.game.score];
    [self.gameScene setNeedsDisplay];
    _countDownLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 100, 200, 200)];
    _countDownLabel.font=[UIFont fontWithName:@"Hiragino Mincho ProN" size:150];
    [_countDownLabel setTextColor:[UIColor whiteColor]];
  
    [self.view addSubview:_countDownLabel];
    
    
    _nsCountDown=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:true];
    _countDownSec=3;

    
}
-(void)countDown
{
    
    if (_countDownSec>0) {
        [_countDownLabel setText:[NSString stringWithFormat:@"%d",_countDownSec]];
        _countDownSec--;
        
        
    }
    else
    {
        [self.nsCountDown invalidate];
        [_countDownLabel removeFromSuperview];
        _nsTimer=[NSTimer scheduledTimerWithTimeInterval:1.0/(self.game.speed) target:self selector:@selector(update) userInfo:nil repeats:true];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)update
{
    if (self.aiEnabled) {
        self.gameAI.map=self.game.map;
        self.gameAI.headpos=self.game.headPosArr;
        int direction=[self.gameAI shouldMoveDirection];
        switch (direction) {
            case UP:
                [self.game wormUp];
                break;
            case DOWN:
                [self.game wormDown];
                break;
            case RIGHT:
                [self.game wormRight];
            case LEFT:
                [self.game wormLeft];
        }
    }
    [self.game update];
    self.uiGameScore.text=[NSString stringWithFormat:@"%5d",self.game.score];
    self.gameScene.map=self.game.map;
    [self.gameScene setNeedsDisplay];
    
    if (self.game.wormDirection==DIRECTION_NONE) {
        
        NSString*alertTitle=nil;
        NSString*alertMsg=nil;
        
        BOOL topten=[self.appDataModel isTopTen:self.game.score];
        if (!self.aiEnabled) {
            if (topten) {
                alertTitle=[NSString stringWithFormat:@"Well done, %@!\nU enter TopTen!!!",self.appDataModel.usrName];
                alertMsg=[NSString stringWithFormat:@"You scored %d",self.game.score];
                
                [self.appDataModel updateTopTen:self.game.score];
                
                
            }
            else
            {
                alertTitle=[NSString stringWithFormat:@"Oh no, you died!\nTry harder to enter top ten"];
                alertMsg=[NSString stringWithFormat:@"You scored %d",self.game.score];
                
                
            }

        }
        else
        {
            if (topten) {
                alertTitle=[NSString stringWithFormat:@"Try harder, %@!\nAI enter TopTen!!!",self.appDataModel.usrName];
                alertMsg=[NSString stringWithFormat:@"AI scored %d",self.game.score];
            }
            else
            {
                alertTitle=[NSString stringWithFormat:@"Stupid AI!!!"];
                alertMsg=[NSString stringWithFormat:@"AI scored %d",self.game.score];

            }
        }
                 UIAlertView* alert=[[UIAlertView alloc] initWithTitle:alertTitle
                                                      message:alertMsg
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        
        [alert show];
        [_nsTimer invalidate];
    
    }
    
}

- (IBAction)pressUp:(id)sender {
    if (!self.aiEnabled) {
       [self.game wormUp];
    }
    
   
  
}
- (IBAction)pressRight:(id)sender {
    if (!self.aiEnabled) {
        [self.game wormRight];
    }

}

- (IBAction)pressDown:(id)sender {
    if (!self.aiEnabled) {
        [self.game wormDown];
    }
   
}

- (IBAction)pressLeft:(id)sender {
    if (!self.aiEnabled) {
        [self.game wormLeft];
    }
   
}



//gesture
-(void)initGestureRecognizer
{
    //left
    UISwipeGestureRecognizer*swipeLeftRecognizer=
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeftRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;
    swipeLeftRecognizer.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    
    //right
    UISwipeGestureRecognizer*swipeRightRecognizer=
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRightRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    swipeRightRecognizer.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:swipeRightRecognizer];

    //up
    UISwipeGestureRecognizer*swipeUpRecognizer=
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUpRecognizer.direction=UISwipeGestureRecognizerDirectionUp;
    swipeUpRecognizer.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:swipeUpRecognizer];
    
    //down
    UISwipeGestureRecognizer*swipeDownRecognizer=
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDownRecognizer.direction=UISwipeGestureRecognizerDirectionDown;
    swipeDownRecognizer.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:swipeDownRecognizer];
}

-(void)swipeLeft
{
    [self.game wormLeft];
  
}
-(void)swipeRight
{
    [self.game wormRight];
   
}
-(void)swipeDown
{
    [self.game wormDown];
}
-(void)swipeUp
{
    [self.game wormUp];
}
- (IBAction)wormDead:(id)sender {
    [_nsCountDown invalidate];
  [_nsTimer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
  
       self.navigationController.navigationBarHidden=NO;
}

-(void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if (buttonIndex==0) {
     
        [self loadGame];
    }
}


@end
