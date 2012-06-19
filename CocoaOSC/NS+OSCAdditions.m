//
//  NSDate+OSCAdditions.m
//  CocoaOSC
//
//  Created by Daniel Dickison on 1/26/10.
//  Copyright 2010 Daniel_Dickison. All rights reserved.
//

#import "NS+OSCAdditions.h"


@implementation NSDate (OSCAdditions)

+ (NSDate *)ntpReferenceDate
{
    static NSDate *date = nil;
    if (!date)
    {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setYear:1900];
        [components setMonth:1];
        [components setDay:1];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        date = [[calendar dateFromComponents:components] copy];
        [components release];
        [calendar release];
    }
    return date;
}


- (uint64_t)ntpTimestamp
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate];
    interval -= [[NSDate ntpReferenceDate] timeIntervalSinceReferenceDate];
    uint32_t seconds = (uint32_t)interval; //Floor
    uint32_t fractions = 0xffffffff * (interval - seconds);
    return ((uint64_t)seconds << 32) + fractions;
}

+ (NSDate *)dateWithNTPTimestamp:(uint64_t)timestamp
{
    uint32_t seconds = timestamp >> 32;
    uint32_t fractions = timestamp & 0xffffffff;
    NSTimeInterval interval = [[NSDate ntpReferenceDate] timeIntervalSinceReferenceDate];
    interval += (NSTimeInterval)seconds;
    interval += (NSTimeInterval)((double)fractions / 0xffffffff);
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

@end


@implementation NSArray (OSCAdditions)

- (id)car
{
    if ([self count] > 0) return [self objectAtIndex:0];
    else return nil;
}

- (NSArray *)cdr
{
    if ([self count] > 1) return [self subarrayWithRange:NSMakeRange(1, [self count]-1)];
    else return nil;
}

@end
