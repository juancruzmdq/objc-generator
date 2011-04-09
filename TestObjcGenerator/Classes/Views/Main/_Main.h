//
//  _Main.h
//  TestObjcGenerator
//
//  Created by Juan Cruz Ghigliani on 09-ABR-2011.
//  Copyright 2011 Personal. All rights reserved.
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
