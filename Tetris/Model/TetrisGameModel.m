//
//  TetrisGameModel.m
//  Tetris
//
//  Created by 刘峥炫 on 2022/8/18.
//

#import "TetrisGameModel.h"

@implementation TetrisGameModel

- (id)initGameModel {
    self.numRows = 15;
    self.numColumns = 10;
    
    self.gameBoard = [NSMutableArray array];
    for (int col = 0; col < self.numColumns; col++){
        NSMutableArray *colArray = [NSMutableArray array];
        for (int row = 0; row < self.numRows; row++)
            [colArray addObject:[NSNull null]];
    }
    
//    self.tetrominoModel = [[TetrominoModel alloc] initWithOrigin:[[CellLocation alloc] initWithRow:22 andCol:4] andType:i andRotation:1];
    
    return self;
}

@end

@implementation TetrisGameCell

- (id)initWithType:(CellType)cellType{
    self = [super init];
    self.cellType = cellType;
    return self;
}

@end
