//
//  WJ_datePickerView.m
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/8.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import "WJ_datePickerView.h"
#import "NSDate+Expend.h"
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
@property (nonatomic, strong) UIView *alertView;
// 顶部视图
@property (nonatomic, strong) UIView *topView;
// 左边取消按钮
@property (nonatomic, strong) UIButton *cancelButton;
// 右边确定按钮
@property (nonatomic, strong) UIButton *defaultButton;
// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;
// 分割线
@property (nonatomic, strong) UIView *lineView;
//
@property (nonatomic, strong) UIWindow *maskWindow;
// 时间选择器
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation WJ_datePickerView

- (void)initSubView {
    self.frame = UIScreen.mainScreen.bounds;
    [self addSubview:self.backgroundView];
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.topView];
    [self.alertView addSubview:self.cancelButton];
    [self.alertView addSubview:self.defaultButton];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.lineView];
    
    self.titleLabel.text = _title;
    [self.alertView addSubview:self.datePicker];
}


- (void)didTapBackgroundView:(UITapGestureRecognizer *)tap {
    [self dismissWithAnimation:YES];
}

- (void)cancelButton:(UIButton *)sender {
    [self dismissWithAnimation:YES];
}

- (void)defaultButton:(UIButton *)sender {
    [self dismissWithAnimation:YES];
    _selectValue = [self toStringWithDate:self.datePicker.date];
    if (_resultBlock) {
        _resultBlock(_selectValue);
    }
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
        self.maskWindow = nil;
        self.maskWindow.hidden = YES;
        
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
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

#pragma mark ------ 顶部视图
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _topView.backgroundColor = RGBA(255, 255, 255, 0);
    }
    return _topView;
}

#pragma mark ------ 左边取消按钮
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(20, 15, 40, 20);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}



#pragma mark ------ 右边确定按钮
- (UIButton *)defaultButton {
    if (!_defaultButton) {
        _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _defaultButton.frame = CGRectMake(kScreenWidth - 20 - 40, 15, 40, 20);
        [_defaultButton setTitle:@"完成" forState:UIControlStateNormal];
        [_defaultButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _defaultButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _defaultButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_defaultButton addTarget:self action:@selector(defaultButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultButton;
}


#pragma mark ------ 中间标题
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, kScreenWidth - 130, 50)];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark ------ 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, kScreenWidth, 0.5)];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIWindow *)maskWindow {
    if (!_maskWindow) {
        _maskWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _maskWindow.windowLevel = UIWindowLevelNormal + 10;
    }
    return _maskWindow;
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
