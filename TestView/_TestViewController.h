//
//  _TestViewController.h
//  exampleProject
//
//  Created by JuanCruzGhigliani on 02/04/11.
//  Copyright 2011 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _TestViewController : UIViewController  {
	UIView *uiview1;
UIButton *btnMainAction;
UILabel *lblOutput;
UITextField *tfInput;

}
@property (nonatomic,retain) IBOutlet UIView *uiview1;
@property (nonatomic,retain) IBOutlet UIButton *btnMainAction;
@property (nonatomic,retain) IBOutlet UILabel *lblOutput;
@property (nonatomic,retain) IBOutlet UITextField *tfInput;


@end
