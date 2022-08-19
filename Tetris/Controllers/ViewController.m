//
//  ViewController.m
//  Tetris
//
//  Created by Xiaojian Chen on 8/15/22.
//

#import "ViewController.h"
#import "ViewController.h"
#import "../ViewModel/TetrisGameViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameBoardView;
//@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *UpButton;
@property (weak, nonatomic) IBOutlet UIImageView *LeftButton;
@property (weak, nonatomic) IBOutlet UIImageView *RightButton;
@property (weak, nonatomic) IBOutlet UIImageView *DownButton;
@property (weak, nonatomic) IBOutlet UIImageView *PauseButton;
@property (weak, nonatomic) IBOutlet UILabel *ScoreText;

@property (nonatomic, retain) TetrisGameViewModel *tetrisGameViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tetrisGameViewModel = [[TetrisGameViewModel alloc] initGameViewModelwithGameBoardView:self.gameBoardView ScoreText:self.ScoreText PauseButton:self.PauseButton];
    
    //_myCollectionView.backgroundColor = [UIColor blackColor];
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

// 方向上 - 顺时针旋转
- (void)UpTapped:(UIGestureRecognizer*)gesture{
    NSLog(@"UP Clicked - Rotation!");
    [self.tetrisGameViewModel.tetrisGameModel rotateTetrominoWithClockwise:true];
}
// 方向下 - 向下移动
- (void)DownTapped:(UIGestureRecognizer*)gesture{
    [self.tetrisGameViewModel.tetrisGameModel moveTetrominoDown];
}
// 方向左 - 向左移动
- (void)LeftTapped:(UIGestureRecognizer*)gesture{
    [self.tetrisGameViewModel.tetrisGameModel moveTetrominoLeft];
}
// 方向右 - 向右移动
- (void)RightTapped:(UIGestureRecognizer*)gesture{
    [self.tetrisGameViewModel.tetrisGameModel moveTetrominoRight];
}
// 暂停/继续 按钮 - 游戏停止
- (void)PlayTapped:(UIGestureRecognizer*)gesture{
    if(self.PauseButton.image == [UIImage systemImageNamed:@"pause"]){
        [self.tetrisGameViewModel.tetrisGameModel pauseGame];
        NSLog(@"!PAUSE!");
        self.PauseButton.image = [UIImage systemImageNamed:@"play"];
    }else{
        [self.tetrisGameViewModel.tetrisGameModel resumeGame];
        NSLog(@"!PLAY!");
        self.PauseButton.image = [UIImage systemImageNamed:@"pause"];
    }
    
}
@end

