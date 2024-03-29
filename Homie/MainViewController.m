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
#import "RoomViewController.h"

#define NAV_BAR_HEIGHT 44
#define HUBS_HEIGHT 60
#define NEWS_FEED_HEIGHT 200
#define ARROW_BUTTON_WIDTH 12
#define ARROW_BUTTON_HEIGHT 18
#define NO_OF_HUBS 3


@interface MainViewController ()

@end

@implementation MainViewController

@synthesize menuButton;
@synthesize homeButton;

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
    
    NSArray *houseNews = [NSArray arrayWithObjects:@"Humidity Sensor", @"Light 1", @"Music 1", @"Light 2", @"TV 1", @"Air-con", nil];
    NSArray *officeNews = [NSArray arrayWithObjects:@"Alarm Switch", @"Big Light", @"Motion 1", @"Motion 2", @"Projector", @"Server 1", nil];
    NSArray *appartmentNews = [NSArray arrayWithObjects:@"Front Door", @"Window 1", @"Curatain 2", @"Gas Alarm", @"Temperature", @"Lights 2", nil];
    
    newsFeed = [NSArray arrayWithObjects:houseNews, officeNews, appartmentNews, nil];
    
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(8, 10, 34, 24);
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.menuButton];
    
    self.homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(60, 6, 30, 30);
    [homeButton setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(hideMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.homeButton];
    
    hubMenuOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT, 320, 368)];
    hubMenuOverlay.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview: hubMenuOverlay];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, HUBS_HEIGHT)];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    [scrollView.layer setCornerRadius:8.0f];
    [scrollView.layer setMasksToBounds:YES];
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
    [hubMenuOverlay addSubview:scrollView];
    
    UIView *homeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, HUBS_HEIGHT)];
    homeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"house.png"]];
    
    NSString *homeString = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    
    [scrollView addSubview:homeView];
    
    UIView *officeView = [[UIView alloc] initWithFrame:CGRectMake(320, 0, 320, HUBS_HEIGHT)];
    officeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"office.png"]];
    
    [scrollView addSubview:officeView];
    
    UIView *appartmentView = [[UIView alloc] initWithFrame:CGRectMake(640, 0, 320, HUBS_HEIGHT)];
    appartmentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"apartment.png"]];
    
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
    
    scrollViewText = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HUBS_HEIGHT, 320, NEWS_FEED_HEIGHT)];
    scrollViewText.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    scrollViewText.scrollEnabled = YES;
    
    notificationsLog = [[UITextView alloc] initWithFrame:CGRectMake(0, HUBS_HEIGHT, 320, NEWS_FEED_HEIGHT)];
    notificationsLog.text = homeString;
    [notificationsLog.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [notificationsLog.layer setBorderWidth: 1.0];
    [notificationsLog.layer setCornerRadius:8.0f];
    [notificationsLog.layer setMasksToBounds:YES];
    [notificationsLog setFont:[UIFont systemFontOfSize:16]];
    notificationsLog.clipsToBounds = YES;
    notificationsLog.editable = NO;
    
    //[hubMenuOverlay addSubview:notificationsLog];
    
    notificationsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, HUBS_HEIGHT, 320, NEWS_FEED_HEIGHT) style:UITableViewStylePlain];
    notificationsTable.delegate = self;
    notificationsTable.dataSource = self;
    
    [hubMenuOverlay addSubview:notificationsTable];
    
    
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
    [notificationsTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"NotificationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //frame should be set accordingly(means should be framed accordingly).
    
    //cell.textLabel.text = [[newsFeed objectAtIndex:pageControl.currentPage] objectAtIndex:indexPath.row];
    
    UILabel *l1=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 50)];
    l1.text = @"Rm: Dining";
    
    UILabel *l2=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 100, 50)];
    l2.text = [[newsFeed objectAtIndex:pageControl.currentPage] objectAtIndex:indexPath.row];
    
    UILabel *l3=[[UILabel alloc]initWithFrame:CGRectMake(200, 5, 120, 50)];
    l3.text = @"Status: Not working";
    
    [cell.contentView addSubview:l1];
    [cell.contentView addSubview:l2];
    [cell.contentView addSubview:l3];
    
    return cell;
}

- (IBAction)revealMenu:(id)sender{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)hideMenu:(id)sender{
    
    
    if(hiddenHome){
        hubMenuOverlay.hidden = FALSE;
        hiddenHome = FALSE;
        leftHub.hidden = FALSE;
        rightHub.hidden = FALSE;
        for(UITabBarItem *item in self.tabBar.items)
            item.enabled = false;
    }else{
        hubMenuOverlay.hidden = TRUE;
        hiddenHome = TRUE;
        leftHub.hidden = TRUE;
        rightHub.hidden = TRUE;
        for(UITabBarItem *item in self.tabBar.items)
            item.enabled = true;
    }
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
    [notificationsTable reloadData];
}

- (void)moveTo:(int)newPage{
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControl.currentPage = newPage;
    [notificationsTable reloadData];
}

@end
