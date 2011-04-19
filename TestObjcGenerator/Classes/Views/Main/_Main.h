//
//  _Main.h
//  
//
//  Created by  on .
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _Main : UIViewController  {
	UIView *uiview1;
UILabel *lblMainViewTitle;
UIButton *btnOpenSecondView;

}
@property (nonatomic,retain) IBOutlet UIView *uiview1;
@property (nonatomic,retain) IBOutlet UILabel *lblMainViewTitle;
@property (nonatomic,retain) IBOutlet UIButton *btnOpenSecondView;


@end
