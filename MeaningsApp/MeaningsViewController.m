//
//  ViewController.m
//  MeaningsApp
//
//  Created by Amol Gaikwad on 2/23/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

#import "MeaningsViewController.h"
#import "DataProvider.h"
#import "MBProgressHUD.h"

@interface MeaningsViewController ()

@property (nonatomic, strong) NSMutableArray *meaningsArray;
@property (weak, nonatomic) IBOutlet UITableView *meaningsTableView;
@property (nonatomic, strong) NSArray *objectsArray;

@end

@implementation MeaningsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Make self the delegate and datasource of the table view.
    self.meaningsTableView.delegate = self;
    self.meaningsTableView.dataSource = self;
    self.inputTextField.delegate = self;
    
    // Initially hide the table view.
    self.meaningsTableView.hidden = YES;
}




#pragma mark - Private method implementation

- (IBAction)didTapOnGoButton:(id)sender
{
    if (_inputTextField.text && _inputTextField.text.length > 0)
    {
        [self getMeaningswithInput:_inputTextField.text];
    }
    else
    {
        //MARK : TO DO
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_inputTextField resignFirstResponder];
}

- (void)getMeaningswithInput:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Prepare the URL that we'll get the meanings data from server.
    NSString *URLString = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@", text];
    NSLog(@"URLString : %@", URLString);
    NSURL *url = [NSURL URLWithString:URLString];
    
    [DataProvider downloadDataFromURL:url withCompletionHandler:^(NSData *data) {
        
        // Check if any data returned.
        if (data != nil) {
            // Convert the returned data into a dictionary.
            NSError *error;
            NSMutableArray *returnedArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error != nil)
            {
                NSLog(@"%@", [error localizedDescription]);
            }
            else{
                
                if (returnedArray == nil || returnedArray.count == 0)
                {
                    NSLog(@"Error");
                }
                else
                {
                    _objectsArray = [[NSArray alloc] init];
                    _objectsArray =   [[[returnedArray objectAtIndex:0] valueForKey:@"lfs"] valueForKey:@"lf"];
                    NSLog(@"_objectsArray = %@", _objectsArray);
                    _meaningsArray = [[NSMutableArray alloc] init];
                    for (NSString *item in _objectsArray) {
                        NSLog(@"Item : %@", item);
                        [_meaningsArray addObject:item];
                    }
                    
                    // Reload the table view.
                    [self.meaningsTableView reloadData];
                    
                    _inputTextField.text = @"";
                    
                    // Show the table view.
                    self.meaningsTableView.hidden = NO;
                }
            }
            //[hud hideAnimated:YES];
        }
        [hud hideAnimated:YES];
        
    }];
}

#pragma mark - UITextField method implementation

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == _inputTextField)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITableView method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _meaningsArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _meaningsArray[indexPath.row];
    return cell;
}
















@end
