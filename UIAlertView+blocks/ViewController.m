//
//  ViewController.m
//  UIAlertView+blocks
//
//  Created by Akira Matsuda on 2013/11/07.
//  Copyright (c) 2013年 Akira Matsuda. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertView+blocks.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" selectedBlock:^(NSInteger index) {
		NSLog(@"index %d selected", index);
	} cancelButtonTitle:@"Cancel" otherButtonTitles:@"Other Button", nil];
	[alert show];
}

@end
