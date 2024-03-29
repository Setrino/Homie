//
//  RoomAddViewController.m
//  Homie
//
//  Created by Sergei Kostevitch on 7/19/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import "RoomAddViewController.h"
#import "Room.h"

@interface RoomAddViewController ()

@end

@implementation RoomAddViewController

@synthesize delegate, roomNameTextField;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        [self.roomNameTextField becomeFirstResponder];
    }
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

- (IBAction)cancel:(id)sender{
    
    [self.delegate roomAddViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender{
    
    Room *room = [[Room alloc] init];
    room.name = self.roomNameTextField.text;
    room.type = @"Kitchen";
    room.image = [UIImage imageNamed:@"kitchen.png"];
    room.devices = [NSArray arrayWithObjects:@"Humidity", @"Light", @"Microwave", @"Oven", @"Fridge", @"Light 0", nil];
    [self.delegate roomAddViewControllerDidAddRoom:self addRoom:room];
    
    [self.delegate roomAddViewControllerDidSave:self];
}

@end
