//
//  RoomViewController.h
//  Homie
//
//  Created by Sergei Kostevitch on 7/17/13.
//  Copyright (c) 2013 Prestigio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomAddViewController.h"

@interface RoomViewController : UITableViewController <RoomAddViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *addRoom;

@end
