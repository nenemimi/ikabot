//
//  URLLoader.h
//  TwitterViewer
//
//  Created by 西村 工 on 11/09/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLLoader : NSObject {
	NSURLConnection *connection;
	NSMutableData *data;
}

@property(retain,nonatomic)NSURLConnection *connection;
@property(retain,nonatomic)NSMutableData *data;

-(void)loadFromUrl:(NSString *)url method:(NSString *)method;


@end
