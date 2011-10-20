//
//  RootViewController.h
//  TwitterViewer
//
//  Created by 西村 工 on 11/09/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	NSArray *statuses;
}

@property(retain, nonatomic) NSArray *statuses;

@end
