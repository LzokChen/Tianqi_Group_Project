//
//  TetrominoModel.m
//  Tetris
//
//  Created by Mingyu Liu on 2022-08-16.
//

#import <Foundation/Foundation.h>
#import "TetrominoModel.h"

@implementation TetrominoModel

-(id)initWithOrigin:(CellLocation *)origin andType:(CellType *)type {
    
}

-(CellLocation *)cells {
    
}

-(TetrominoModel *)moveBy:(int)row andBy:(int)col {
    
}

-(TetrominoModel *)rotateBy:(Boolean)isClockwise {
    
}

-(NSArray<CellLocation *> *)getKicksBy:(Boolean)isClockwise {
    
}

+(NSArray<CellLocation *> *)getCellsBy:(CellType *)blockType andBy:(int)rotation {
    
}

+(NSArray<NSArray<CellLocation *> *> *)getAllCellsBy:(CellType *)cellType {
    
}

+(TetrominoModel *)createNewTetrominoBy:(int)numRows andBy:(int)numCols {
    
}

+(NSArray<CellLocation *> *)getKicksBy:(CellType *)cellType andBy:(int)rotation lastlyBy:(Boolean)isClockwise {
    
}

+(NSArray<NSArray<CellLocation *> *> *)getAllKicksBy:(CellType *)cellType; {

}

@end


