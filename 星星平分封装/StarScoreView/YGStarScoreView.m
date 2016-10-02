

#import "YGStarScoreView.h"


#define maxScore 5.0f       //最高评分
#define starNumber 5.0f     //星星数量

@interface YGStarScoreView ()

@property (nonatomic, assign) CGFloat eachStar_W;    //星星宽度
@property (nonatomic, assign) CGFloat eachStar_H;    //星星高度
@property (nonatomic, assign) CGFloat lowestScore;   //最低分数
@property (nonatomic, strong) UIView *backStarView;  //背景
@property (nonatomic, strong) UIView *foreStarView;  //前景

@end
@implementation YGStarScoreView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ratingType = FLOAT_TYPE;
        self.lowestScore = 0.0f;
        
        self.backStarView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.backStarView];
        self.foreStarView = [[UIView alloc]initWithFrame:self.bounds];
        self.foreStarView.clipsToBounds = YES;
        [self addSubview:self.foreStarView];
        
        self.eachStar_W = (CGRectGetWidth(self.frame)) / starNumber;
        self.eachStar_H = self.eachStar_W;
        
        
        for (int i = 0; i < starNumber; i++) {
            
            CGFloat x = self.eachStar_W * i;
            CGFloat y = (CGRectGetHeight(self.frame) - self.eachStar_W) * 0.5;
            CGFloat w = self.eachStar_W;
            CGFloat h = self.eachStar_H;
            
            UIImage * backImg = [UIImage imageNamed:@"star_empty"];
            UIImageView * backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
            backImgView.image = backImg;
            [self.backStarView addSubview:backImgView];
            
            
            UIImage * foreImg = [UIImage imageNamed:@"star_full"];
            UIImageView * foreImgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
            foreImgView.image = foreImg;
            [self.foreStarView addSubview:foreImgView];
        }
        
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureEvent:)];
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureEvent:)];
        
        [self addGestureRecognizer:tapGesture];
        [self addGestureRecognizer:panGesture];
        
        
        self.score = self.lowestScore;
    }
    return self;
}



- (void)setScore:(CGFloat)score
{
    _score = score;
    
    if (_ratingType == INTEGER_TYPE) {
        _score = (int)ceil(score);
    } else if (_ratingType == INTEGER_HALF_TYPE) {
        CGFloat temp = ceilf(score) - score;
        if (temp == 0.5) {
            _score = score;
        }
        if (temp < 0.5) {
            _score = ceilf(score);
        }
        if (temp > 0.5) {
            _score = floorf(score) + 0.5;
        }
    }
    CGPoint p = CGPointMake(self.eachStar_W * _score, 0);
    [self changeStarForeViewWithPoint:p];
}


- (void)setRatingType:(RatingType)ratingType
{
    _ratingType = ratingType;
    
    [self setScore:_score];
}


- (void)tapGestureEvent:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
   
    
    if(_ratingType == INTEGER_TYPE) {
        NSInteger count = (NSInteger)(point.x / self.eachStar_W) + 1;
        point.x = count * self.eachStar_W;
    } else if (_ratingType == INTEGER_HALF_TYPE) {
        NSInteger count = (NSInteger)(point.x / (self.eachStar_W / 2)) + 1;
        point.x = count * (self.eachStar_W / 2);
    }
    
    [self changeStarForeViewWithPoint:point];
}



- (void)panGestureEvent:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self];
    
    if (point.x <= 0.0) {
        point.x = 0.0;
    } else {
        if(_ratingType == INTEGER_TYPE){
            NSInteger count = (NSInteger)(point.x / self.eachStar_W) + 1;
            point.x = count * self.eachStar_W;
        }
        
        if (_ratingType == INTEGER_HALF_TYPE) {
            NSInteger count = (NSInteger)(point.x / (self.eachStar_W / 2)) + 1;
            point.x = count * (self.eachStar_W / 2);
        }
    }
    [self changeStarForeViewWithPoint:point];
}


- (void)changeStarForeViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    if (p.x < 0.0) {
        return;
    } else if (p.x > self.frame.size.width) {
        p.x = self.frame.size.width;
    }
    
    CGFloat scale = p.x / CGRectGetWidth(self.frame);
    CGRect fRect = self.foreStarView.frame;
    fRect.size.width = p.x;
    self.foreStarView.frame = fRect;
    
    _score = scale * maxScore;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(ratingView:score:)]) {
        [self.delegate ratingView:self score:self.score];
    }
}

@end
