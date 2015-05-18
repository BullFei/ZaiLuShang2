//
//  LoginVC.m
//  ZaiLuShang2
//
//  Created by gaocaixin on 15/5/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LoginVC.h"
#import "RequestTool.h"

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
@property (weak, nonatomic) IBOutlet UIImageView *loadImageView;
@property (weak, nonatomic) IBOutlet UIButton *yanzhengBtn;
- (IBAction)yanzhengClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengTextField;

@property (nonatomic ,strong) NSTimer *time;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end


@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)setUp
{
    [self.loginBtn setBackgroundImage:[[UIImage imageNamed:@"button_blue.9.png"] stretchableImageWithLeftCapWidth:self.loginBtn.currentBackgroundImage.size.width/2 topCapHeight:self.loginBtn.currentBackgroundImage.size.height/2] forState:UIControlStateNormal];
    
    [self.resgistBtn setBackgroundImage:[[UIImage imageNamed:@"button_blue.9.png"] stretchableImageWithLeftCapWidth:self.resgistBtn.currentBackgroundImage.size.width/2 topCapHeight:self.resgistBtn.currentBackgroundImage.size.height/2] forState:UIControlStateNormal];
    
    [self.loginBtn setBackgroundImage:[[UIImage imageNamed:@"button_gray.9.png"] stretchableImageWithLeftCapWidth:self.loginBtn.currentBackgroundImage.size.width/2 topCapHeight:self.loginBtn.currentBackgroundImage.size.height/2] forState:UIControlStateDisabled];
    
    [self.resgistBtn setBackgroundImage:[[UIImage imageNamed:@"button_gray.9.png"] stretchableImageWithLeftCapWidth:self.resgistBtn.currentBackgroundImage.size.width/2 topCapHeight:self.resgistBtn.currentBackgroundImage.size.height/2] forState:UIControlStateDisabled];
    
    [self.yanzhengBtn setBackgroundImage:[[UIImage imageNamed:@"button_blue.9.png"] stretchableImageWithLeftCapWidth:self.yanzhengBtn.currentBackgroundImage.size.width/2 topCapHeight:self.yanzhengBtn.currentBackgroundImage.size.height/2] forState:UIControlStateNormal];
    
    [self.yanzhengBtn setBackgroundImage:[[UIImage imageNamed:@"button_gray.9.png"] stretchableImageWithLeftCapWidth:self.yanzhengBtn.currentBackgroundImage.size.width/2 topCapHeight:self.yanzhengBtn.currentBackgroundImage.size.height/2] forState:UIControlStateDisabled];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textFieldChannge:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.backBtn.backgroundColor = CXColorP(100, 100, 100, 1);
    [self.backBtn setImage:[UIImage imageNamed:@"nav_back_48_white"] forState:UIControlStateNormal];
    self.backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn.layer.cornerRadius = 5;
    self.backBtn.layer.masksToBounds = YES;
    
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldChannge:(NSNotification *)nf
{
    self.loginBtn.enabled = self.countTextField.text.length > 0 && self.passWordTextField.text.length > 0;
    if (self.yanzhengTextField.hidden == NO) {
        self.loginBtn.enabled = NO;
    }
    self.resgistBtn.enabled = self.countTextField.text.length > 0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.countTextField) {
        if (textField.text.length != 11) {
            self.countLabel.text = @"请输入11位手机号码";
            [self addShockAnimation:self.countLabel];
        } else {
                    }
    }
    if (textField == self.passWordTextField) {
    }

}


- (void)addShockAnimation:(UIView *)view
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.translation.x";
    animation.values = @[@0,@10,@-10,@0];
    animation.repeatCount = 2;
    animation.duration = 0.2;
    [view.layer addAnimation:animation forKey:@"1"];
}

- (void)addXuanZhuanAnimation:(UIView *)view
{
    if (view.layer.animationKeys.count > 0) {
        return;
    }
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI*2];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (IBAction)loginClick:(UIButton *)sender {
    
    if (self.countTextField.text.length != 11) {
        [self showshok:self.countTextField text:@"请输入11位手机号码"];
        return;
    } else if (self.passWordTextField.text.length <6 || self.passWordTextField.text.length >11) {
        [self showshok:self.passWordTextField text:@"请输入6-11位密码"];
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"username"] = self.countTextField.text;
    dict[@"v"] = @"a6.1.0";
    dict[@"androidToken"] = @"cfc713fd95b69b";
    dict[@"vc"] = @"anzhuo";
    dict[@"submit"] = @"login";
    dict[@"token"] = @"";
    dict[@"password"] = self.passWordTextField.text;
    dict[@"vd"] = @"f7393db54aeaedec";
    
    [RequestTool POST:@"http://app6.117go.com/demo27/php/loginAction.php" parameters:dict success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        self.countLabel.text = responseObject[@"msg"];
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)resgistClick:(UIButton *)sender {
    if (self.yanzhengBtn.hidden == YES) {
        self.yanzhengBtn.hidden = NO;
        self.yanzhengBtn.enabled = YES;
    } else {
        
    }
}

- (void)showshok:(UITextField*)view text:(NSString *)text
{
    [self addShockAnimation:view];
    [self addShockAnimation:self.countLabel];
    self.countLabel.text = text;
}

- (IBAction)secureClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passWordTextField.secureTextEntry = !sender.selected;
}
- (IBAction)yanzhengClick:(UIButton *)sender {
    
    [self addXuanZhuanAnimation:self.loadImageView];
    self.loadImageView.hidden = NO;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"phonecode"] = @"86";
    dict[@"v"] = @"a6.1.0";
    dict[@"vd"] = @"f7393db54aeaedec";
    dict[@"vc"] = @"anzhuo";
    dict[@"submit"] = @"getMobileCode";
    dict[@"token"] = @"";
    dict[@"mobile"] = self.countTextField.text;
    
    [RequestTool POST:@"http://app6.117go.com/demo27/php/loginAction.php" parameters:dict success:^(id responseObject) {
        self.countLabel.text = responseObject[@"msg"];
        [self.loadImageView.layer removeAllAnimations];
        [self.loadImageView setHidden:YES];
        
        if ([self.countLabel.text isEqualToString:@"sent"]) {
            self.yanzhengTextField.hidden = NO;
            self.yanzhengBtn.enabled = NO;
            [self.yanzhengBtn setTitle:@"稍后重发" forState:UIControlStateDisabled];
            self.time.fireDate = [NSDate distantPast];
            self.loginBtn.enabled = NO;
        }
        NSLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        
    }];

    
}

- (NSTimer *)time
{
    if (_time == nil) {
        _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshYanzheng) userInfo:nil repeats:YES];
        _time.fireDate = [NSDate distantFuture];
    }
    return _time;
}

- (void)refreshYanzheng
{
    static int i = 61;
    i--;
    [self.yanzhengBtn setTitle:[NSString stringWithFormat:@"%d秒后重发",i] forState:UIControlStateDisabled];
    
    if (i == 0) {
        self.time.fireDate = [NSDate distantFuture];
        self.yanzhengBtn.enabled = YES;
        i = 61;
    }
}

@end
