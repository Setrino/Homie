//
//  RoomAddViewController.h
//  Homie
//
//  Created by Sergei Kostevitch on 7/19/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomAddViewController;
@class Room;

@protocol RoomAddViewControllerDelegate <NSObject>
- (void)roomAddViewControllerDidCancel:
(RoomAddViewController *)controller;
- (void)roomAddViewControllerDidSave:
(RoomAddViewController *)controller;
- (void)roomAddViewControllerDidAddRoom:
(RoomAddViewController *)controller addRoom: (Room *) room;

@end

@interface RoomAddViewController : UITableViewController

@property (nonatomic, weak) id <RoomAddViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *roomNameTextField;

@end
