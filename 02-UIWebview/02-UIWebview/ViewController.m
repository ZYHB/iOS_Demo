//
//  ViewController.m
//  02-UIWebview
//
//  Created by Fengtf on 15/7/14.
//  Copyright (c) 2015年 rrmj. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UIWebViewDelegate >
@property (nonatomic,weak)UIWebView * webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWebView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏
}

#pragma - mark  进入全屏
-(void)begainFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
}
#pragma - mark 退出全屏
-(void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

/**
 *  初始化webView
 */
-(void)initWebView{
    UIWebView *webView = [[UIWebView alloc]init];
    self.webView = webView;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    webView.delegate = self;
    
    self.webView.mediaPlaybackRequiresUserAction = YES;
    //http://tv.sohu.com/20150713/n416636681.shtml
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://www.iqiyi.com/v_19rron8psw.html?src=focustext_2_20130410_1#curid=378627300_481ef4234d04240f8e3526ba4d503a1d"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
