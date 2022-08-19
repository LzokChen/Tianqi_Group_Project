//
//  TetrisGameViewModel.h
//  Tetris
//
//  Created by 刘峥炫 on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../Model/TetrisGameModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TetrisGameViewModel : NSObject

@property int numRows;
@property int numColumns;
@property NSMutableArray<NSMutableArray<TetrisGameSquare *>* >* gameBoardSquares;
@property TetrisGameModel* tetrisGameModel;

@property UIView *gameBoardView;
@property UILabel *scoreText;
@property UIImageView *pauseButton;

- (id)initGameViewModelwithGameBoardView:(UIView *)gameBoardView ScoreText:(UILabel *)scoreText PauseButton:(UIImageView *)pauseButton;

- (void) drawBoardwithGameBoardSquares: (NSMutableArray<NSMutableArray<TetrisGameSquare *>* >*) gameBoardSquares; //二维数组

- (void)UpdateGameBoard;

//- (TetrisGameSquare *)convertToSquare:(TetrisGameBlock *)block;

- (UIColor *)getColor:(BlockType)blockType;

- (void)RightButtonClick;

- (void)LeftButtonClick;

- (void)DownButtonClick;

- (void)UpButtonClick;

- (void)ClockwiseButtonClick;

- (void)AntiClockwiseButtonClick;

//- (void)squareClicker:(int)row coloumn:(int)col;



@end


NS_ASSUME_NONNULL_END
