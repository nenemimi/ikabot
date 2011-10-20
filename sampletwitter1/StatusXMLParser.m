//
//  StatusXMLParser.m
//  TwitterViewer
//
//  Created by 西村 工 on 11/09/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatusXMLParser.h"


@implementation StatusXMLParser
@synthesize currentXpath;
@synthesize statuses;
@synthesize currentStatus;
@synthesize textNodeCharacters;

// （9）
- (void) parserDidStartDocument:(NSXMLParser *)parser {
    self.currentXpath = [[[NSMutableString alloc]init] autorelease];
    self.statuses = [[[NSMutableArray alloc] init] autorelease];
}

// （10）
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    [self.currentXpath appendString: elementName];
    [self.currentXpath appendString: @"/"];
    
    self.textNodeCharacters = [[[NSMutableString alloc] init] autorelease];
    
    if ([self.currentXpath isEqualToString: @"statuses/status/"]) {
        self.currentStatus = [[[NSMutableDictionary alloc] init] autorelease];
    }
}

// （11）
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
    NSString *textData = [self.textNodeCharacters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.currentXpath isEqualToString: @"statuses/status/"]) {
        [self.statuses addObject:self.currentStatus];
        self.currentStatus = nil;
		
    } else if ([self.currentXpath isEqualToString: @"statuses/status/text/"]) {
        [self.currentStatus setValue:textData forKey:@"text"];
        
    } else if ([self.currentXpath isEqualToString: @"statuses/status/user/name/"]) {
        [self.currentStatus setValue:textData forKey:@"name"];
    }
    
    int delLength = [elementName length] + 1;
    int delIndex = [self.currentXpath length] - delLength;
    
    [self.currentXpath deleteCharactersInRange:NSMakeRange(delIndex,delLength)];
}

// （12）
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.textNodeCharacters appendString:string];
}

// （13）
- (NSArray *) parseStatuses:(NSData *)xmlData {
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:xmlData] autorelease];
    [parser setDelegate:self];
    [parser parse];
    
    return self.statuses;
}

- (void) dealloc {
    [currentXpath release];
    [statuses release];
    [currentStatus release];
    [textNodeCharacters release];
    [super dealloc];
}

@end
