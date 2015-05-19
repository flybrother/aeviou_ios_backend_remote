//
//  ViewController.m
//  aeviou_ios_backend
//
//  Created by Air on 3/22/15.
//  Copyright (c) 2015 fb corp. All rights reserved.
//

#import "ViewController.h"
#import "AIBackEnd.h"

@interface ViewController ()

@end

@implementation ViewController{
    UITextView *inputTextView;
    UITextView *outputTextView;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        UIView *demoUI = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        demoUI.backgroundColor = [UIColor greenColor];
        UITextView *inputView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 200, 250)];
        UITextView *outputView = [[UITextView alloc] initWithFrame:CGRectMake(10, 270, 200, 250)];
        inputTextView = inputView;
        inputTextView.delegate = self;
        [demoUI addSubview:inputTextView];
        

        outputTextView = outputView;
        [demoUI addSubview:outputTextView];
        UIButton *getWordList = [[UIButton alloc] initWithFrame:CGRectMake(220, 10, 100, 520)];
        [getWordList setTitle:@"  clear  " forState:UIControlStateNormal];
        getWordList.layer.borderWidth = 2;
        getWordList.layer.borderColor = [UIColor blueColor].CGColor;
        getWordList.layer.cornerRadius = 5;
        getWordList.backgroundColor = [UIColor yellowColor];
        getWordList.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [getWordList setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [getWordList addTarget:self action:@selector(clearInput) forControlEvents:UIControlEventTouchUpInside];
//        [getWordList sizeToFit];
        getWordList.titleLabel.adjustsFontSizeToFitWidth = YES;
//        UIViewController *demoUIVC = [[UIViewController alloc] init];
//        demoUIVC.view = demoUI;
        
        [demoUI addSubview:getWordList];
        self.view = demoUI;
//        demoV = demoUI;
        
//        self.window.rootViewController = demoUIVC;
        
    }
    return self;
}

-(void)getzz{
    NSString *inputText = inputTextView.text;
    AIBackEnd *aeviouBackend = [[AIBackEnd alloc] init];
    NSArray *pinyinList = [inputText componentsSeparatedByString:@" "];
    //    NSArray *test = [aeviouBackend getHanziArrayByPinyin:@[@"mei",@"guo"]];
    NSArray *test = [aeviouBackend getHanziArrayByPinyin:pinyinList];
    outputTextView.text = [test componentsJoinedByString:@"\n"];
}

-(void)clearInput{
    inputTextView.text = @"";
    outputTextView.text = @"";
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self getzz];
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
