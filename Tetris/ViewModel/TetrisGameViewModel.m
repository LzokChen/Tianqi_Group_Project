//
//  TetrisGameViewModel.m
//  Tetris
//
//  Created by 刘峥炫 on 2022/8/18.
//

#import "TetrisGameViewModel.h"

@interface TetrisGameViewModel ()

- (TetrisGameSquare *)convertToSquare:(TetrisGameCell *)cell;

@end

@implementation TetrisGameViewModel

- (id)initGameBoard:(UICollectionView *)collectionView;{
    self = [super init];
    self.tetrisGameModel = [[TetrisGameModel alloc] init];
    
    
    // 行列
    self.numRows = self.tetrisGameModel.numRows;
    self.numColumns = self.tetrisGameModel.numColumns;
    // 游戏盘
    self.gameBoard = [NSMutableArray array];
    
    // collectionView 用来更新画板, 暂时没想到好方法
    self.collectionView = collectionView;
    
    // TODO: 每当GameModel变化时要改变gameBoard
    for (int column = 0; column < 10; column++){
        NSMutableArray *columnArray = [NSMutableArray array];
        for (int row = 0; row < 15; row++)
            [columnArray addObject:[self convertToSquare:self.tetrisGameModel.gameBoard[column][row]]];
        [self.gameBoard addObject:columnArray];
    }
    // TODO: 每当GameModel变化时要改变gameBoard - TetrominoModel.tetromino
    //    TetrominoModel *tetromino = self.tetrisGameModel.tetromino;
    //    for (id cellLocation in tetromino.cells) {
    //        self.gameBoard[cellLocation.column + tetromino.origin.column][cellLocation.row + tetromino.origin.row] = [[TetrisGameSquare alloc] initWithColor:[self getColor:tetromino.cellType]];
    //    }
    
    // TODO: 每当GameModel变化时要改变gameBoard - TetrominoModel.shadow
    //    TetrominoModel *tetromino = self.tetrisGameModel.shadow;
    //    for (id cellLocation in tetromino.cells) {
    //        self.gameBoard[cellLocation.column + tetromino.origin.column][cellLocation.row + tetromino.origin.row] = [[TetrisGameSquare alloc] initWithColor:[self getColor:tetromino.cellType]];
    //    }
    

    // TODO: Combine - AnyCancellable
    
    return  self;
}

// 将Cell转化为GameBoard方块(有颜色)
- (TetrisGameSquare *)convertToSquare:(TetrisGameCell *)cell{
    // 判断cell是否是TetrisGameCell的实例化对象, cell可能为空
    if([cell isKindOfClass:[TetrisGameCell class]]){
        return [[TetrisGameSquare alloc] initWithColor:[self getColor:cell.cellType]];
    }else{
        return [[TetrisGameSquare alloc] initWithColor:UIColor.blackColor];
    }
}

// 获取俄罗斯方块的颜色
- (UIColor *)getColor:(CellType)cellType{
    UIColor *color = nil;
    switch(cellType){
        case i:
            color = [UIColor colorNamed:@"IColor"];
            break;
        case t:
            color = [UIColor colorNamed:@"TColor"];
            break;
        case o:
            color = [UIColor colorNamed:@"OColor"];
            break;
        case j:
            color = [UIColor colorNamed:@"JColor"];
            break;
        case l:
            color = [UIColor colorNamed:@"LColor"];
            break;
        case s:
            color = [UIColor colorNamed:@"SColor"];
            break;
        case z:
            color = [UIColor colorNamed:@"ZColor"];
            break;
    }
    return color;
}
// 测试 - 点击方块改变颜色
- (void)squareClicker:(int)row coloumn:(int)col{
    TetrisGameSquare *square = self.gameBoard[col][row];
    if(square.color == UIColor.blackColor){
        square.color = UIColor.redColor;
    }else{
        square.color = UIColor.blackColor;
    }
    [self.collectionView reloadData];
}

@end

@implementation TetrisGameSquare

- (id)initWithColor:(UIColor *)color{
    self = [super init];
    self.color = color;
    return self;
}

@end
