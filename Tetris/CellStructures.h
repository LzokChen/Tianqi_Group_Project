//
//  CellStructures.h
//  Tianqi_Group_Project
//
//  Created by Mingyu Liu on 2022-08-16.
//

#ifndef CellStructures_h
#define CellStructures_h

@interface GameboardCell : NSObject

@property (nonatomic, copy) NSString * color;

@end

@interface CellLocation : NSObject

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;

- (id)initWithRow:(int)row andCol:(int)column;

@end

typedef enum {
    i = 0, t, o, j, l, s, z
} CellType;

#endif /* CellStructures_h */