//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Natalia Murashev on 12/4/11.
//  Copyright (c) 2011 Holler. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray *operandStack;
 
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if(_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject != nil) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
    
}


- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    } else if([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    } else if([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    } else if([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    } else if([operation isEqualToString:@"π"]) {
        result = M_PI;
    } else if([operation isEqualToString:@"log"]) {
        result = log([self popOperand]);
    } 
    
    
    [self pushOperand:result];
    
    return result;
}


@end
