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
@property (weak, nonatomic) IBOutlet UIImageView *UpButton;
@property (weak, nonatomic) IBOutlet UIImageView *LeftButton;
@property (weak, nonatomic) IBOutlet UIImageView *RightButton;
@property (weak, nonatomic) IBOutlet UIImageView *DownButton;
@property (weak, nonatomic) IBOutlet UIImageView *PauseButton;
@property (weak, nonatomic) IBOutlet UILabel *ScoreText;
@property AVAudioPlayer * tetrisAudioPlayer;

@property (nonatomic, retain) TetrisGameViewModel *tetrisGameViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tetrisGameViewModel = [[TetrisGameViewModel alloc] initGameViewModelwithGameBoardView:self.gameBoardView ScoreText:self.ScoreText PauseButton:self.PauseButton];
    
    [self.tetrisGameViewModel.tetrisGameModel addObserver:self forKeyPath:@"gameState" options:NSKeyValueObservingOptionNew context:NULL];
    
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
    
    
    //创建并注册AudioPlayer
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tetris" ofType:@"mp3"];
    NSURL *url = [NSURL URLWithString:path];
    self.tetrisAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    self.tetrisAudioPlayer.numberOfLoops = -1; //无限循环
    
    [self.tetrisAudioPlayer play]; //app启动时播放音乐
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"gameState"]) {
        switch(self.tetrisGameViewModel.tetrisGameModel.gameState){
            case Over:
            case Pause:
                [self.tetrisAudioPlayer pause]; //游戏暂停时暂停音乐
                self.PauseButton.image = [UIImage systemImageNamed:@"play"];
                break;
            case Running:
                [self.tetrisAudioPlayer play]; //游戏运行时播放音乐
                self.PauseButton.image = [UIImage systemImageNamed:@"pause"];
                break;
                
        }
    }
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
    [self.tetrisGameViewModel PlayAndPauseButtonClick];
}

@end

