//
//  MainViewController.h
//  Homie
//
//  Created by Sergei Kostevitch on 7/17/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController <UIScrollViewDelegate>{

    UIView *hubMenuOverlay;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

@property (strong, nonatomic) UIButton *menuButton;

@end
