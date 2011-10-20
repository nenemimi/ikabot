//
//  sampletwitter1AppDelegate.h
//  sampletwitter1
//
//  Created by SOMTD on 11/08/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sampletwitter1ViewController;

@interface sampletwitter1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    sampletwitter1ViewController *viewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet sampletwitter1ViewController *viewController;

@end
