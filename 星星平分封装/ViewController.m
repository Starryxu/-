

#import "ViewController.h"
#import "YGStarScoreView.h"
@interface ViewController ()<starScoreViewDelegate>
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UILabel *lable_2;
@property (nonatomic, strong) UILabel *lable_3;

@property (nonatomic, strong) UILabel *descLable;
@property (nonatomic, strong) UILabel *descLable_2;
@property (nonatomic, strong) UILabel *descLable_3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YGStarScoreView * rView = [[YGStarScoreView alloc]initWithFrame:CGRectMake(20, 100, 280, 60)];
    rView.ratingType = INTEGER_TYPE;
    rView.delegate = self;
    [self.view addSubview:rView];
    self.lable = [[UILabel alloc] initWithFrame:CGRectMake(320, 100, 280, 60)];
    self.lable.text = @"0.00";
    self.lable.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:self.lable];
    self.descLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 30)];
    self.descLable.text = @"整数类型";
    self.descLable.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:self.descLable];
    
    
    YGStarScoreView * rView_2 = [[YGStarScoreView alloc]initWithFrame:CGRectMake(20, 200, 280, 60)];
    rView_2.ratingType = INTEGER_HALF_TYPE;
    rView_2.delegate = self;
    [self.view addSubview:rView_2];
    self.lable_2 = [[UILabel alloc] initWithFrame:CGRectMake(320, 200, 280, 60)];
    self.lable_2.text = @"0.00";
    self.lable_2.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:self.lable_2];
    self.descLable_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 280, 30)];
    self.descLable_2.text = @"半整数类型";
    self.descLable_2.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:self.descLable_2];
    
    YGStarScoreView * rView_3 = [[YGStarScoreView alloc]initWithFrame:CGRectMake(20, 300, 280, 60)];
    rView_3.ratingType = FLOAT_TYPE;
    rView_3.delegate = self;
    [self.view addSubview:rView_3];
    self.lable_3 = [[UILabel alloc] initWithFrame:CGRectMake(320, 300, 280, 60)];
    self.lable_3.text = @"0.00";
    self.lable_3.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:self.lable_3];
    self.descLable_3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 280, 30)];
    self.descLable_3.text = @"浮点型";
    self.descLable_3.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:self.descLable_3];
}

#pragma mark - ratingViewDelegate
- (void)ratingView:(YGStarScoreView *)view score:(CGFloat)score
{
    NSLog(@"分数  %.2f",score);
    if (view.ratingType == INTEGER_TYPE) {
        self.lable.text = [NSString stringWithFormat:@"%.2f",score];
    } else if(view.ratingType == INTEGER_HALF_TYPE){
        self.lable_2.text = [NSString stringWithFormat:@"%.2f",score];
    } else if (view.ratingType == FLOAT_TYPE){
        self.lable_3.text = [NSString stringWithFormat:@"%.2f",score];
    }
    
}
@end
