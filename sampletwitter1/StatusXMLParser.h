//
//  StatusXMLParser.h
//  TwitterViewer
//
//  Created by 西村 工 on 11/09/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusXMLParser : NSObject <NSXMLParserDelegate> {
    NSMutableString *currentXpath;
    NSMutableArray *statuses;
    NSMutableDictionary *currentStatus;
    NSMutableString *textNodeCharacters;
}

@property (retain , nonatomic) NSMutableString *currentXpath;
@property (retain , nonatomic) NSMutableArray *statuses;
@property (retain , nonatomic) NSMutableDictionary *currentStatus;
@property (retain , nonatomic) NSMutableString *textNodeCharacters;

- (NSArray *) parseStatuses: (NSData *) xmlData;

@end