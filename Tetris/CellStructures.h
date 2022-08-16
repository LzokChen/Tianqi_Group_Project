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

@end

@interface CellType : NSObject

@end

#endif /* CellStructures_h */
