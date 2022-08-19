//
//  TetrisGameViewModel.m
//  Tetris
//
//  Created by 刘峥炫 on 2022/8/18.
//

#import "TetrisGameViewModel.h"

@interface TetrisGameViewModel ()

- (TetrisGameSquare *)convertToSquare:(TetrisGameBlock *)block;

@end

@implementation TetrisGameViewModel

- (id)initGameViewModelwithGameBoardView:(UIView *)gameBoardView ScoreText:(UILabel *)scoreText PauseButton:(UIImageView *)pauseButton {
    self = [super init];
    self.tetrisGameModel = [[TetrisGameModel alloc] initGameModel];
    
    //用来更新UI
    self.gameBoardView = gameBoardView;
    self.scoreText = scoreText;
    self.pauseButton = pauseButton;
    
    
    // 行列
    self.numRows = self.tetrisGameModel.numRows;
    self.numColumns = self.tetrisGameModel.numColumns;
    // 初始化游戏盘 - 全黑色正方块
    self.gameBoardSquares = [NSMutableArray array];
    
    for (int col = 0; col < self.numColumns; col++){
        NSMutableArray *colArray = [NSMutableArray array];
        for (int row = 0; row < self.numRows; row++)
            [colArray addObject:[[TetrisGameSquare alloc] initWithColor:[UIColor colorNamed:@"BoardDotColor"]]];
        [self.gameBoardSquares addObject: colArray];
    }
    
    //测试用 在 （1.1 画红方块）
    self.gameBoardSquares[1][1] = [[TetrisGameSquare alloc] initWithColor:UIColor.redColor];
    
    
    [self.tetrisGameModel addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:NULL];
    [self.tetrisGameModel addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:NULL];
    
    //绘制游戏盘
    [self drawBoardwithGameBoardSquares:self.gameBoardSquares];

    // TODO: Combine - AnyCancellable
    
    return self;
}


- (void) drawBoardwithGameBoardSquares: (NSMutableArray<NSMutableArray<TetrisGameSquare *>* >*) gameBoardSquares{
    dispatch_queue_t  mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        int columns = self.numColumns;
        int rows = self.numRows;
        CGFloat gameBoardWidth = self.gameBoardView.frame.size.width;
        CGFloat gameBoardHight = self.gameBoardView.frame.size.height;
        
        CGFloat blocksize = MIN(gameBoardWidth/columns, gameBoardHight/rows);
        CGFloat xOffset = (gameBoardWidth - blocksize*columns)/2;
        CGFloat yOfsset = (gameBoardHight - blocksize*rows)/2;
        
        for (int col = 0 ; col < columns ; col++){
            for (int row = 0; row < rows; row++){
                CGFloat x = xOffset + blocksize * col;
                CGFloat y = gameBoardHight - yOfsset - blocksize * (row+1);
                
                UIView * square = [[UIView alloc] initWithFrame:CGRectMake(x, y, blocksize, blocksize)];
                square.backgroundColor = gameBoardSquares[col][row].color;
                
                [self.gameBoardView addSubview:square];
            }
        }
    });
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        [self UpdateGameBoard];
        //[self.collectionView reloadData];
    } else if ([keyPath isEqualToString:@"score"]) {
        self.scoreText.text = [NSString stringWithFormat:@"%d", self.tetrisGameModel.score];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)UpdateGameBoard{
    //TODO - 把 TetrisGameModel.gameboard + TetrisGameModel.tetromino 转换成 self.gameBoardSquares
    // 然后 [drawBoardwithGameBoardSquares: self.gameBoardSquares]
    
}

//// 将blcok转化为GameBoard方块(有颜色)
- (TetrisGameSquare *)convertToSquare:(TetrisGameBlock *)block{
    // 判断blcok是否是TetrisGameBlock的实例化对象, block可能为空
    if([block isKindOfClass:[TetrisGameBlock class]]){
        return [[TetrisGameSquare alloc] initWithColor:[self getColor:block.blockType]];
    }else{
        return [[TetrisGameSquare alloc] initWithColor:UIColor.blackColor];
    }
}

// 获取俄罗斯方块的颜色
- (UIColor *)getColor:(BlockType)blockType{
    UIColor *color = nil;
    switch(blockType){
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

- (void)RightButtonClick{
    [self.tetrisGameModel moveTetrominoRight];
}

- (void)LeftButtonClick{
    [self.tetrisGameModel moveTetrominoLeft];
}

- (void)DownButtonClick{
    [self.tetrisGameModel moveTetrominoDown];
}

- (void)UpButtonClick{
    [self.tetrisGameModel dropTetromino];
}

- (void)ClockwiseButtonClick{
    [self.tetrisGameModel rotateTetrominoWithClockwise:true];
}

- (void)AntiClockwiseButtonClick{
    [self.tetrisGameModel rotateTetrominoWithClockwise:false];
}

//// 测试 - 点击方块改变颜色
//- (void)squareClicker:(int)row coloumn:(int)col{
//    TetrisGameSquare *square = self.gameBoard[col][row];
//    if(square.color == UIColor.blackColor){
//        square.color = UIColor.redColor;
//    }else{
//        square.color = UIColor.blackColor;
//    }
//    //[self.collectionView reloadData];
//}

@end
