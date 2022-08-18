//
//  TetrominoModel.m
//  Tetris
//
//  Created by Mingyu Liu on 2022-08-16.
//

#import <Foundation/Foundation.h>
#import "TetrominoModel.h"

@implementation TetrominoModel

-(id)initWithOrigin:(BlcokLocation *)origin withType:(BlockType)type withRotation:(int)rotation {
    self.origin = origin;
    self.blockType = type;
    self.rotation = rotation;
    
    return self;
}

-(NSArray<BlcokLocation *> *)blocks {
    return [TetrominoModel getBlocksBy:_blockType andBy:_rotation];
}

-(TetrominoModel *)moveBy:(int)row andBy:(int)col {
    BlcokLocation *newOrigin = [[BlcokLocation alloc] initWithRow:_origin.row + row andCol:_origin.column + col];
    return [[TetrominoModel alloc] initWithOrigin:newOrigin withType:_blockType withRotation:_rotation];
}

-(TetrominoModel *)rotateBy:(Boolean)isClockwise {
    return [[TetrominoModel alloc] initWithOrigin:_origin withType:_blockType withRotation:_rotation + (isClockwise ? 1 : -1)];
}

-(NSArray<BlcokLocation *> *)getKicksBy:(Boolean)isClockwise {
    return [TetrominoModel getKicksBy:_blockType andBy:_rotation lastlyBy:isClockwise];
}

+(NSArray<BlcokLocation *> *)getBlocksBy:(BlockType)blockType andBy:(int)rotation {
    NSArray<NSArray<BlcokLocation *> *> *allCells = [TetrominoModel getAllBlocksBy:blockType];
    
    int index = rotation % allCells.count;
    if (index < 0) {
        index += rotation % allCells.count;
    }
    
    return allCells[index];
}

+(NSArray<NSArray<BlcokLocation *> *> *)getAllBlocksBy:(BlockType)cellType {
    switch (cellType) {
        case i:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1]]];
        case o:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:1],
                       [[BlcokLocation alloc] initWithRow:1 andCol:1], [[BlcokLocation alloc] initWithRow:1 andCol:0]]];
        case t:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:1 andCol:0]],
                     @[[[BlcokLocation alloc] initWithRow:-1 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:1 andCol:0]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:-1 andCol:0]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:-1 andCol:0]]];
        case j:
            return @[@[[[BlcokLocation alloc] initWithRow:1 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:0], [[BlcokLocation alloc] initWithRow:1 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:-1 andCol:1], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:0], [[BlcokLocation alloc] initWithRow:-1 andCol:-1]]];
        case l:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:1 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:0], [[BlcokLocation alloc] initWithRow:-1 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:-1 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:0], [[BlcokLocation alloc] initWithRow:1 andCol:-1]]];
        case s:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:1 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:-1 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:0], [[BlcokLocation alloc] initWithRow:-1 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:-1 andCol:0]]];
        case z:
            return @[@[[[BlcokLocation alloc] initWithRow:1 andCol:-1], [[BlcokLocation alloc] initWithRow:1 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:1], [[BlcokLocation alloc] initWithRow:0 andCol:1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:-1 andCol:0]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:0], [[BlcokLocation alloc] initWithRow:-1 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:1 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:0],
                       [[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:-1 andCol:-1]]];
    }
}

+(TetrominoModel *)createNewTetrominoBy:(int)numRows andBy:(int)numCols {
    BlockType randomType = (BlockType) (arc4random() % (int)z);
    
    int maxRow = 0;
    for (BlcokLocation *cell in [TetrominoModel getBlocksBy:randomType andBy:0]) {
        maxRow = MAX(maxRow, cell.row);
    }
    
    BlcokLocation *origin = [[BlcokLocation alloc] initWithRow:numRows - 1 - maxRow andCol:(numCols - 1) / 2];
    return [[TetrominoModel alloc] initWithOrigin:origin withType:randomType withRotation:0];
}

+(NSArray<BlcokLocation *> *)getKicksBy:(BlockType)cellType andBy:(int)rotation lastlyBy:(Boolean)isClockwise {
    int rotationCount = (int)[TetrominoModel getAllKicksBy:cellType].count;
    
    int index = rotation % rotationCount;
    if (index < 0) {
        index += rotationCount;
    }
    
    NSArray<BlcokLocation *> *kicks = [TetrominoModel getAllKicksBy:cellType][index];
    if (!isClockwise) {
        NSMutableArray<BlcokLocation *> *counterKicks = [NSMutableArray array];
        for (BlcokLocation *kick in kicks) {
            [counterKicks addObject:[[BlcokLocation alloc] initWithRow:-1 * kick.row andCol:-1 * kick.column]];
        }
        kicks = counterKicks;
    }
    
    return kicks;
}

+(NSArray<NSArray<BlcokLocation *> *> *)getAllKicksBy:(BlockType)cellType; {
    switch (cellType) {
        case o:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:0]]];
        case i:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:-2],
                       [[BlcokLocation alloc] initWithRow:0 andCol:1], [[BlcokLocation alloc] initWithRow:-1 andCol:-2],
                       [[BlcokLocation alloc] initWithRow:2 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:2], [[BlcokLocation alloc] initWithRow:2 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:2]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:2],
                       [[BlcokLocation alloc] initWithRow:0 andCol:-1], [[BlcokLocation alloc] initWithRow:1 andCol:2],
                       [[BlcokLocation alloc] initWithRow:-2 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:1],
                       [[BlcokLocation alloc] initWithRow:0 andCol:-2], [[BlcokLocation alloc] initWithRow:-2 andCol:1],
                       [[BlcokLocation alloc] initWithRow:1 andCol:-2]]];
        default:
            return @[@[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:1 andCol:-1], [[BlcokLocation alloc] initWithRow:0 andCol:-2],
                       [[BlcokLocation alloc] initWithRow:-2 andCol:-1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:1],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:1], [[BlcokLocation alloc] initWithRow:2 andCol:0],
                       [[BlcokLocation alloc] initWithRow:1 andCol:2]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:1],
                       [[BlcokLocation alloc] initWithRow:1 andCol:1], [[BlcokLocation alloc] initWithRow:-2 andCol:0],
                       [[BlcokLocation alloc] initWithRow:-2 andCol:1]],
                     @[[[BlcokLocation alloc] initWithRow:0 andCol:0], [[BlcokLocation alloc] initWithRow:0 andCol:-1],
                       [[BlcokLocation alloc] initWithRow:-1 andCol:-1], [[BlcokLocation alloc] initWithRow:2 andCol:0],
                       [[BlcokLocation alloc] initWithRow:2 andCol:-1]]];
    }
}

@end
