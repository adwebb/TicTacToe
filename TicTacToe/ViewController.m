//
//  ViewController.m
//  TicTacToe
//
//  Created by Andrew Webb on 1/10/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
{
    __weak IBOutlet UILabel *myLabelOne;
    __weak IBOutlet UILabel *myLabelTwo;
    __weak IBOutlet UILabel *myLabelThree;
    __weak IBOutlet UILabel *myLabelFour;
    __weak IBOutlet UILabel *myLabelFive;
    __weak IBOutlet UILabel *myLabelSix;
    __weak IBOutlet UILabel *myLabelSeven;
    __weak IBOutlet UILabel *myLabelEight;
    __weak IBOutlet UILabel *myLabelNine;
    __weak IBOutlet UILabel *whichPlayerLabel;
    __weak IBOutlet UILabel *timerLabel;
    __weak IBOutlet UILabel *dragLabel;
    CGAffineTransform transform;
    int turnCount;
    BOOL aiGame;
    
}

@property NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    whichPlayerLabel.text = @"X Player";
    dragLabel.text = @"X";
    dragLabel.textColor = [UIColor blueColor];
    [whichPlayerLabel sizeToFit];
    transform = dragLabel.transform;
    turnCount = 0;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIAlertView *timeAlert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"Game Mode:"]
                                                        message:@"How would you like to play TicTacToe?"
                                                       delegate:self
                                              cancelButtonTitle:@"Vs Computer"
                                              otherButtonTitles:@"Two Players", nil];
    [timeAlert show];

}

-(void) newTimer
{
    [self.timer invalidate];
    self.timer = nil;
    timerLabel.textColor = [UIColor blackColor];
    timerLabel.text = [NSString stringWithFormat:@"10"];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

-(void)updateTimer
{
    if ([timerLabel.text intValue] > 0) {
        int counter = [timerLabel.text intValue] - 1;
        timerLabel.text = [NSString stringWithFormat:@"%i", counter];
            if (counter < 6) {
                timerLabel.textColor = [UIColor redColor];
            }
            if (counter <= 0) {
                
               if(aiGame == NO)
               {
                   
               UIAlertView *timeAlert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"Time Up!"]
                                                            message:@"Please switch players."
                                                           delegate:self
                                                  cancelButtonTitle:@"Aw, shucks."
                                                  otherButtonTitles:nil];
               [timeAlert show];
               }
               else if(aiGame == YES)
               {
                UIAlertView *timeAlert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"Time Up!"]
                                                                       message:@"You lost your turn!"
                                                                      delegate:self
                                                             cancelButtonTitle:@"Aw, shucks."
                                                             otherButtonTitles:nil];
                 [timeAlert show];
               }
                
                [self.timer invalidate];
            
        }
    }
}


-(void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alert.message isEqualToString:@"Thanks for playing! Please play again soon!"]) {
        [self newTimer];
        switch (buttonIndex) {
            case 0:
                myLabelOne.text = @"";
                myLabelTwo.text = @"";
                myLabelThree.text = @"";
                myLabelFour.text = @"";
                myLabelFive.text = @"";
                myLabelSix.text = @"";
                myLabelSeven.text = @"";
                myLabelEight.text = @"";
                myLabelNine.text = @"";
                [self newTimer];
                turnCount = 0;
                break;
            case 1:
                exit(0);
            default:
                break;
        }
    } else if ([alert.message isEqualToString:@"Please switch players."])
    {
        if([whichPlayerLabel.text isEqualToString:@"X Player"])
        {
            whichPlayerLabel.text = @"O Player";
            dragLabel.text = @"O";
            dragLabel.textColor = [UIColor redColor];
        }
        else if ([whichPlayerLabel.text isEqualToString:@"O Player"])
        {
            whichPlayerLabel.text = @"X Player";
            dragLabel.text = @"X";
            dragLabel.textColor = [UIColor blueColor];
        }

        [whichPlayerLabel sizeToFit];
        [self newTimer];
    }else if ([alert.title isEqualToString:@"Game Mode:"])
    {
        [self newTimer];
        switch (buttonIndex)
        {
            case 0:
                aiGame = YES;
                break;
            case 1:
                aiGame = NO;
                break;
            default:
                break;
                
        }
        
    }else if([alert.message isEqualToString:@"You lost your turn!"])
    {
        
        [self newTimer];
        [self aiTurn];
    }
}

-(void) aiTurn
{
    NSInteger aiSelection = (arc4random()%9);
    NSString *winner;
    UILabel *label;
    
    
    switch (aiSelection)
    {
        case 0:
            if([myLabelOne.text isEqualToString:@""])
            {
                label = myLabelOne;
            }
            break;
        case 1:
            if([myLabelTwo.text isEqualToString:@""])
            {
                label = myLabelTwo;
            }
            break;
        case 2:
            if([myLabelThree.text isEqualToString:@""])
            {
                label = myLabelThree;
            }
            break;
        case 3:
            if([myLabelFour.text isEqualToString:@""])
            {
                label = myLabelFour;
            }
            break;
        case 4:
            if([myLabelFive.text isEqualToString:@""])
            {
                label = myLabelFive;
            }
            break;
        case 5:
            if([myLabelSix.text isEqualToString:@""])
            {
                label = myLabelSix;
            }
            break;
        case 6:
            if([myLabelSeven.text isEqualToString:@""])
            {
                label = myLabelSeven;
            }
            break;
        case 7:
            if([myLabelEight.text isEqualToString:@""])
            {
                label = myLabelEight;
            }
            break;
        case 8:
            if([myLabelNine.text isEqualToString:@""])
            {
                label = myLabelNine;
            }
            break;
        default:
            [self aiTurn];
            break;
    }
    
    if([label.text isEqualToString:@""])
    {
        label.text = [NSString stringWithFormat:@"O"];
        label.textColor = [UIColor redColor];
        winner = [self whoOne];
        whichPlayerLabel.text = @"X Player";
        [self newTimer];
        turnCount++;
    }
    else{
        [self aiTurn];
        }
    
    
    if([winner isEqualToString:@"O"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"The Computer Wins!"] message:@"Thanks for playing! Please play again soon!" delegate:self cancelButtonTitle:@"Play Again!" otherButtonTitles:@"Quit.", nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
    }else if ([winner isEqualToString:@"X"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"You Win!"] message:@"Thanks for playing! Please play again soon!" delegate:self cancelButtonTitle:@"Play Again!" otherButtonTitles:@"Quit.", nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
    }else if(turnCount == 9)
    {
        turnCount = 0;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"Cats Game! No one wins!"] message:@"Thanks for playing! Please play again soon!" delegate:self cancelButtonTitle:@"Play Again!" otherButtonTitles:@"Quit.", nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
        
    }
    
    
}

-(NSString*)whoOne
{
    NSString * xOrO = [NSString stringWithFormat:@"%c",[whichPlayerLabel.text characterAtIndex:0]];
    if(([myLabelOne.text isEqualToString:xOrO]
       && [myLabelTwo.text isEqualToString:xOrO]
       && [myLabelThree.text isEqualToString:xOrO])
       || ([myLabelFour.text isEqualToString:xOrO]
           && [myLabelFive.text isEqualToString:xOrO]
           && [myLabelSix.text isEqualToString:xOrO])
        || ([myLabelSeven.text isEqualToString:xOrO]
            && [myLabelEight.text isEqualToString:xOrO]
            && [myLabelNine.text isEqualToString:xOrO])
        || ([myLabelOne.text isEqualToString:xOrO]
            && [myLabelFour.text isEqualToString:xOrO]
            && [myLabelSeven.text isEqualToString:xOrO])
        || ([myLabelTwo.text isEqualToString:xOrO]
            && [myLabelFive.text isEqualToString:xOrO]
            && [myLabelEight.text isEqualToString:xOrO])
        || ([myLabelThree.text isEqualToString:xOrO]
            && [myLabelSix.text isEqualToString:xOrO]
            && [myLabelNine.text isEqualToString:xOrO])
        || ([myLabelOne.text isEqualToString:xOrO]
            && [myLabelFive.text isEqualToString:xOrO]
            && [myLabelNine.text isEqualToString:xOrO])
        || ([myLabelThree.text isEqualToString:xOrO]
            && [myLabelFive.text isEqualToString:xOrO]
            && [myLabelSeven.text isEqualToString:xOrO]))
        
    {
        NSLog(@"@%",xOrO);
        return xOrO;
    }
    {NSLog(@"no winner yet");}
    return nil;
}

-(void)takeATurn:(UILabel *)label
{
    NSString *winner;
    if([label.text isEqualToString:@""])
    {
        if([whichPlayerLabel.text isEqualToString:@"X Player"] && aiGame == NO)
        {
            dragLabel.textColor = [UIColor redColor];
            label.textColor = [UIColor blueColor];
            label.text = @"X";
            winner = [self whoOne];
            whichPlayerLabel.text = @"O Player";
            [whichPlayerLabel sizeToFit];
            dragLabel.text = @"O";
            
        }
        else if ([whichPlayerLabel.text isEqualToString:@"O Player"] && aiGame == NO)    {
            dragLabel.textColor = [UIColor blueColor];
            label.textColor = [UIColor redColor];
            label.text = @"O";
            winner = [self whoOne];
            whichPlayerLabel.text = @"X Player";
            [whichPlayerLabel sizeToFit];
            dragLabel.text = @"X";
        }
        else if (aiGame == YES)
        {
            label.textColor = [UIColor blueColor];
            dragLabel.textColor = [UIColor blueColor];
            label.text = @"X";
            winner = [self whoOne];
            whichPlayerLabel.text = @"O Player";
            [whichPlayerLabel sizeToFit];
            
        }
        turnCount++;
        [self newTimer];
    }
    
    
    
    
    if([winner isEqualToString:@"X"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"X Player Wins!"] message:@"Thanks for playing! Please play again soon!" delegate:self cancelButtonTitle:@"Play Again!" otherButtonTitles:@"Quit.", nil];
        [alert show];
            [self.timer invalidate];
            self.timer = nil;
    }else if([winner isEqualToString:@"O"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"O Player Wins!"] message:@"Thanks for playing! Please play again soon!" delegate:self cancelButtonTitle:@"Play Again!" otherButtonTitles:@"Quit.", nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
    }else if(turnCount == 9)
    {
        turnCount = 0;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"Cats Game! No one wins!"] message:@"Thanks for playing! Please play again soon!" delegate:self cancelButtonTitle:@"Play Again!" otherButtonTitles:@"Quit.", nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;

    }else if(aiGame == YES && winner == nil && label != nil)
        [self aiTurn];
}

-(UILabel*)findLabelUsingPoint:(CGPoint)point
{
    
    if(CGRectContainsPoint(myLabelOne.frame, point))
        {
            return myLabelOne;
        }
    if(CGRectContainsPoint(myLabelTwo.frame, point))
       {
           return myLabelTwo;
       }
    if(CGRectContainsPoint(myLabelThree.frame, point))
    {
        return myLabelThree;
    }
    if(CGRectContainsPoint(myLabelFour.frame, point))
    {
        return myLabelFour;
    }
    if(CGRectContainsPoint(myLabelFive.frame, point))
    {
        return myLabelFive;
    }
    if(CGRectContainsPoint(myLabelSix.frame, point))
    {
        return myLabelSix;
    }
    if(CGRectContainsPoint(myLabelSeven.frame, point))
    {
        return myLabelSeven;
    }
    if(CGRectContainsPoint(myLabelEight.frame, point))
    {
        return myLabelEight;
    }
    if(CGRectContainsPoint(myLabelNine.frame, point))
    {
        return myLabelNine;
    }
    if(CGRectContainsPoint(dragLabel.frame, point))
    {
        return dragLabel;
    }
    
    return nil;
}

- (IBAction)onDrag:(UIPanGestureRecognizer*)panGesture
{
    CGPoint point;
    if(panGesture.state != UIGestureRecognizerStateEnded)
    {
        point = [panGesture translationInView:self.view];
        //if([self findLabelUsingPoint:point] == dragLabel)
       // {
            dragLabel.transform = CGAffineTransformMakeTranslation(point.x, point.y);
        
            point.x += dragLabel.center.x;
            point.y += dragLabel.center.y;
       // }
    } else {
        [UIView animateWithDuration:0.5f animations:^{
            dragLabel.transform = transform;
        }];
        point = [panGesture translationInView:self.view];
        point.x += dragLabel.center.x;
        point.y += dragLabel.center.y;
        [self takeATurn:[self findLabelUsingPoint:point]];
    }
    NSLog(@"dragging like a dragon");
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *)tapGestureRecognizer
{
    CGPoint point = [tapGestureRecognizer locationOfTouch:.1 inView:self.view];
    [self takeATurn:[self findLabelUsingPoint:point]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
