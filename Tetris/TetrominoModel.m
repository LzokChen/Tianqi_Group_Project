//
//  TetrominoModel.m
//  Tetris
//
//  Created by Mingyu Liu on 2022-08-16.
//

#import <Foundation/Foundation.h>
#import "TetrominoModel.h"

@implementation TetrominoModel

-(id)initWithOrigin:(CellLocation *)origin andType:(CellType)type andRotation:(int)rotation {
    self.origin = origin;
    self.cellType = type;
    self.rotation = rotation;
    
    return self;
}

-(NSArray<CellLocation *> *)cells {
    return [TetrominoModel getCellsBy:_cellType andBy:_rotation];
}

-(TetrominoModel *)moveBy:(int)row andBy:(int)col {
    CellLocation *newOrigin = [[CellLocation alloc] initWithRow:_origin.row + row andCol:_origin.column + col];
    return [[TetrominoModel alloc] initWithOrigin:newOrigin andType:_cellType andRotation:_rotation];
}

-(TetrominoModel *)rotateBy:(Boolean)isClockwise {
    return [[TetrominoModel alloc] initWithOrigin:_origin andType:_cellType andRotation:_rotation + (isClockwise ? 1 : -1)];
}

-(NSArray<CellLocation *> *)getKicksBy:(Boolean)isClockwise {
    return [TetrominoModel getKicksBy:_cellType andBy:_rotation lastlyBy:isClockwise];
}

+(NSArray<CellLocation *> *)getCellsBy:(CellType)blockType andBy:(int)rotation {
    NSArray<NSArray<CellLocation *> *> *allCells = [TetrominoModel getAllCellsBy:blockType];
    
    int index = rotation % allCells.count;
    if (index < 0) {
        index += rotation % allCells.count;
    }
    
    return allCells[index];
}

+(NSArray<NSArray<CellLocation *> *> *)getAllCellsBy:(CellType)cellType {
    switch (cellType) {
        case i:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1]]];
        case o:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:1],
                       [[CellLocation alloc] initWithRow:1 andCol:1], [[CellLocation alloc] initWithRow:1 andCol:0]]];
        case t:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:1 andCol:0]],
                     @[[[CellLocation alloc] initWithRow:-1 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:1 andCol:0]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:-1 andCol:0]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:-1 andCol:0]]];
        case j:
            return @[@[[[CellLocation alloc] initWithRow:1 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:-1 andCol:0], [[CellLocation alloc] initWithRow:1 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:-1 andCol:1], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:-1 andCol:0], [[CellLocation alloc] initWithRow:-1 andCol:-1]]];
        case l:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:1 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:-1 andCol:0], [[CellLocation alloc] initWithRow:-1 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:-1 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:-1 andCol:0], [[CellLocation alloc] initWithRow:1 andCol:-1]]];
        case s:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:1 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:-1 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:-1 andCol:0], [[CellLocation alloc] initWithRow:-1 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:-1 andCol:0]]];
        case z:
            return @[@[[[CellLocation alloc] initWithRow:1 andCol:-1], [[CellLocation alloc] initWithRow:1 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:1], [[CellLocation alloc] initWithRow:0 andCol:1],
                       [[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:-1 andCol:0]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:-1 andCol:0], [[CellLocation alloc] initWithRow:-1 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:1 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:0],
                       [[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:-1 andCol:-1]]];
    }
}

+(TetrominoModel *)createNewTetrominoBy:(int)numRows andBy:(int)numCols {
    CellType randomType = (CellType) (arc4random() % (int)z);
    
    int maxRow = 0;
    for (CellLocation *cell in [TetrominoModel getCellsBy:randomType andBy:0]) {
        maxRow = MAX(maxRow, cell.row);
    }
    
    CellLocation *origin = [[CellLocation alloc] initWithRow:numRows - 1 - maxRow andCol:(numCols - 1) / 2];
    return [[TetrominoModel alloc] initWithOrigin:origin andType:randomType andRotation:0];
}

+(NSArray<CellLocation *> *)getKicksBy:(CellType)cellType andBy:(int)rotation lastlyBy:(Boolean)isClockwise {
    int rotationCount = (int)[TetrominoModel getAllKicksBy:cellType].count;
    
    int index = rotation % rotationCount;
    if (index < 0) {
        index += rotationCount;
    }
    
    NSArray<CellLocation *> *kicks = [TetrominoModel getAllKicksBy:cellType][index];
    if (!isClockwise) {
        NSMutableArray<CellLocation *> *counterKicks = [NSMutableArray array];
        for (CellLocation *kick in kicks) {
            [counterKicks addObject:[[CellLocation alloc] initWithRow:-1 * kick.row andCol:-1 * kick.column]];
        }
        kicks = counterKicks;
    }
    
    return kicks;
}

+(NSArray<NSArray<CellLocation *> *> *)getAllKicksBy:(CellType)cellType; {
    switch (cellType) {
        case o:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:0]]];
        case i:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:-2],
                       [[CellLocation alloc] initWithRow:0 andCol:1], [[CellLocation alloc] initWithRow:-1 andCol:-2],
                       [[CellLocation alloc] initWithRow:2 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:0 andCol:2], [[CellLocation alloc] initWithRow:2 andCol:-1],
                       [[CellLocation alloc] initWithRow:-1 andCol:2]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:2],
                       [[CellLocation alloc] initWithRow:0 andCol:-1], [[CellLocation alloc] initWithRow:1 andCol:2],
                       [[CellLocation alloc] initWithRow:-2 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:1],
                       [[CellLocation alloc] initWithRow:0 andCol:-2], [[CellLocation alloc] initWithRow:-2 andCol:1],
                       [[CellLocation alloc] initWithRow:1 andCol:-2]]];
        default:
            return @[@[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:1 andCol:-1], [[CellLocation alloc] initWithRow:0 andCol:-2],
                       [[CellLocation alloc] initWithRow:-2 andCol:-1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:1],
                       [[CellLocation alloc] initWithRow:-1 andCol:1], [[CellLocation alloc] initWithRow:2 andCol:0],
                       [[CellLocation alloc] initWithRow:1 andCol:2]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:1],
                       [[CellLocation alloc] initWithRow:1 andCol:1], [[CellLocation alloc] initWithRow:-2 andCol:0],
                       [[CellLocation alloc] initWithRow:-2 andCol:1]],
                     @[[[CellLocation alloc] initWithRow:0 andCol:0], [[CellLocation alloc] initWithRow:0 andCol:-1],
                       [[CellLocation alloc] initWithRow:-1 andCol:-1], [[CellLocation alloc] initWithRow:2 andCol:0],
                       [[CellLocation alloc] initWithRow:2 andCol:-1]]];
    }
}

@end
