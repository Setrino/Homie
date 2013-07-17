//
//  RoomViewController.m
//  Homie
//
//  Created by Sergei Kostevitch on 7/17/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import "RoomViewController.h"
#import "MainViewController.h"

@interface RoomViewController ()

@property (strong, nonatomic) NSArray *rooms;
@property (strong, nonatomic) NSArray *room1;
@property (strong, nonatomic) NSArray *room2;
@property (strong, nonatomic) NSArray *room3;

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
    
    room1 = [NSArray arrayWithObjects:@"Table Light", @"Side Light", @"Music Switch", @"Windows Switch", @"Temperature Sensor", @"Curtains Switch", nil];
    room2 = [NSArray arrayWithObjects:@"Bedside Lamp", @"Ceiling Lamp", @"Blinds", @"TV Switch", nil];
    room3 = [NSArray arrayWithObjects:@"Wall Lights", @"Humidity Sensor", @"Temperature Sensor", @"Sprinklers", nil];
    rooms = [NSArray arrayWithObjects:room1, room2, room3, nil];
    
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
    switch (section) {
        case 0:
            return [self.room1 count];
        case 1:
            return [self.room2 count];
        case 2:
            return [self.room3 count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.section == 0){
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.room1 objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.room2 objectAtIndex:indexPath.row]];
    }
    else if (indexPath.section == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.room3 objectAtIndex:indexPath.row]];
    }
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        return @"Dining Room";
    }else if (section == 1){
        return @"Bedroom";
    }else if (section == 2){
        return @"Garden";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UIImage *roomImage;
    
    if(section == 0){
        roomImage = [UIImage imageNamed:@"dining.png"];
    }else if (section == 1){
        roomImage = [UIImage imageNamed:@"bedroom.png"];
    }else if (section == 2){
        roomImage = [UIImage imageNamed:@"garden.png"];
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:roomImage];
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
    
    if(indexPath.section == 0){
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.room1 objectAtIndex:indexPath.row]];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
    }else if (indexPath.section == 1){
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.room2 objectAtIndex:indexPath.row]];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
    }else if (indexPath.section == 1){
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.room3 objectAtIndex:indexPath.row]];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
    }
}

- (IBAction)addRoom:(id)sender{
    NSLog(@"Add Room");
    
}

@end
