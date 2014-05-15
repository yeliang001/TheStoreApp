//
//  OTSPageView.m
//  TheStoreApp
//
//  Created by jiming huang on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define STATUS_BAR_HEIGHT   8

#define TAG_SCROLLVIEW_SUBVIEW  1
#define TAG_STATUS_BAR  2

#import "YWHomeHotPageView.h"

@interface YWHomeHotPageView ()
@property(nonatomic, retain)OTSScrollView *scrollView;
@end

@implementation YWHomeHotPageView
@synthesize scrollView = _scrollView;

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate showStatusBar:(BOOL)showStatusBar sleepTime:(NSInteger)sleepTime
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        [self setUserInteractionEnabled:YES];
        m_Delegate=delegate;
        m_SleepTime=sleepTime;
        //scroll view
        _scrollView = [[OTSScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setScrollsToTop:NO];
        [self.scrollView setDelegate:self];
        [self addSubview:self.scrollView];
        //status bar
        if (showStatusBar) {
            m_StatusBar=[[OTSDefaultStatusBar alloc] initWithFrame:CGRectMake(frame.size.width/2-(frame.size.width/3)/2, frame.size.height-(STATUS_BAR_HEIGHT+40), frame.size.width/3, STATUS_BAR_HEIGHT)];
            [self addSubview:m_StatusBar];
        } else {
            m_StatusBar=nil;
        }
        
        [self reloadPageView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate statusBar:(OTSStatusBar *)statusBar sleepTime:(NSInteger)sleepTime
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        [self setUserInteractionEnabled:YES];
        m_Delegate=delegate;
        m_SleepTime=sleepTime;
        //scroll view
        _scrollView = [[OTSScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self.scrollView setScrollsToTop:NO];
        [self.scrollView setDelegate:self];
        [self addSubview:self.scrollView];
        //status bar
        if (statusBar!=nil) {
            m_StatusBar = statusBar;
            [self addSubview:m_StatusBar];
        } else {
            m_StatusBar=nil;
        }
        
        [self reloadPageView];
    }
    return self;
}

-(void)reloadPageView
{
    int count=0;
    if ([m_Delegate respondsToSelector:@selector(numberOfPagesInPageView:)]) {
        count=[m_Delegate numberOfPagesInPageView:self];
    }
    //scroll view
    int frameWidth=self.frame.size.width;
    int frameHeight=self.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(frameWidth*count, frameHeight)];
    [self.scrollView setContentOffset:CGPointZero];
    for (UIView *view in [self.scrollView subviews]) {
        if ([view tag]==TAG_SCROLLVIEW_SUBVIEW) {
            [view removeFromSuperview];
        }
    }
    int i;
    for (i=0; i<count; i++) {
        UIView *view;
        if ([m_Delegate respondsToSelector:@selector(pageView:pageAtIndexPath:)]) {
            view=[m_Delegate pageView:self pageAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        } else {
            view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
        }
        [view setTag:TAG_SCROLLVIEW_SUBVIEW];
        CGRect rect=[view frame];
        rect.origin.x=frameWidth*i;
        [view setFrame:rect];
        [self.scrollView addSubview:view];
    }
    //status bar
    if (m_StatusBar!=nil) {
        [m_StatusBar setCount:count];
        [m_StatusBar setCount:count currentIndex:0];
    }
    //timer
    if (count>1 && m_SleepTime>0) {
        if (m_Timer!=nil) {
            if ([m_Timer isValid]) {
                [m_Timer invalidate];
            }
            m_Timer = nil;
        }
        m_Timer=[NSTimer scheduledTimerWithTimeInterval:m_SleepTime target:self selector:@selector(autoCyclePageView:) userInfo:nil repeats:YES];
    }
}

-(void)autoCyclePageView:(NSTimer *)timer
{
    if ([m_Delegate numberOfPagesInPageView:self]<=1) {
        return;
    }
    if ([self.scrollView contentOffset].x>=self.scrollView.frame.size.width*([m_Delegate numberOfPagesInPageView:self]-1)) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        int index=[self.scrollView contentOffset].x/self.scrollView.frame.size.width;
        CGPoint offset=[self.scrollView contentOffset];
        offset.x=self.frame.size.width*(index+1);
        [self.scrollView setContentOffset:offset animated:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    int index=[self.scrollView contentOffset].x/self.scrollView.frame.size.width;
    if ([m_Delegate respondsToSelector:@selector(pageView:didTouchOnPage:)]) {
        [m_Delegate pageView:self didTouchOnPage:[NSIndexPath indexPathForRow:index inSection:0]];
    }
    [super touchesEnded:touches withEvent:event];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset=[self.scrollView contentOffset];
    int index=offset.x/scrollView.frame.size.width;
    if (m_StatusBar!=nil) {
        [m_StatusBar setCurrentIndex:index];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGPoint offset=[self.scrollView contentOffset];
    int index=offset.x/scrollView.frame.size.width;
    if (m_StatusBar!=nil) {
        [m_StatusBar setCurrentIndex:index];
    }
}

@end

@implementation OTSStatusBar

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        m_Count=1;
        m_CurrentIndex=0;
    }
    return self;
}

-(void)setCount:(int)count currentIndex:(int)index
{
    m_Count=count;
    m_CurrentIndex=index;
}

-(void)setCurrentIndex:(int)index
{
    m_CurrentIndex=index;
}

-(void)setCount:(int)count{

}

@end

@implementation OTSDefaultStatusBar

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        [self setBackgroundColor:[UIColor clearColor]];
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        m_CurrentView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, STATUS_BAR_HEIGHT+50, STATUS_BAR_HEIGHT+50)];
        m_CurrentView.image = [UIImage imageNamed:@"cart_gift_select_point.png"];
//        m_CurrentView.hidden = YES;
        [self addSubview:m_CurrentView];
    }
    return self;
}

-(void)setCount:(int)count{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (count>=2) {
        for (int i=0; i<count; i++) {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width/count)*i, 0, STATUS_BAR_HEIGHT, STATUS_BAR_HEIGHT)];
            image.image = [UIImage imageNamed:@"cart_gift_unsel_point.png"];
            [self insertSubview:image belowSubview:image];
        }
    }
}

-(void)setCount:(int)count currentIndex:(int)index
{
    m_Count=count;
    

    if (count<=1) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }else{
        [self setCurrentIndex:index];
    }
}

-(void)setCurrentIndex:(int)index
{
    m_CurrentIndex=index;
    CGRect rect=[m_CurrentView frame];
//    rect.size.width=self.frame.size.width/m_Count;
    rect.origin.x=self.frame.size.width/m_Count*index;
    [m_CurrentView setFrame:rect];
    m_CurrentView.hidden = NO;
    [self bringSubviewToFront:m_CurrentView];
}

@end

@implementation OTSDotStatusBar

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self!=nil) {
        m_CurrentImageView=[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-10, frame.size.height/2-10, 20, 20)];
        [m_CurrentImageView setImage:[UIImage imageNamed:@"cart_gift_select_point.png"]];
        [self addSubview:m_CurrentImageView];
    }
    return self;
}

-(void)setCount:(int)count currentIndex:(int)index
{
    m_Count=count;
    CGFloat totalWidth=m_Count*20+(m_Count-1)*25;
    CGFloat startX=self.frame.size.width/2-totalWidth/2;
    int i;
    for (i=0; i<count; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(startX+45*i, self.frame.size.height/2-10, 20, 20)];
        [imageView setImage:[UIImage imageNamed:@"cart_gift_unsel_point.png"]];
        [self addSubview:imageView];
    }
    [self setCurrentIndex:index];
}

-(void)setCurrentIndex:(int)index
{
    m_CurrentIndex=index;
    
    CGFloat totalWidth=m_Count*20+(m_Count-1)*25;
    CGFloat startX=self.frame.size.width/2-totalWidth/2;
    CGFloat currentX=startX+45*index;
    CGRect rect=m_CurrentImageView.frame;
    rect.origin.x=currentX;
    [m_CurrentImageView setFrame:rect];
    [self bringSubviewToFront:m_CurrentImageView];
}

@end

@implementation OTSScrollView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesEnded:touches withEvent:event];
}

@end