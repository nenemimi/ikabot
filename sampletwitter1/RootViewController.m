//
//  RootViewController.m
//  TwitterViewer
//
//  Created by 西村 工 on 11/09/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "URLLoader.h"
#import "StatusXMLParser.h"

@implementation RootViewController

@synthesize statuses;

#pragma mark -
#pragma mark View lifecycle

- (void) reload: (id)sender {
    [self loadTimeLineByUserName:@"itmedia"];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath   
{   
    UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    CGSize bounds = CGSizeMake(self.tableView.frame.size.width - 150, self.tableView.frame.size.height);
    
    CGSize size = [cell.detailTextLabel.text sizeWithFont: cell.detailTextLabel.font 
                                        constrainedToSize: bounds 
                                            lineBreakMode: UILineBreakModeCharacterWrap];
    return size.height;
}

- (void) loadTimeLineByUserName: (NSString *)userName {
//    static NSString *urlFormat = @"http://twitter.com/status/mentions/itmedia.xml";
	
	//タイムラインを表示
    static NSString *urlFormat = @"http://api.twitter.com/1/statuses/user_timeline/itmedia.xml";
    
    NSString *url = [NSString stringWithFormat:urlFormat, userName];
    
    URLLoader *loder = [[[URLLoader alloc] init] autorelease];
    
    [[NSNotificationCenter defaultCenter] addObserver: self                         
                                             selector: @selector(loadTimeLineDidEnd:)
                                                 name: @"connectionDidFinishNotification"
                                               object: loder];
	
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(loadTimeLineFailed:)
                                                 name: @"connectionDidFailWithError"
                                               object: loder];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [loder loadFromUrl:url method: @"GET"];
}

// （7）
- (void) loadTimeLineDidEnd: (NSNotification *)notification {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	URLLoader *loder = (URLLoader *)[notification object];
    NSData *xmlData = loder.data;
    
    NSLog(@"%@", [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding]);
	
	StatusXMLParser *parser = [[[StatusXMLParser alloc] init] autorelease];
    self.statuses = [parser parseStatuses:xmlData];
    [self.tableView reloadData];
}

// （8）
- (void) loadTimeLineFailed: (NSNotification *)notification {
    
    UIAlertView *alert = [[UIAlertView alloc]  
                          initWithTitle:@"エラー"  
						  message:@"タイムラインの取得に失敗しました。"  
						  delegate:self
						  cancelButtonTitle:@"閉じる"  
						  otherButtonTitles:nil];
    [alert show];
    [alert release];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// ナビゲーションバーの色を青っぽく変更
    self.navigationController.navigationBar.tintColor = 
		[UIColor colorWithRed:0.3 green:0.6 blue:0.7 alpha:1.0];
	
    // 更新ボタンの追加
    self.navigationItem.leftBarButtonItem = 
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
						target:self
						action:@selector(reload:)];
	
	
	[self loadTimeLineByUserName:@"itmedia"];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.statuses count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	int row = [indexPath row];
    
    NSString *name = [[statuses objectAtIndex:row] objectForKey:@"name"];
    NSString *text = [[statuses objectAtIndex:row] objectForKey:@"text"];
    
    // ユーザー名
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.text = name;
    
    // テキスト
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = text;

    return cell;
}







#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

