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
- (IBAction)queryRecord:(id)sender;

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
//    [gameScore setObject:@"小明" forKey:@"playerName"];
//    [gameScore setObject:@78 forKey:@"score"];
//    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    //设置playerName列的值为小黑和age列的值18
    NSDictionary *dic = @{@"playerName":@"小黑",@"score":@18};
    [gameScore saveAllWithDictionary:dic];
    
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            //创建对象成功，打印对象值
            NSLog(@"%@",gameScore);
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error.localizedDescription);
        } else {
            NSLog(@"Unknow error");
        }
    }];
}

- (IBAction)queryRecord:(id)sender {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    // 添加playerName不是小明的约束条件
    [bquery whereKey:@"playerName" equalTo:@"小明"];
//    [bquery whereKey:@"age" greaterThan:[NSNumber numberWithInt:18]]; //age大于18
//    [bquery whereKey:@"playerName" containedIn:[NSArray arrayWithObjects:@"小明",@"小红",@"小白", nil]];
//    //查询score列中值等于5且姓名为Mike的数据
//    NSArray *array =  @[@{@"score":@5},@{@"name":@"Mike"}];
//    [bquery addTheConstraintByAndOperationWithArray:array];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //打印playerName
            NSLog(@"%@", [obj objectForKey:@"playerName"]);
            NSLog(@"%@", [obj objectForKey:@"cheatMode"]);
            NSLog(@"%@", [obj objectForKey:@"score"]);
        }
    }];
    NSLog(@"%@",bquery);
}



@end
