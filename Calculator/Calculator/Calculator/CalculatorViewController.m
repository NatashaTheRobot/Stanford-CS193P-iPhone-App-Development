//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Natalia Murashev on 12/4/11.
//  Copyright (c) 2011 Holler. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSMutableArray *periodPressed;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize periodPressed = _periodPressed;

- (CalculatorBrain *) brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (NSMutableArray *) periodPressed
{
    if(_periodPressed == nil)_periodPressed = [[NSMutableArray alloc] init];
    return _periodPressed;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    
    if(self.userIsInTheMiddleOfEnteringANumber) {
        if([digit isEqualToString:@"."]) {
            [self.periodPressed addObject:digit];
            if([self.periodPressed count] == 1) {
                self.display.text = [self.display.text stringByAppendingString:digit];  
            }
        } else {
            self.display.text = [self.display.text stringByAppendingString:digit];  
        }
        
    }
    else {
        if([digit isEqualToString:@"."]) {
            [self.periodPressed addObject:digit];
        }
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
        
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.periodPressed removeAllObjects];
}

- (IBAction)operationPressed:(UIButton *)sender 
{   
    if(self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}


@end
