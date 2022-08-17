//
//  TetrisGameModel.h
//  Tetris
//
//  Created by 刘峥炫 on 2022/8/18.
//

#import <Foundation/Foundation.h>
#import "CellStructures.h"
#import "TetrominoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TetrisGameModel : NSObject

@property (nonatomic, assign) int numRows;
@property (nonatomic, assign) int numColumns;
@property (nonatomic, assign) NSArray* gameBoard;
@property (nonatomic, assign) TetrominoModel* tetromino;

- (id)initGameModel;
//- (void)resumeGame;
//- (void)pauseGame;
//- (void)runEngine;


@end

@interface TetrisGameCell : NSObject

@property CellType cellType;

- (id)initWithType:(CellType)cellType;

@end

NS_ASSUME_NONNULL_END
