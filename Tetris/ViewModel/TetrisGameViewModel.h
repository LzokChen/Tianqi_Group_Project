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
@property NSMutableArray* gameBoard;
@property TetrisGameModel* tetrisGameModel;

@property UICollectionView *collectionView;
@property UILabel *scoreText;

- (id)initGameBoard:(UICollectionView *)collectionView ScoreText:(UILabel *)scoreText;

- (void)UpdateGameBoard;

//- (TetrisGameSquare *)convertToSquare:(TetrisGameBlock *)block;

- (UIColor *)getColor:(BlockType)blockType;

- (void)RightButtonClick;

- (void)LeftButtonClick;

- (void)DownButtonClick;

- (void)UpButtonClick;

- (void)ClockwiseButtonClick;

- (void)AntiClockwiseButtonClick;

- (void)squareClicker:(int)row coloumn:(int)col;

@end

@interface TetrisGameSquare : NSObject

@property UIColor *color;

- (id)initWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
