//
//  sampletwitter1ViewController.h
//  sampletwitter1
//
//  Created by SOMTD on 11/08/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"

@class SA_OAuthTwitterEngine;


@interface sampletwitter1ViewController : UIViewController <SA_OAuthTwitterControllerDelegate> {
	SA_OAuthTwitterEngine				*_engine;
    
}

- (IBAction)startoauth:(id)sender;

@end
