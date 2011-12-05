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
@synthesize history = _history;
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
        
        //when the period is entered, it is stored in the periodPressed array.
        //if the user entered more than 1 period, it does not get added to the outlets
        if([digit isEqualToString:@"."]) {
            [self.periodPressed addObject:digit];
            if([self.periodPressed count] == 1) {
                //adds the digit to the main calculator display
                self.display.text = [self.display.text stringByAppendingString:digit]; 
                //adds the digit to the history display
                self.history.text = [self.history.text stringByAppendingString:digit]; 
            }
            
        //when the user clicks on a digit (not a period), it is added to the outlets
        } else {
            self.display.text = [self.display.text stringByAppendingString:digit];
            self.history.text = [self.history.text stringByAppendingString:digit];
        }
        
    }
    
    //when the user is not in the middle of entering a number...
    else {
        //when a period is added first, it is added to the period pressed array
        if([digit isEqualToString:@"."]) {
            [self.periodPressed addObject:digit];
        }
        //adds the initial digit to the main calculator display
        self.display.text = digit;
        //adds the digit to the history display
        if(self.history.text == nil) {
            self.history.text = digit;
        } else {
            self.history.text = [self.history.text stringByAppendingString:digit];
        }
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
        
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.periodPressed removeAllObjects];
    self.history.text = [self.history.text stringByAppendingString:@" "];
    
}

- (IBAction)operationPressed:(UIButton *)sender 
{   
    if(self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];  
    double result = [self.brain performOperation:sender.currentTitle];
    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
    self.history.text = [self.history.text stringByAppendingString:sender.currentTitle];
    self.history.text = [self.history.text stringByAppendingString:@" "];
}

- (IBAction)clearPressed:(UIButton *)sender {
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.display.text = nil; 
    self.history.text = nil; 
    [self.periodPressed removeAllObjects];
    self.brain = nil;
}

- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
