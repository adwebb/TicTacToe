//
//  ViewController.m
//  TicTacToe
//
//  Created by Matthew Voracek on 1/10/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
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
    
}

@property NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    whichPlayerLabel.text = @"X Player";
    [whichPlayerLabel sizeToFit];
    [self newTimer];
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
                
                UIAlertView *timeAlert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"Time Up!"]
                                                            message:@"Please switch players."
                                                           delegate:self
                                                  cancelButtonTitle:@"Aw, shucks."
                                                  otherButtonTitles:nil];
                [timeAlert show];
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
        }
        else if ([whichPlayerLabel.text isEqualToString:@"O Player"])
        {
            whichPlayerLabel.text = @"X Player";
        }
        [self newTimer];
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
        if([whichPlayerLabel.text isEqualToString:@"X Player"])
        {
            label.text = @"X";
            winner = [self whoOne];
            whichPlayerLabel.text = @"O Player";
            label.textColor = [UIColor blueColor];
        }
        else if ([whichPlayerLabel.text isEqualToString:@"O Player"])    {
            label.text = @"O";
            winner = [self whoOne];
            whichPlayerLabel.text = @"X Player";
            label.textColor = [UIColor redColor];
        }
    }
    [self newTimer];
    
    
    if([winner isEqualToString:label.text])
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: [NSString stringWithFormat: @"The Winner is %@ Player!",winner] message:@"Thanks for playing! Please play again soon!" delegate:self cancelButtonTitle:@"Play Again!" otherButtonTitles:@"Quit.", nil];
    [alert show];
        [self.timer invalidate];
        self.timer = nil;
    }
    
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
    
    return nil;
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
