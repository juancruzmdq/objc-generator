//
//  UIScrollViewProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/15/09.
//  Adrian Kosmaczewski 2009
//

#import "UIScrollViewProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UIScrollViewProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UIScrollView";
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"indicatorStyle"])
    {
        [output setObject:[OGInstruction initWithString:[value scrollViewIndicatorStyleString]] forKey:item];
    }
    else if ([item isEqualToString:@"showsHorizontalScrollIndicator"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"showsVerticalScrollIndicator"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"scrollEnabled"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"pagingEnabled"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"directionalLockEnabled"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"bounces"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"alwaysBounceHorizontal"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"alwaysBounceVertical"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"maximumZoomScale"])
    {
        [output setObject:[OGInstruction initWithString:[value floatString]] forKey:item];
    }
    else if ([item isEqualToString:@"minimumZoomScale"])
    {
        [output setObject:[OGInstruction initWithString:[value floatString]] forKey:item];
    }
    else if ([item isEqualToString:@"bouncesZoom"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"delaysContentTouches"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"canCancelContentTouches"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
