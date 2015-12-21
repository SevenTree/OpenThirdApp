//
//  ViewController.m
//  OPenThirdApp
//
//  Created by Tree on 15/12/18.
//  Copyright © 2015年 Tree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UILabel * messageLabel;
@property (nonatomic,strong) UIWebView * webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#warning 随便找一个可以运行的工程，在一个点击事件中实现下面注释的代码，即可成功吊起这个App
    /*
     //    判断手机上是否存在OpenThirdApp的应用  记得一定要再本应用中添加白名单，切记切记,否则会报下面的错误
     //-canOpenURL: failed for URL: "ThisIsOpenUrlSchemes://" - error: "This app is not allowed to query for scheme ThisIsOpenUrlSchemes" 报错
     
     附：
     添加白名单：在info.plist中新建 LSApplicationQueriesSchemes （Array类型），然后新建item，写上本应用的 URL Schemes（ThisIsOpenUrlSchemes）即可

     附上吊起代码如下：
    
     BOOL isCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ThisIsOpenUrlSchemes://"]];
     NSLog(@"isCanOpenUrl= : %d",isCanOpenUrl);
     if (isCanOpenUrl) {
     [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"ThisIsOpenUrlSchemes://?http://weibo.com/5704843494/profile?topnav=1&amp;wvr=6"]];
     }

     */
    
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 300)];
    self.messageLabel.textColor = [UIColor purpleColor];
    self.messageLabel.backgroundColor = [UIColor greenColor];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.messageLabel];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 350, 414, 250)];
    self.webView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_webView];
    
    //被第三方应用打开的通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveThirdAppOpenTheApp:) name:@"receiveThirdAppOpenTheApp" object:nil];
}
- (void)receiveThirdAppOpenTheApp:(NSNotification *)notification {
    NSLog(@"通知内容是：%@\n通知名字是：%@\n发通知的类名字是：%@",notification.userInfo,notification.name,notification.object);
    
    NSString * messageString = [NSString stringWithFormat:@"Calling Application Bundle ID: %@\n\n URL scheme: %@ \n\n URL query: %@ \n\n URL : %@",notification.userInfo[@"sourceApplication"],notification.userInfo[@"urlScheme"],notification.userInfo[@"urlQuery"],notification.userInfo[@"url"]];
    self.messageLabel.text = messageString;
    
    NSString * urlQuery = [NSString stringWithFormat:@"%@",notification.userInfo[@"urlQuery"]];
    NSURL * url = [NSURL URLWithString:urlQuery];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"receiveThirdAppOpenTheApp" object:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
