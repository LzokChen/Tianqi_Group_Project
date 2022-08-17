//
//  ViewController.m
//  Tetris
//
//  Created by Xiaojian Chen on 8/15/22.
//

#import "ViewController.h"
#import "../ViewModel/TetrisGameViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *UpButton;
@property (weak, nonatomic) IBOutlet UIImageView *LeftButton;
@property (weak, nonatomic) IBOutlet UIImageView *RightButton;
@property (weak, nonatomic) IBOutlet UIImageView *DownButton;
@property (weak, nonatomic) IBOutlet UIImageView *PauseButton;
//@property Boolean pause;
//@property NSMutableArray *gameboard;
@property (nonatomic, retain) TetrisGameViewModel *tetrisGameViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tetrisGameViewModel = [[TetrisGameViewModel alloc] initGameBoard:_myCollectionView];
    
    
//    self.gameboard = [NSMutableArray array];
//
//    for (int column = 0; column < 10; column++)
//    {
//        NSMutableArray *columnArray = [NSMutableArray array];
//
//        for (int row = 0; row < 15; row++)
//            [columnArray addObject:[[TetrisGameSquare alloc] initWithColor:UIColor.blackColor]];
//
//        [self.gameboard addObject:columnArray];
//    }
    
    
    _myCollectionView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *uptap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UpTapped:)];
    UITapGestureRecognizer *downtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DownTapped:)];
    UITapGestureRecognizer *lefttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LeftTapped:)];
    UITapGestureRecognizer *righttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RightTapped:)];
    UITapGestureRecognizer *playtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PlayTapped:)];

    _UpButton.userInteractionEnabled = YES;
    _DownButton.userInteractionEnabled = YES;
    _LeftButton.userInteractionEnabled = YES;
    _RightButton.userInteractionEnabled = YES;
    _PauseButton.userInteractionEnabled = YES;

    [_UpButton addGestureRecognizer:uptap];
    [_DownButton addGestureRecognizer:downtap];
    [_LeftButton addGestureRecognizer:lefttap];
    [_RightButton addGestureRecognizer:righttap];
    [_PauseButton addGestureRecognizer:playtap];
}

- (void)UpTapped:(UIGestureRecognizer*)gesture{
    NSLog(@"UP Clicked!");
//    TetrisGameSquare *square = [[_gameboard objectAtIndex:9] objectAtIndex:14];
//    square.color = UIColor.redColor;
//    [_myCollectionView reloadData];
}
- (void)DownTapped:(UIGestureRecognizer*)gesture{
    NSLog(@"DOWN Clicked!");
}
- (void)LeftTapped:(UIGestureRecognizer*)gesture{
    NSLog(@"LEFT Clicked!");
}
- (void)RightTapped:(UIGestureRecognizer*)gesture{
    NSLog(@"RIGHT Clicked!");
}
- (void)PlayTapped:(UIGestureRecognizer*)gesture{
//    NSLog(@"!PAUSE!");
    if(self.PauseButton.image == [UIImage systemImageNamed:@"pause"]){
        NSLog(@"!PAUSE!");
        self.PauseButton.image = [UIImage systemImageNamed:@"play"];
    }else{
        NSLog(@"!PLAY!");
        self.PauseButton.image = [UIImage systemImageNamed:@"pause"];
    }
    
}
// CollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 150;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    int x = (int)indexPath.row%10;
    int y = -((int)indexPath.row/10)+14;
    TetrisGameSquare *square = [[self.tetrisGameViewModel.gameBoard objectAtIndex:x] objectAtIndex:y];
    cell.backgroundColor = square.color;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/10*0.9, (CGRectGetWidth(collectionView.frame)/10*0.9));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if(cell != nil){
        int x = (int)indexPath.row%10;
        int y = -((int)indexPath.row/10)+14;
        [self.tetrisGameViewModel squareClicker:y coloumn:x];
        NSLog(@"(%d, %d)", x,y);
    }
}
@end

