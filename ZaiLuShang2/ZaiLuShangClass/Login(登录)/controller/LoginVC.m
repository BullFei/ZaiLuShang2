//
//  LoginVC.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *resgistBtn;
@property (weak, nonatomic) IBOutlet UIButton *secureBtn;
- (IBAction)loginClick:(UIButton *)sender;
- (IBAction)resgistClick:(UIButton *)sender;
- (IBAction)secureClick:(UIButton *)sender;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.countTextField) {
        NSLog(@"1");
    }
    if (textField == self.passWordTextField) {
        NSLog(@"2");
    }
}

- (IBAction)loginClick:(UIButton *)sender {
    
}

- (IBAction)resgistClick:(UIButton *)sender {
}

- (IBAction)secureClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passWordTextField.secureTextEntry = !sender.selected;
}
@end
