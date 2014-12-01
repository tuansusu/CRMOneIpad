//
//  QLPageScrollView.m
//  SampleTransform
//
//  Created by Quang on 11/9/12.
//  Copyright (c) 2012 Quang. All rights reserved.
//

#import "QLCoverFlowPagesView.h"
#import <QuartzCore/QuartzCore.h>

/*
 Follow this newspaper: http://b2cloud.com.au/how-to-guides/ios-perspective-transform
 To make perspective transform, value of m24, m34 need to be reduced.
 
 */
#define CATransform3DPerspective(t, x, y) (CATransform3DConcat(t, CATransform3DMake(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, 0, 0, 0, 0, 1)))
#define CATransform3DMakePerspective(x, y) (CATransform3DPerspective(CATransform3DIdentity, x, y))

CG_INLINE CATransform3D
CATransform3DMake(CGFloat m11, CGFloat m12, CGFloat m13, CGFloat m14,
				  CGFloat m21, CGFloat m22, CGFloat m23, CGFloat m24,
				  CGFloat m31, CGFloat m32, CGFloat m33, CGFloat m34,
				  CGFloat m41, CGFloat m42, CGFloat m43, CGFloat m44)
{
	CATransform3D t;
	t.m11 = m11; t.m12 = m12; t.m13 = m13; t.m14 = m14;
	t.m21 = m21; t.m22 = m22; t.m23 = m23; t.m24 = m24;
	t.m31 = m31; t.m32 = m32; t.m33 = m33; t.m34 = m34;
	t.m41 = m41; t.m42 = m42; t.m43 = m43; t.m44 = m44;
	return t;
}

#define kPageViewTopMargin 0

@interface QLCoverFlowPagesView () {
    float _pageWidth;
    float _pageHeight;
    NSInteger _currentIndex;
    UIView *_containerView;
    NSMutableDictionary *_reusableViewStorages;
    UIPageControl *_pageControl;
}

@end

@implementation QLCoverFlowPagesView

- (void)doInit;
{
    _reusableViewStorages = [NSMutableDictionary dictionary];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.scrollView addSubview:_containerView];
    [self addSubview:self.scrollView];
    // load the data
    [self reloadData];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self doInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.showPageControl)
        _pageControl.frame = CGRectMake(0, self.bounds.size.height - 20., self.bounds.size.width, 20.);
    
        //_pageControl.frame = CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 0);
    
    [self reloadPagesView];
}

- (void)calculateContentSize;
{
    NSInteger numberOfPages = 0;
    if (self.dataSource)
        numberOfPages = [self.dataSource coverFlowPagesView:self numberOfPagesInSection:0];
    CGRect viewBounds = self.bounds;
    //bangtv4 :)
    _pageWidth = viewBounds.size.width/2-44;
    _pageHeight = viewBounds.size.height;
    float contentWidth = numberOfPages * _pageWidth + _pageWidth;
    [self.scrollView setContentSize:CGSizeMake(contentWidth, _pageHeight)];
    _containerView.frame = CGRectMake(0, 0, contentWidth, viewBounds.size.height);
}

- (CGRect)frameOfPageViewAtIndexPath:(NSIndexPath *)indexpath;
{
    float x = indexpath.row * _pageWidth + _pageWidth / 2;
    //float x = indexpath.row * _pageWidth;
    float y = kPageViewTopMargin;
    return CGRectMake(x, y, _pageWidth, _pageHeight);
}

- (NSIndexPath *)indexPathOfFrame:(CGRect)frame;
{
    NSInteger index = floorf((CGRectGetMidX(frame) - _pageWidth / 2) / _pageWidth);
    return [NSIndexPath indexPathForRow:index inSection:0];
}

- (BOOL)isPageViewOnScreen:(QLPageView *)pageView;
{
    CGRect pageFrame = [self convertRect:pageView.frame fromView:_containerView];
    return CGRectIntersectsRect(pageFrame, self.scrollView.frame);
}

- (void)reloadData {
    _currentIndex = 0;
    [self reloadPagesView];
}

- (void)reloadPagesView {
    // remove page views
    for (QLPageView *view in [_containerView subviews]) {
        [view removeFromSuperview];
    }
    [_reusableViewStorages removeAllObjects];
    [self calculateContentSize];
    [self.scrollView setContentOffset:CGPointMake(_currentIndex * _pageWidth, 0)];
    [self loadPageViewsWithAnimate:NO];
    if (self.showPageControl)
        [self setupPageControl];
    
}

- (id)dequeueReusablePageViewWithIdentifier:(NSString *)identifier {
    id lastObject = [[_reusableViewStorages objectForKey:identifier] lastObject];
    if (lastObject)
        [[_reusableViewStorages objectForKey:identifier] removeLastObject];
    return lastObject;
}

- (void)enQueuePageViews;
{
    // enqueue page views
    NSArray *pageViews = [_containerView subviews];
    for (QLPageView *pageView in pageViews) {
        if (![self isPageViewOnScreen:pageView]) {
            if (pageView.reuseIdentifier) {
                NSMutableArray *array = [_reusableViewStorages objectForKey:pageView.reuseIdentifier];
                if (!array) {
                    array = [NSMutableArray array];
                    [_reusableViewStorages setObject:array forKey:pageView.reuseIdentifier];
                }
                [array addObject:pageView];                
            }
            [pageView removeFromSuperview];
        }
    }
}

- (void)loadPageViewsWithAnimate:(BOOL)animate;
{
    [self enQueuePageViews];
    NSMutableSet *usedIndexPaths = [NSMutableSet set];
    NSArray *pageViews = [_containerView subviews];
    for (QLPageView *pageView in pageViews) {
        if ([self isPageViewOnScreen:pageView]) {
            [usedIndexPaths addObject:[self indexPathOfFrame:pageView.frame]];
        }
    }
    
    // initialize new page views
    NSInteger numberOfPages = 0;
    if (self.dataSource)
        numberOfPages = [self.dataSource coverFlowPagesView:self numberOfPagesInSection:0];
        
    for (int i = 0; i < numberOfPages; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if ([usedIndexPaths containsObject:indexPath])
            continue;
        CGRect pageFrame = [self frameOfPageViewAtIndexPath:indexPath];
        if (CGRectIntersectsRect([self convertRect:pageFrame fromView:_containerView], self.scrollView.frame)) {
            QLPageView *pageView = [self.dataSource coverFlowPagesView:self viewForPageAtIndexPath:indexPath];
            pageView.frame = pageFrame;
            [_containerView addSubview:pageView];
            if (i == _currentIndex) {
                [self bringSubviewToFront:pageView];
                [self resetTransform:pageView];
            }
        }
    }
    
    if (animate) {
        [UIView animateWithDuration:0.5 animations:^{
            for (QLPageView *pageView in _containerView.subviews) {
                int pageIndex = [self indexPathOfFrame:pageView.frame].row;
                if (pageIndex < _currentIndex)
                    [self makeLeftPerspectiveTransform:pageView];
                if (pageIndex > _currentIndex)
                    [self makeRightPerspectiveTransform:pageView];
                if (pageIndex == _currentIndex)
                    [self resetTransform:pageView];
            }
            
        } completion:^(BOOL finished) {
            
        }];

    } else {
        for (QLPageView *pageView in _containerView.subviews) {
            int pageIndex = [self indexPathOfFrame:pageView.frame].row;
            
            if (pageIndex < _currentIndex)
                [self makeLeftPerspectiveTransform:pageView];
            if (pageIndex > _currentIndex)
                [self makeRightPerspectiveTransform:pageView];
            if (pageIndex == _currentIndex)
                [self resetTransform:pageView];
        }
        
    }
}

#pragma mark - page control management
- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    if (_showPageControl) {
        if (!_pageControl) {
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20.)];
            
           // _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width,0)];
            _pageControl.hidesForSinglePage = YES;
            [_pageControl addTarget:self action:@selector(changePageByPageControl) forControlEvents:UIControlEventValueChanged];
            [self addSubview:_pageControl];
        }
        [self setupPageControl];
    }
    _pageControl.hidden = !_showPageControl;
}

- (void)changePageByPageControl;
{
    int page = _pageControl.currentPage;

    [self.scrollView setContentOffset:CGPointMake(page * _pageWidth, 0) animated:YES];
}

- (void)setupPageControl;
{
    NSInteger numberOfPages = 0;
    if (self.dataSource)
        numberOfPages = [self.dataSource coverFlowPagesView:self numberOfPagesInSection:0];
    _pageControl.numberOfPages = numberOfPages;
    _pageControl.currentPage = _currentIndex;
}

#pragma mark - perspective transform
- (void)makeRightPerspectiveTransform:(UIView *)view;
{
    CATransform3D transfrom = CATransform3DMakeScale(0.8, 0.8, 0.8);
    //CATransform3D transfrom = CATransform3DMakeScale(0.1, 0.1, 0.1);
    transfrom = CATransform3DConcat(transfrom, CATransform3DMakePerspective(1 / -500., 0));
    view.layer.transform = transfrom;
}

- (void)makeLeftPerspectiveTransform:(UIView *)view;
{
    CATransform3D transfrom = CATransform3DMakeScale(0.8, 0.8, 0.8);
    //CATransform3D transfrom = CATransform3DMakeScale(0.1, 0.1, 0.1);
    transfrom = CATransform3DConcat(transfrom, CATransform3DMakePerspective(1 / 500., 0));
    view.layer.transform = transfrom;
}

- (void)resetTransform:(UIView *)view;
{
    view.layer.transform = CATransform3DIdentity;
}


#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!scrollView.decelerating && !scrollView.dragging) {
        int nextIndex = floorf((self.scrollView.contentOffset.x - _pageWidth / 2) / _pageWidth) + 1;
        //int nextIndex = floorf((self.scrollView.contentOffset.x) / _pageWidth) + 1;
        if (nextIndex != _currentIndex) {
            _currentIndex = nextIndex;
            _pageControl.currentPage = _currentIndex;
            [self loadPageViewsWithAnimate:YES];
            return;
        }
    }
    [self loadPageViewsWithAnimate:NO];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    int nextIndex = floorf((targetContentOffset->x - _pageWidth / 2) / _pageWidth) + 1;
    targetContentOffset->x = nextIndex * _pageWidth;
    if (nextIndex != _currentIndex) {
        // estimate the animation based on the distance of browsing
        BOOL animate = ABS(_currentIndex - nextIndex) < 4;
        _currentIndex = nextIndex;
        _pageControl.currentPage = _currentIndex;
        
        [self loadPageViewsWithAnimate:animate];
    }
}


@end
