//
//  ViewController.m
//  BmobSample
//
//  Created by 胡斌 on 2017/7/27.
//  Copyright © 2017年 胡斌. All rights reserved.
//

#import "ViewController.h"

#import <BmobSDK/Bmob.h>

@interface ViewController ()
- (IBAction)createRecord:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)createRecord:(id)sender {
    //往GameScore表添加一条playerName为小明，分数为78的数据
    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
    [gameScore setObject:@"小明" forKey:@"playerName"];
    [gameScore setObject:@78 forKey:@"score"];
    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
    }];
}
@end
