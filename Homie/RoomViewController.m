//
//  RoomViewController.m
//  Homie
//
//  Created by Sergei Kostevitch on 7/17/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import "RoomViewController.h"
#import "MainViewController.h"
#import "RoomAddViewController.h"
#import "DetailsViewController.h"
#import "Room.h"

@interface RoomViewController ()

@property (strong, nonatomic) NSMutableArray *rooms;
@property (strong, nonatomic) Room *room1;
@property (strong, nonatomic) Room *room2;
@property (strong, nonatomic) Room *room3;

@end

@implementation RoomViewController

@synthesize rooms, room1, room2, room3, addRoom;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    room1 = [[Room alloc] init];
    room1.name = room1.type = @"Dining Room";
    room1.image = [UIImage imageNamed:@"dining.png"];
    room1.devices = [NSArray arrayWithObjects:@"Table Light", @"Side Light", @"Music Switch", @"Windows Switch", @"Temperature Sensor", @"Curtains Switch", nil];
    
    room2 = [[Room alloc] init];
    room2.name = room2.type = @"Bedroom";
    room2.image = [UIImage imageNamed:@"bedroom.png"];
    room2.devices = [NSArray arrayWithObjects:@"Bedside Lamp", @"Ceiling Lamp", @"Blinds", @"TV Switch", nil];
    
    room3 = [[Room alloc] init];
    room3.name = room3.type = @"Garden";
    room3.image = [UIImage imageNamed:@"garden.png"];
    room3.devices = [NSArray arrayWithObjects:@"Wall Lights", @"Humidity Sensor", @"Temperature Sensor", @"Sprinklers", nil];
    
    rooms = [NSMutableArray arrayWithObjects:room1, room2, room3, nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.rooms count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.

    return [((Room *)[self.rooms objectAtIndex:section]).devices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"RoomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [((Room *)[self.rooms objectAtIndex:indexPath.section]).devices objectAtIndex:indexPath.row]];
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return ((Room *)[rooms objectAtIndex:section]).name;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *backLabel = [[UILabel alloc] init];
    backLabel.frame = CGRectMake(0, 0, 320, 50);
    backLabel.backgroundColor = [UIColor whiteColor];
    
    // Create label with section title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(60, 0, 300, 50);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = sectionTitle;
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [view addSubview:backLabel];
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:((Room *)[rooms objectAtIndex:section]).image];
    imageView.frame = CGRectMake(0, 0, 50, 50);
    [view addSubview:imageView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    UIViewController *newTopViewController;
        
    NSString *identifier = [NSString stringWithFormat:@"%@", [((Room *)[self.rooms objectAtIndex:indexPath.section]).devices objectAtIndex:indexPath.row]];
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }

- (IBAction)addRoom:(id)sender{
    NSLog(@"Add Room");
    
    /*
     for(UITabBarItem *item in self.tabBarController.tabBar.items)
        item.enabled = true;
     */
    
}

#pragma mark - RoomAddViewCotnrollerDelegate

- (void)roomAddViewControllerDidCancel:(RoomAddViewController *)controller{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)roomAddViewControllerDidSave:(RoomAddViewController *)controller{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)roomAddViewControllerDidAddRoom:(RoomAddViewController *)controller addRoom:(Room *)room{
    
    [self.rooms addObject:room];
    //[self.tableView reloadData];
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:[self.rooms count] - 1] withRowAnimation:UITableViewRowAnimationAutomatic];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"AddRoom"]){
        UINavigationController *navigationController = segue.destinationViewController;
        RoomAddViewController *roomAddViewController = [[navigationController viewControllers] objectAtIndex:0];
        roomAddViewController.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"showDeviceDetails"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *detailsViewController = segue.destinationViewController;
        detailsViewController.title = [((Room *)[self.rooms objectAtIndex:indexPath.section]).devices objectAtIndex: indexPath.row];
        detailsViewController.roomName = ((Room *)[self.rooms objectAtIndex:indexPath.section]).name;
    }
}

@end
