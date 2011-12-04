//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Natalia Murashev on 12/4/11.
//  Copyright (c) 2011 Holler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end
