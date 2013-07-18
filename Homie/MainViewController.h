//
//  MainViewController.h
//  Homie
//
//  Created by Sergei Kostevitch on 7/17/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>{

    NSArray *newsFeed;
    UIButton *leftHub;
    UIButton *rightHub;
    UIView *hubMenuOverlay;
    UIScrollView *scrollView;
    UIScrollView *scrollViewText;
    UITextView *notificationsLog;
    UITableView *notificationsTable;
    UIPageControl *pageControl;
}

@property (strong, nonatomic) UIButton *menuButton;

@end
