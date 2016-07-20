//
//  ViewController.m
//  BugtagsFeedbackDemo
//
//  Created by Stephen Zhang on 7/20/16.
//  Copyright © 2016 bugtags.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UISwitch *switchControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.switchControl.on = [prefs boolForKey:@"bugtags_shake_feedback_enabled"];
    
    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"bugtags_shake_feedback_enabled" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary *)aChange
                       context:(void *)aContext
{
    self.switchControl.on = [aChange[NSKeyValueChangeNewKey] boolValue];
}

- (IBAction)onSwitchChanged:(UISwitch *)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:sender.on forKey:@"bugtags_shake_feedback_enabled"];
    [prefs synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
