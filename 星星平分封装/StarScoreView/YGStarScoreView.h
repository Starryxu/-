
#import <UIKit/UIKit.h>


@class YGStarScoreView;
// 协议
@protocol starScoreViewDelegate <NSObject>
@optional
// 回传评分view和score
- (void)ratingView:(YGStarScoreView *)view score:(CGFloat)score;
@end

// 评分类型枚举
typedef NS_ENUM(NSUInteger, RatingType) {
    INTEGER_TYPE,   //整型
    INTEGER_HALF_TYPE,   //半整型
    FLOAT_TYPE      //浮点型
};

@interface YGStarScoreView : UIView

@property (nonatomic, assign) RatingType ratingType;                //评分类型，整形或者浮点型
@property (nonatomic, assign) CGFloat score;                        //当前分数
@property (nonatomic, assign) id<starScoreViewDelegate> delegate;   //代理属性

@end
