//
//  UISegmentedControlProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/14/09.
//  Adrian Kosmaczewski 2009
//

#import "UISegmentedControlProcessor.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSNumber+Nib2ObjcExtensions.h"

@implementation UISegmentedControlProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UISegmentedControl";
}

- (NSString *)constructorString
{   //TODO: Create Localized strings
    NSString *items = [[self.input objectForKey:@"segmentTitles"] componentsJoinedByString:@"\", @\""];
    return [NSString stringWithFormat:@"[[%@ alloc] initWithItems:[NSArray arrayWithObjects:%@, nil]]", [self getProcessedClassName], [items quotedAsCodeString]];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"segmentControlStyle"])
    {
        [output setObject:[OGInstruction initWithString:[value segmentedControlStyleString]] forKey:@"segmentedControlStyle"];
    }
    else if ([item isEqualToString:@"selectedSegmentIndex"])
    {
        [output setObject:[OGInstruction initWithString:[value intString]] forKey:item];
    }
    else if ([item isEqualToString:@"momentary"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
