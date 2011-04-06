//
//  UITableViewCellProcessor.m
//  nib2objc
//
//  Created by Adrian on 3/16/09.
//  Adrian Kosmaczewski 2009
//

#import "UITableViewCellProcessor.h"
#import "NSNumber+Nib2ObjcExtensions.h"
#import "NSString+Nib2ObjcExtensions.h"
#import "NSDictionary+Nib2ObjcExtensions.h"

@implementation UITableViewCellProcessor

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)getProcessedClassName
{
    return @"UITableViewCell";
}

- (NSString *)constructorString
{
    NSString *reuseIdentifier = [[self.input objectForKey:@"reuseIdentifier"] quotedAsCodeString];
    if (reuseIdentifier == nil)
    {
        reuseIdentifier = @"@\"UITableViewCellReuseIdentifier\"";
    }
    return [NSString stringWithFormat:@"[[%@ alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:%@]", [self getProcessedClassName], reuseIdentifier];
}

- (void)processKey:(id)item value:(id)value
{
    if ([item isEqualToString:@"textAlignment"])
    {
        [output setObject:[OGInstruction initWithString:[value textAlignmentString]] forKey:@"textLabel.textAlignment"];
        [output setObject:[OGInstruction initWithString:[value textAlignmentString]] forKey:@"detailTextLabel.textAlignment"];
    }
    else if ([item isEqualToString:@"lineBreakMode"])
    {
        [output setObject:[OGInstruction initWithString:[value lineBreakModeString]] forKey:@"textLabel.lineBreakMode"];
        [output setObject:[OGInstruction initWithString:[value lineBreakModeString]] forKey:@"detailTextLabel.lineBreakMode"];
    }
    else if ([item isEqualToString:@"textColor"])
    {
        [output setObject:[OGInstruction initWithString:[value colorString]] forKey:@"textLabel.textColor"];
        [output setObject:[OGInstruction initWithString:[value colorString]] forKey:@"detailTextLabel.textColor"];
    }
    else if ([item isEqualToString:@"selectedTextColor"])
    {
        [output setObject:[OGInstruction initWithString:[value colorString]] forKey:@"textLabel.highlightedTextColor"];
        [output setObject:[OGInstruction initWithString:[value colorString]] forKey:@"detailTextLabel.highlightedTextColor"];
    }
    else if ([item isEqualToString:@"font"])
    {
        [output setObject:[OGInstruction initWithString:[value fontString]] forKey:@"textLabel.font"];
        [output setObject:[OGInstruction initWithString:[value fontString]] forKey:@"detailTextLabel.font"];
    }
    else if ([item isEqualToString:@"showsReorderControl"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"shouldIndentWhileEditing"])
    {
        [output setObject:[OGInstruction initWithString:[value booleanString]] forKey:item];
    }
    else if ([item isEqualToString:@"indentationWidth"])
    {
        [output setObject:[OGInstruction initWithString:[value floatString]] forKey:item];
    }
    else if ([item isEqualToString:@"indentationLevel"])
    {
        [output setObject:[OGInstruction initWithString:[value intString]] forKey:item];
    }
    else if ([item isEqualToString:@"accessoryType"])
    {
        [output setObject:[OGInstruction initWithString:[value tableViewCellAccessoryString]] forKey:item];
    }
    else if ([item isEqualToString:@"editingAccessoryType"])
    {
        [output setObject:[OGInstruction initWithString:[value tableViewCellAccessoryString]] forKey:item];
    }
    else if ([item isEqualToString:@"selectionStyle"])
    {
        [output setObject:[OGInstruction initWithString:[value tableViewCellSelectionStyleString]] forKey:item];
    }
    else
    {
        [super processKey:item value:value];
    }
}

@end
