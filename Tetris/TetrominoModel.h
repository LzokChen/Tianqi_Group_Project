//
//  TetrominoModel.h
//  Tianqi_Group_Project
//
//  Created by Mingyu Liu on 2022-08-16.
//

#ifndef TetrominoModel_h
#define TetrominoModel_h

#import "CellStructures.h"

@interface TetrominoModel: NSObject

@property (nonatomic, assign) CellLocation *origin;
@property (nonatomic, assign) CellType *type;
@property (nonatomic, assign) int rotation;

-(id)initWithOrigin:(CellLocation *)origin andType:(CellType *)type; //       ??????
-(NSArray<CellLocation *> *)cells; // Return an array of all cells of the current Tetromino
-(TetrominoModel *)moveBy:(int)row andBy:(int)col; // Move current Tetromino by specified number of [row]s and [col]s
-(TetrominoModel *)rotateBy:(Boolean)isClockwise; // Rotate current Tetromino based on [isClockwise]
-(NSArray<CellLocation *> *)getKicksBy:(Boolean)isClockwise; // Return an array of cells where the current Tetromino will kick the wall

+(NSArray<CellLocation *> *)getCellsBy:(CellType *)cellType andBy:(int)rotation; // Return an array of cells of any Tetromino based on its [cellType] and [rotation]
+(NSArray<NSArray<CellLocation *> *> *)getAllCellsBy:(CellType *)cellType; // Return a 4*4 array of all possible combinations of cells of any Tetromino based on [cellType]
+(TetrominoModel *)createNewTetrominoBy:(int)numRows andBy:(int)numCols; // Create and return a new Tetromino located based on specified [numRows] and [numCols]
+(NSArray<CellLocation *> *)getKicksBy:(CellType *)cellType andBy:(int)rotation lastlyBy:(Boolean)isClockwise; // Return an array of cells where a Tetromino of [cellType], [rotation] and [isClockwise
+(NSArray<NSArray<CellLocation *> *> *)getAllKicksBy:(CellType *)cellType; // Returns a 2D array of all possible kicks of any Tetromino based on its [cellType]

@end

#endif /* TetrominoModel_h */
