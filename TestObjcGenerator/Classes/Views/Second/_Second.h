//
//  _Second.h
//  TestObjcGenerator
//
//  Created by Juan Cruz Ghigliani on 09-ABR-2011.
//  Copyright 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _Second : UIViewController  {
	UIView *uiview1;
UILabel *lblSecondViewTitle;
UIButton *btnCloseSecondView;

}
@property (nonatomic,retain) IBOutlet UIView *uiview1;
@property (nonatomic,retain) IBOutlet UILabel *lblSecondViewTitle;
@property (nonatomic,retain) IBOutlet UIButton *btnCloseSecondView;


@end
