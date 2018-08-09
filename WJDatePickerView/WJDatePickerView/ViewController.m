//
//  ViewController.m
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/8.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import "ViewController.h"
#import "WJ_datePickerView.h"
#import "NSDate+Expend.h"
#import "WJ_AddressPickerView.h"
#import "WJ_PickerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 地区选择 省市县
- (IBAction)Address_Three:(id)sender {
    [self showAddressNum:3];
}

// 地区选择 省市
- (IBAction)Address_Two:(id)sender {
    
    [self showAddressNum:2];
}

- (void)showAddressNum:(NSInteger)num {
    WJ_AddressPickerView *pick = [[WJ_AddressPickerView alloc] initWithNum:num title:@"地区选择" result:^(NSString *selectValue) {
        NSLog(@"selectValue === %@",selectValue);
    }];
    [pick showWithAnimation:YES];
    NSLog(@"tap");
}

// 限制时间
- (IBAction)limitTime:(id)sender {
    
    NSArray *dateArray = [self getSettleDateLimit];
    [self showDatePicker:dateArray];
}

// 不限制时间
- (IBAction)noLimitTime:(id)sender {
    [self showDatePicker:nil];

}

- (void)showDatePicker:(NSArray *)array {
    WJ_datePickerView *pick =  [[WJ_datePickerView alloc] initWithTitle:@"123" startDate:array[0] endDate:array[1] resultBlock:^(NSString *selectValue) {
        NSLog(@"_selectValue === %@",selectValue);
    }];
    [pick showWithAnimation:YES];
}

- (NSArray *)getSettleDateLimit{
    NSString *minDateStr = @"";
    NSString *maxDateStr = @"";
    
    //最小日期为mow+1天
    NSDate *now = [NSDate nextDay:[NSDate date] Days:1];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSCalendar *f_calendar = [NSCalendar currentCalendar];
    NSDateComponents *f_components = [f_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSInteger f_day=[f_components day];
    if (f_day < 15) {
        minDateStr = nowStr;
        maxDateStr = [NSDate getMonthAppointDayWith:nowStr andDays:15];
        
    }else{
        
        //最大日期大约为30天
        NSDate *date = [NSDate nextDay:now Days:30];
        NSString *nextStr = [fmt stringFromDate:date];
        
        NSCalendar *l_calendar = [NSCalendar currentCalendar];
        NSDateComponents *l_components = [l_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
        
        NSInteger l_day=[l_components day];
        if (l_day < 15) {
            minDateStr = nowStr;
            maxDateStr = nextStr;
        }else{
            minDateStr = nowStr;
            maxDateStr = [NSDate getMonthAppointDayWith:nextStr andDays:15];
        }
    }
    
    return @[minDateStr,maxDateStr];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
