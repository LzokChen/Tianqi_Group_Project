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
    self.score = 0;
    self.speed = 1.0;
    self.gameIsPause = true;
    
    self.gameBoard = [NSMutableArray array];
    for (int col = 0; col < self.numColumns; col++){
        NSMutableArray *colArray = [NSMutableArray array];
        for (int row = 0; row < self.numRows; row++)
            [colArray addObject:[NSNull null]];
        [self.gameBoard addObject:colArray];
    }
    
    [self resumeGame];
    return self;
}

- (void)newGame{
    self.score = 0;
    self.tetromino = nil;
    self.timer = nil;
    
    self.gameBoard = [NSMutableArray array];
    for (int col = 0; col < self.numColumns; col++){
        NSMutableArray *colArray = [NSMutableArray array];
        for (int row = 0; row < self.numRows; row++)
            [colArray addObject:[NSNull null]];
        [self.gameBoard addObject:colArray];
    }
    
    [self resumeGame];
}

- (void)resumeGame{
    NSLog(@"Resuming Game");
    self.gameIsPause = false;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.speed repeats:true block:^(NSTimer * _Nonnull timer) {
        [self runEngine];
    }];
}

- (void) pauseGame{
    NSLog(@"Pausing Game");
    self.gameIsPause = true;
    [self.timer invalidate];
}

- (void)runEngine{
    //check if we need to clear the line
    int numOfLineClear = [self clearLines];
    if (numOfLineClear > 0){
        self.score += pow(2, numOfLineClear) * 100;
        return;
    }
    
    //spawn a new block if we need to
    if (self.tetromino == nil){
        
        self.tetromino = [TetrominoModel createNewTetrominoBy:self.numRows andBy:self.numColumns];
        
        NSLog(@"Spawning new Tetromino %@, origin: (%d, %d)", [TetrominoModel getBlockTypeBy:self.tetromino.blockType], self.tetromino.origin.row, self.tetromino.origin.column);
        if (![self isValidTetromino:self.tetromino]){
            NSLog(@"Game Over! Final score: %d", self.score);
            [self pauseGame];
        }
        return;
    }
    
    //see about moving down
    if ([self moveTetrominoDown]){
        NSLog(@"Moving Tetromino down, origin: (%d, %d)", self.tetromino.origin.row, self.tetromino.origin.column);
        return;
    }
    
    //see if we need to place the Tetromino
    NSLog(@"Placing Tetromino");
    [self placeTetromino];
}

- (void)dropTetromino{
    while([self moveTetrominoDown]){}
}

- (Boolean)moveTetrominoRight{
    return [self moveTetrominoWithRowOffset:0 andColumnOffset:1];
}

- (Boolean)moveTetrominoLeft{
    return [self moveTetrominoWithRowOffset:0 andColumnOffset:-1];
}

- (Boolean)moveTetrominoDown{
    return [self moveTetrominoWithRowOffset:-1 andColumnOffset:0];
}

- (Boolean)moveTetrominoWithRowOffset:(int)rowOffset andColumnOffset:(int)colOffset{
    TetrominoModel * curTetromino = self.tetromino;
    if (curTetromino == nil){
        return false;
    }
    
    TetrominoModel * newTetromino = [curTetromino moveByRow:rowOffset andByColumn:colOffset];
    if ([self isValidTetromino:newTetromino]){
        self.tetromino = newTetromino;
        return true;
    }
    
    return false;
}

- (void)rotateTetrominoWithClockwise:(Boolean)clockwise{
    TetrominoModel * curTetromino = self.tetromino;
    if (curTetromino == nil){
        return;
    }
    
    TetrominoModel * newTetrominoBase = [curTetromino rotateByClockwise:clockwise];
    NSArray * kicks = [newTetrominoBase getKicksByClockwise:clockwise];
    
    for (BlockLocation* kick in kicks){
        TetrominoModel * newTetromino = [newTetrominoBase moveByRow:kick.row andByColumn:kick.column];
        if ([self isValidTetromino:newTetromino]){
            self.tetromino = newTetromino;
            return;
        }
    }
}

- (Boolean)isValidTetromino:(TetrominoModel *)tetromino{
    for (BlockLocation * block in [tetromino blocks]){
        int row = tetromino.origin.row + block.row;
        if (row < 0 || row >= self.numRows){return false;}
        
        int column = tetromino.origin.column + block.column;
        if (column < 0 || column >= self.numColumns){return false;}
        
        if (self.gameBoard[column][row] != [NSNull null]){return false;}
    }
    return true;
}

- (void)placeTetromino{
    TetrominoModel * curTetromino = self.tetromino;
    if (curTetromino == nil){
        return;
    }
    
    for(BlockLocation* block in [curTetromino blocks]){
        int row = curTetromino.origin.row + block.row;
        if (row < 0 || row >= self.numRows){continue;;}
        
        int column = curTetromino.origin.column + block.column;
        if (column < 0 || column >= self.numColumns){continue;;}
        
        self.gameBoard[column][row] = [[TetrisGameBlock alloc] initWithType:curTetromino.blockType];
    }
    
    self.tetromino = nil;
}

- (int)clearLines{
    //Todo
    int lines = 0;
    
    return lines;
}
@end


