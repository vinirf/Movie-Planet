//
//  Created by matt on 28/09/12.
//  Additions by Marin Todorov for YouTube JSONModel tutorial

#import "MGBox.h"

@interface PhotoBox : MGBox

+ (PhotoBox *)photoBoxForURL:(NSString*)tempo :(NSURL*)url title:(NSString*)title;

+ (NSString *)timeFormatted:(int)totalSeconds;

@property (strong, nonatomic) NSString* titleString;
@property (strong, nonatomic) NSString* seconds;

@end
