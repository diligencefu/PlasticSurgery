
#import "UIColor+seting.h"
#import "UIImageView+WebCache.h"
#import "ADView.h"
@interface ADView()<UIScrollViewDelegate>
{
    NSInteger _currentPage; //记录真实的页码数
    NSTimer *_timer;  //生命一个全局变量
    BOOL _isNetPicture;
}
@property (nonatomic,assign) BOOL isRun;

@property (nonatomic,strong) NSMutableArray *imageArray;//存储图片的名字
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) CGFloat width;//view的宽
@property (nonatomic,assign) CGFloat height;//view的高

@end

@implementation ADView

-(id)initWithFrame:(CGRect)frame andImageNameArray:(NSMutableArray *)imageNameArray andIsRunning:(BOOL)isRunning{
    
    self = [super initWithFrame:frame];
    if (self) {
        _width = self.frame.size.width;
        _height = self.frame.size.height;
        
        //arrayWithArray 把数组中的内容放到一个数组中返回
        self.imageArray = [NSMutableArray arrayWithArray:imageNameArray];
        //在数组的尾部添加原数组第一个元素
        [self.imageArray addObject:[imageNameArray firstObject]];

        //在数组的首部添加原数组最后一个元素
        [self.imageArray insertObject:[imageNameArray lastObject] atIndex:0];

        self.isRun = isRunning;
        _currentPage = 0;

        [self createSro];
        [self createPageControl];
        [self createTimer];

    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andImageURLArray:(NSMutableArray *)imageNameArray andIsRunning:(BOOL)isRunning{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _isNetPicture = YES;
        
        _width = self.frame.size.width;
        _height = self.frame.size.height;
        
        //arrayWithArray 把数组中的内容放到一个数组中返回
        self.imageArray = [NSMutableArray arrayWithArray:imageNameArray];
        //在数组的尾部添加原数组第一个元素
        [self.imageArray addObject:[imageNameArray firstObject]];
        
        //在数组的首部添加原数组最后一个元素
        [self.imageArray insertObject:[imageNameArray lastObject] atIndex:0];
        
        self.isRun = isRunning;
        _currentPage = 0;
        
        [self createSro];
        [self createPageControl];
        [self createTimer];
        
    }
    return self;
}

-(void)createTimer{
    if (_isRun == YES) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change) userInfo:nil repeats:YES ];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
  
}

-(void)change{
    //1获得当前的点
    CGPoint point = _scrollView.contentOffset;
    //2求得将要变换的点
    CGPoint endPoint = CGPointMake(point.x+_width, 0);
    
    //判断
    if (endPoint.x == (self.imageArray.count-1)*_width) {
        [UIView animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(endPoint.x, 0);

        } completion:^(BOOL finished) {
            //动画完成的block
            _scrollView.contentOffset = CGPointMake(_width, 0);
            CGPoint realEnd = _scrollView.contentOffset;
            //取一遍页码数
            _currentPage = realEnd.x/_width;
            _pageControl.currentPage = _currentPage-1;
        }];
    }
    else{
        //0.25s中更改一个图片
        [UIView animateWithDuration:0.25 animations:^{
            
            _scrollView.contentOffset = endPoint;
        } completion:^(BOOL finished) {
            
        }];
        
        CGPoint realEnd = _scrollView.contentOffset;
        //取一遍页码数
        _currentPage = realEnd.x/_width;
        _pageControl.currentPage = _currentPage-1;
    }
   
   
}
//创建页码指示器
-(void)createPageControl{
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((_width-100)/2, _height-30, 100, 30)];
    _pageControl.numberOfPages = self.imageArray.count-2;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithSetingNotAlpha:0XFFFFFF];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithSetingNotAlpha:0XFF8A92];
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
   
}
//创建滚动视图
-(void)createSro{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    _scrollView.contentSize = CGSizeMake(_width*self.imageArray.count, _height);
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_width, 0, _width, _height)];
        if (_isNetPicture) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[i]]];
            
        }else{
            imageView.image = [UIImage imageNamed:self.imageArray[i]];
        }
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;
        imageView.tag = i+10086;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taps:)];
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
    }
    //水平指示条不显示
    _scrollView.showsHorizontalScrollIndicator = NO;
    //关闭弹簧效果
    _scrollView.bounces = NO;
    //设置用户看到第一张
    _scrollView.contentOffset = CGPointMake(_width, 0);
    //设置代理
    _scrollView.delegate = self;
    //分页效果
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
}

- (void)taps:(UITapGestureRecognizer *)tap{
    
    if (_block != nil) {
        _block([NSString stringWithFormat: @"%ld",tap.view.tag-10086]);
    }
}

#pragma mark UIScrollViewDelegate
//停止滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (_timer) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }

    CGPoint point = _scrollView.contentOffset;
    
    if (point.x == (self.imageArray.count-1)*_width) {
        scrollView.contentOffset = CGPointMake(_width, 0);
    }
    if (point.x == 0) {
        scrollView.contentOffset = CGPointMake((self.imageArray.count-2)*_width, 0);
    }
    
    //取一遍页码数
    CGPoint endPoint = scrollView.contentOffset;
    _currentPage = endPoint.x/_width;
    _pageControl.currentPage = _currentPage-1;
}
//手指开始触摸的时候，停止计时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_timer) {
        //如果有，停掉
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

@end
