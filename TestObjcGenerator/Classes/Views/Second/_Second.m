//
//  _Second.m
//  TestObjcGenerator
//
//  Created by Juan Cruz Ghigliani on 09-ABR-2011.
//  Copyright 2011 Personal. All rights reserved.
//

#import  "_Second.h"

@implementation _Second

@synthesize uiview1;
@synthesize lblSecondViewTitle;
@synthesize btnCloseSecondView;


- (id)init{
if ((self = [super init])) {
uiview1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
uiview1.frame = CGRectMake(0.0, 0.0, 320.0, 460.0);
uiview1.multipleTouchEnabled = NO;
uiview1.autoresizesSubviews = YES;
uiview1.opaque = YES;
uiview1.backgroundColor = [UIColor colorWithWhite:0.500 alpha:1.000];
uiview1.clearsContextBeforeDrawing = YES;
uiview1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
uiview1.contentMode = UIViewContentModeScaleToFill;
uiview1.tag = 0;
uiview1.alpha = 1.000;
uiview1.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
uiview1.hidden = NO;
uiview1.clipsToBounds = NO;
uiview1.userInteractionEnabled = YES;

lblSecondViewTitle = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 20.0, 280.0, 21.0)];
lblSecondViewTitle.frame = CGRectMake(20.0, 20.0, 280.0, 21.0);
lblSecondViewTitle.opaque = NO;
lblSecondViewTitle.highlightedTextColor = [UIColor colorWithWhite:1.000 alpha:1.000];
lblSecondViewTitle.hidden = NO;
lblSecondViewTitle.autoresizesSubviews = YES;
lblSecondViewTitle.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000];
lblSecondViewTitle.clipsToBounds = YES;
lblSecondViewTitle.minimumFontSize = 10.000;
lblSecondViewTitle.userInteractionEnabled = NO;
lblSecondViewTitle.tag = 0;
lblSecondViewTitle.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
lblSecondViewTitle.textAlignment = UITextAlignmentCenter;
lblSecondViewTitle.adjustsFontSizeToFitWidth = YES;
lblSecondViewTitle.lineBreakMode = UILineBreakModeTailTruncation;
lblSecondViewTitle.font = [UIFont fontWithName:@"Helvetica" size:17.000];
lblSecondViewTitle.alpha = 1.000;
lblSecondViewTitle.clearsContextBeforeDrawing = YES;
lblSecondViewTitle.contentMode = UIViewContentModeLeft;
lblSecondViewTitle.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
lblSecondViewTitle.multipleTouchEnabled = NO;
lblSecondViewTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
lblSecondViewTitle.text = NSLocalizedString(@"This is Other View (nib-less)",@"This is Other View (nib-less)");
lblSecondViewTitle.enabled = YES;
lblSecondViewTitle.shadowOffset = CGSizeMake(0.0, -1.0);
lblSecondViewTitle.numberOfLines = 1;
[uiview1 addSubview:lblSecondViewTitle];

btnCloseSecondView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
btnCloseSecondView.frame = CGRectMake(20.0, 85.0, 280.0, 37.0);
btnCloseSecondView.opaque = NO;
btnCloseSecondView.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.000];
btnCloseSecondView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
btnCloseSecondView.reversesTitleShadowWhenHighlighted = NO;
btnCloseSecondView.hidden = NO;
btnCloseSecondView.clipsToBounds = NO;
btnCloseSecondView.autoresizesSubviews = YES;
btnCloseSecondView.adjustsImageWhenDisabled = YES;
btnCloseSecondView.userInteractionEnabled = YES;
btnCloseSecondView.tag = 0;
btnCloseSecondView.highlighted = NO;
btnCloseSecondView.alpha = 1.000;
btnCloseSecondView.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
btnCloseSecondView.multipleTouchEnabled = NO;
btnCloseSecondView.clearsContextBeforeDrawing = YES;
btnCloseSecondView.selected = NO;
btnCloseSecondView.contentMode = UIViewContentModeScaleToFill;
btnCloseSecondView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
btnCloseSecondView.showsTouchWhenHighlighted = NO;
btnCloseSecondView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
btnCloseSecondView.adjustsImageWhenHighlighted = YES;
btnCloseSecondView.titleLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
btnCloseSecondView.enabled = YES;
btnCloseSecondView.titleLabel.shadowOffset = CGSizeMake(0.0, 0.0);
[btnCloseSecondView setTitleColor:[UIColor colorWithRed:0.196 green:0.310 blue:0.522 alpha:1.000] forState:UIControlStateNormal];
[btnCloseSecondView setTitleShadowColor:[UIColor colorWithWhite:0.500 alpha:1.000] forState:UIControlStateNormal];
[btnCloseSecondView setTitle:NSLocalizedString(@"Tap to close",@"Tap to close") forState:UIControlStateNormal];
[btnCloseSecondView setTitleColor:[UIColor colorWithWhite:1.000 alpha:1.000] forState:UIControlStateHighlighted];
[uiview1 addSubview:btnCloseSecondView];


}
return self;
}


- (void)dealloc {
self.uiview1 = nil;
self.lblSecondViewTitle = nil;
self.btnCloseSecondView = nil;

[super dealloc];
}

@end
