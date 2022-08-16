//
//  CellStructures.m
//  Tetris
//
//  Created by Mingyu Liu on 2022-08-16.
//

#import <Foundation/Foundation.h>
#import "CellStructures.h"

@implementation CellLocation

- (id)initWithRow:(int)row andCol:(int)column {
    self.row = row;
    self.column = column;
    
    return self;
}

@end
