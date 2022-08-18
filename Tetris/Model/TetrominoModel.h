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

@property (nonatomic) BlcokLocation *origin;
@property (nonatomic, assign) BlockType blockType;
@property (nonatomic, assign) int rotation;

-(id)initWithOrigin:(BlcokLocation *)origin withType:(BlockType)type withRotation:(int)rotation; // Object constructor
-(NSArray<BlcokLocation *> *)blocks; // Return an array of all cells of the current Tetromino
-(TetrominoModel *)moveBy:(int)row andBy:(int)col; // Move current Tetromino by specified number of [row]s and [col]s
-(TetrominoModel *)rotateBy:(Boolean)isClockwise; // Rotate current Tetromino based on [isClockwise]
-(NSArray<BlcokLocation *> *)getKicksBy:(Boolean)isClockwise; // Return an array of cells where the current Tetromino will kick the wall

+(NSArray<BlcokLocation *> *)getBlocksBy:(BlockType)blockType andBy:(int)rotation; // Return an array of cells of any Tetromino based on its [blockType] and [rotation]
+(NSArray<NSArray<BlcokLocation *> *> *)getAllBlocksBy:(BlockType)blockType; // Return a 4*4 array of all possible combinations of cells of any Tetromino based on [blockType]
+(TetrominoModel *)createNewTetrominoBy:(int)numRows andBy:(int)numCols; // Create and return a new Tetromino located based on specified [numRows] and [numCols]
+(NSArray<BlcokLocation *> *)getKicksBy:(BlockType)blockType andBy:(int)rotation lastlyBy:(Boolean)isClockwise; // Return an array of cells where a Tetromino of [blockType], [rotation] and [isClockwise]
+(NSArray<NSArray<BlcokLocation *> *> *)getAllKicksBy:(BlockType)blockType; // Returns a 2D array of all possible kicks of any Tetromino based on its [blockType]

@end

#endif /* TetrominoModel_h */
