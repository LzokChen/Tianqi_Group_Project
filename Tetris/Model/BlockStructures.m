//
//  BlockStructures.m
//  Tetris
//
//  Created by Mingyu Liu on 2022-08-16.
//

#import <Foundation/Foundation.h>
#import "BlockStructures.h"

@implementation BlockLocation

- (id)initWithRow:(int)row andCol:(int)column {
    self.row = row;
    self.column = column;
    
    return self;
}

@end

@implementation TetrisGameBlock

- (id)initWithType:(BlockType)blockTpye{
    self = [super init];
    self.blockType = blockTpye;
    return self;
}

@end
