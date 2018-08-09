//
//  WJ_datePickerView.m
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/8.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import "WJ_datePickerView.h"
#import "NSDate+Expend.h"
#import "WJ_PickerView.h"
#define kScreenWidth self.frame.size.width
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface WJ_datePickerView() {
    
    NSString *_title;
    NSString *_minDateStr;
    NSString *_maxDateStr;
    NSString *_selectValue;
    WJDateResultBlock _resultBlock;
}

// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) WJ_PickerView *alertView;
// 时间选择器
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation WJ_datePickerView

- (void)initSubView {
    
    self.frame = UIScreen.mainScreen.bounds;
    [self addSubview:self.backgroundView];
    [self addSubview:self.alertView];
    __weak typeof(self) weakSelf = self;
    self.alertView.dismissWithAnimation = ^(NSString *string) {
        [weakSelf dismissWithAnimation:YES];
        if ([string isEqualToString:@"1"]) {
            [weakSelf didSelectValueChanged:_datePicker];
        }
    };
    
    self.alertView.titleLabel.text = _title;
    [self.alertView addSubview:self.datePicker];
}

- (void)didTapBackgroundView:(UITapGestureRecognizer *)tap {
    [self dismissWithAnimation:YES];
}

- (void)showWithAnimation:(BOOL)animation {

    [[self frontWindow] addSubview:self];
    if (animation) {
        CGRect rect = self.alertView.frame;
        rect.origin.y = UIScreen.mainScreen.bounds.size.height;
        self.alertView.frame = rect;

        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= 250;
            self.alertView.frame = rect;
        } completion:nil];
    }
}

- (void)dismissWithAnimation:(BOOL)animation {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += 250;
        self.alertView.frame = rect;
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertView.maskWindow = nil;
        self.alertView.maskWindow.hidden = YES;
    }];
}

- (UIWindow *)frontWindow {
    return [UIApplication sharedApplication].delegate.window;
}

- (void)didSelectValueChanged:(UIDatePicker *)sender {
    // 读取日期：datePicker.date
    _selectValue = [self toStringWithDate:sender.date];
    NSLog(@"滚动完成后，执行block回调:%@", _selectValue);

    if (_resultBlock) {
        _resultBlock(_selectValue);
    }
}

- (instancetype)initWithTitle:(NSString *)title startDate:(NSString *)startDate endDate:(NSString *)endDate resultBlock:(WJDateResultBlock)resultBlock {
    if (self = [super init]) {
        _title = title;
        // 默认为当前时间
        _selectValue = [self toStringWithDate:[NSDate date]];
        if (!(startDate == nil || [startDate isEqualToString:@""] || startDate.length < 1)) {
            _minDateStr = startDate;
            if ([NSDate compareDate:_selectValue bDate:startDate] == 1) {
                _selectValue = startDate;
            }
        } else {
            _minDateStr = nil; // 无限大
        }
        
        if (!(endDate == nil || [endDate isEqualToString:@""] || endDate.length < 1)) {
            _maxDateStr = endDate;
        } else {
            _maxDateStr = nil; // 无限大
        }
        _resultBlock = resultBlock;
        [self initSubView];
    }
    return  self;
}

#pragma mark ------ 背景视图
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

#pragma mark ------ 弹出视图
- (WJ_PickerView *)alertView {
    if (!_alertView) {
        _alertView = [[WJ_PickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CHS_CN"];
        if (_minDateStr) {
            NSDate *minDate = [self toDateWithString:_minDateStr];
            _datePicker.minimumDate = minDate;
        } else {
            _datePicker.minimumDate = nil;
        }
        if (_maxDateStr) {
            NSDate *maxDate = [self toDateWithString:_maxDateStr];
            _datePicker.maximumDate = maxDate;
        } else {
            _datePicker.maximumDate = nil;
        }
        
        [_datePicker setDate:[self toDateWithString:_selectValue] animated:YES];
        [_datePicker addTarget:self action:@selector(didSelectValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _datePicker;
}

- (NSString *)toStringWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSDate *)toDateWithString:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
    
}
@end
