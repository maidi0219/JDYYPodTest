//
//  JDYYViewController.m
//  JDYYPodTest
//
//  Created by 784920085@qq.com on 12/16/2021.
//  Copyright (c) 2021 784920085@qq.com. All rights reserved.
//

#import "JDYYViewController.h"
#import "NSString+Extention.h"
#import "NMannager.h"

@interface JDYYViewController ()

@end

@implementation JDYYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *str = [NSString hmacSHA256WithSecret:@"jkdhfjkj$^@&&*&!" content:@"hello world"];
    NSLog(@"%@",str);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
