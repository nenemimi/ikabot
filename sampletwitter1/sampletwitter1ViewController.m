//
//  sampletwitter1ViewController.m
//  sampletwitter1
//
//  Created by SOMTD on 11/08/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "URLLoader.h"
#import "StatusXMLParser.h"
#import "sampletwitter1ViewController.h"
#import "SA_OAuthTwitterEngine.h"
#import "RootViewController.h"
#define kOAuthConsumerKey				@"kBfd9Mv2O0Bp8mNULxFwg"		//REPLACE ME
#define kOAuthConsumerSecret			@"crTdJYl3cStngcwYCkMz6WB6CIQhDPravVAC6wjGw"		//REPLACE ME

@implementation sampletwitter1ViewController

//=============================================================================================================================
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate

//OAuth認証成功時のdelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);
	//ここに記述
//	RootViewController *viewController = [[RootViewController alloc] init];
//	
//	[self presentModalViewController:viewController animated:YES];
}

//OAuth認証失敗時のdelegate
- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

//'Cancel'ボタン押下時のdelegate
- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}

//=============================================================================================================================
#pragma mark OAuth ModalView

- (IBAction)startoauth:(id)sender {
    NSLog(@"OAuth startbutton pushed");
    	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller) 
        //OAuthによる認証が完了していなければModalViewを表示。
		[self presentModalViewController: controller animated: YES];
	else {
        //既にOAuthによる認証が完了していればログ出力(todo:認証ユーザーのタイムラインを表示)
        NSLog(@"Already Authenicated.");
		//ここに記述
//		[_engine sendUpdate: [NSString stringWithFormat: @"OAuth... %@", [NSDate date]]];

		RootViewController *viewController = [[RootViewController alloc] init];
		
		[self presentModalViewController:viewController animated:YES];
		
		
	}

}

//=============================================================================================================================
#pragma mark ViewController Stuff
- (void)dealloc {
	[_engine release];
    [super dealloc];
}
- (void) viewDidAppear: (BOOL)animated {

	if (_engine) return;
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	
//	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
//	
//	if (controller) 
//		[self presentModalViewController: controller animated: YES];
//	else {
//        
//		[_engine sendUpdate: [NSString stringWithFormat: @"OAuth... %@", [NSDate date]]];
//	}
    
}


@end