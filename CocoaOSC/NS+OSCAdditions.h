//
//  NSDate+OSCAdditions.h
//  CocoaOSC
//
//  Created by Daniel Dickison on 1/26/10.
//  Copyright 2010 Daniel_Dickison. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (OSCAdditions)

+ (NSDate *)ntpReferenceDate;
- (uint64_t)ntpTimestamp;
+ (NSDate *)dateWithNTPTimestamp:(uint64_t)timestamp;

@end


@interface NSArray (OSCAdditions)

- (id)car;
- (NSArray *)cdr;

@end
