//
//  NSMutableArray+BFKit.m
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "NSMutableArray+BFKit.h"

@implementation NSMutableArray (BFKit)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if([self count] > 0)
        return [self objectAtIndex:index];
    else
        return nil;
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if(to != from)
    {
        id obj = [self safeObjectAtIndex:from];
        [self removeObjectAtIndex:from];
        
        if(to >= [self count])
            [self addObject:obj];
        else
            [self insertObject:obj atIndex:to];
    }
}

- (NSMutableArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for(id element in enumerator) [array addObject:element];
    
    return array;
}

+ (NSMutableArray *)sortArrayByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    [tempArray addObjectsFromArray:array];
    
    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:brandDescriptor, nil];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:sortDescriptors];
    [tempArray removeAllObjects];
    tempArray = (NSMutableArray *)sortedArray;
    [array removeAllObjects];
    [array addObjectsFromArray:tempArray];
    
    return array;
}

@end
