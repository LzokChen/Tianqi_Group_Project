//
//  BlockStructures.h
//  Tianqi_Group_Project
//
//  Created by Mingyu Liu on 2022-08-16.
//

#ifndef BlockStructures_h
#define BlockStructures_h

@interface GameBoardSquare : NSObject

@property (nonatomic, copy) NSString * color;

@end

@interface BlockLocation : NSObject

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;

- (id)initWithRow:(int)row andCol:(int)column;

@end


typedef enum {
    i, t, o, j, l, s, z
} BlockType;

@interface TetrisGameBlock : NSObject

@property BlockType blockType;

- (id)initWithType:(BlockType)blockType;

@end
#endif /* BlockStructures_h */
