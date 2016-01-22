//
//  SecondViewController.m
//  MCDemo
//
//  Created by Gabriel Theodoropoulos on 1/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userCounter;
@property (weak, nonatomic) IBOutlet UILabel *winnerName;
@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{

}

#pragma mark - Private method implementation

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",[NSString stringWithFormat:@"Server Received from %@ data:\n%@\n\n", peerDisplayName, receivedText]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([self.winnerName.text length] == 0)
        {
            self.winnerName.text = peerDisplayName;
            //update UI in main thread.
            self.view.backgroundColor = [UIColor colorWithRed:(1) green:(0) blue:(0) alpha:1.0];
            
            //TODO: play sound
            AudioServicesPlaySystemSound (1005);
        }
        
    });
}
- (IBAction)Reset:(UIButton *)sender {
    self.view.backgroundColor = [UIColor colorWithRed:(0) green:(1) blue:(0) alpha:1.0];
    self.winnerName.text = @"";
}

#pragma mark - UITableView Delegate and Datasource method implementation


@end
