//
//  ViewController.h
//  MeaningsApp
//
//  Created by Amol Gaikwad on 2/23/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MeaningsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

- (IBAction)didTapOnGoButton:(id)sender;


@end

