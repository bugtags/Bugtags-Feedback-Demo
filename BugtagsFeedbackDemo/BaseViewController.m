//
//  BaseViewController.m
//  BugtagsFeedbackDemo
//
//  Created by Stephen Zhang on 7/20/16.
//  Copyright © 2016 bugtags.com. All rights reserved.
//

#import "BaseViewController.h"
#import <Bugtags/Bugtags.h>

@interface BaseViewController () <UIAlertViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        BOOL enable = [prefs boolForKey:@"bugtags_shake_feedback_enabled"];
        if (!enable) return;
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请问需要反馈什么问题？"
                                                            message:@"你也可以在个人页的反馈帮助中心里找到这个功能"
                                                           delegate:self
                                                  cancelButtonTitle:@"没啥事"
                                                  otherButtonTitles:@"遇到问题", @"意见建议", @"关闭摇一摇反馈", nil];
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [Bugtags invoke];
        return;
    }
    
    if (buttonIndex == 2) {
        
        [Bugtags sendFeedback:@"也可以用 sendFeedback 接口实现一个用户反馈"];
        return;
    }
    
    if (buttonIndex == 3) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setBool:NO forKey:@"bugtags_shake_feedback_enabled"];
        [prefs synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
