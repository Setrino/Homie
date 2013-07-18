//
//  MainViewController.m
//  Homie
//
//  Created by Sergei Kostevitch on 7/17/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import "MainViewController.h"
#import "ECSlidingViewController.h"
#import "SideMenuViewController.h"

#define NAV_BAR_HEIGHT 44
#define HUBS_HEIGHT 60
#define ARROW_BUTTON_WIDTH 12
#define ARROW_BUTTON_HEIGHT 18
#define NO_OF_HUBS 3


@interface MainViewController ()

@end

@implementation MainViewController

@synthesize menuButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
	// Do any additional setup after loading the view.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[SideMenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SideMenu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(8, 10, 34, 24);
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.menuButton];
    
    hubMenuOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, 320, 368)];
    hubMenuOverlay.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview: hubMenuOverlay];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, HUBS_HEIGHT)];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
    [hubMenuOverlay addSubview:scrollView];
    
    UIView *homeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, HUBS_HEIGHT)];
    homeView.backgroundColor = [UIColor blueColor];
    
    [scrollView addSubview:homeView];
    
    UIView *officeView = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, HUBS_HEIGHT)];
    officeView.backgroundColor = [UIColor orangeColor];
    
    [scrollView addSubview:officeView];
    
    UIView *appartmentView = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, HUBS_HEIGHT)];
    appartmentView.backgroundColor = [UIColor purpleColor];
    
    [scrollView addSubview:appartmentView];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NO_OF_HUBS, scrollView.frame.size.height);
    
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, NAV_BAR_HEIGHT + HUBS_HEIGHT - 15, 20, 10)];
    pageControl.numberOfPages = NO_OF_HUBS;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview: pageControl];
    
    leftHub = [[UIButton alloc] initWithFrame:CGRectMake(5, NAV_BAR_HEIGHT + (HUBS_HEIGHT - ARROW_BUTTON_HEIGHT) / 2, 12, 18)];
    [leftHub setBackgroundImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];
    [leftHub addTarget:self action:@selector(slideLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leftHub];
    
    rightHub = [[UIButton alloc] initWithFrame:CGRectMake(315 - ARROW_BUTTON_WIDTH, NAV_BAR_HEIGHT + (HUBS_HEIGHT - ARROW_BUTTON_HEIGHT) / 2, 12, 18)];
    [rightHub setBackgroundImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
    [rightHub addTarget:self action:@selector(slideRight:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightHub];
    
     for(UITabBarItem *item in self.tabBar.items)
        item.enabled = false;
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (IBAction)revealMenu:(id)sender{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)slideLeft:(id)sender{
    
    if(pageControl.currentPage != 0){
        [self moveTo:pageControl.currentPage --];
    }
}

- (IBAction)slideRight:(id)sender{
    
    if(pageControl.currentPage != pageControl.numberOfPages - 1){
        [self moveTo:pageControl.currentPage ++];
    }
}

- (IBAction)changePage:(id)sender{
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)moveTo:(int)newPage{
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControl.currentPage = newPage;
}

@end
