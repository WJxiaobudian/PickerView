//
//  WJ_PickerView.m
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/9.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import "WJ_PickerView.h"

#define kScreenWidth self.frame.size.width
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface WJ_PickerView()


@end

@implementation WJ_PickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topView];
        [self addSubview:self.cancelButton];
        [self addSubview:self.defaultButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
    }
    return self;
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


- (void)cancelButton:(UIButton *)sender {
    if (_dismissWithAnimation) {
        _dismissWithAnimation(@"0");
    }
}

- (void)defaultButton:(UIButton *)sender {
    if (_dismissWithAnimation) {
        _dismissWithAnimation(@"1");
    }
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
@end
