//
//  WJ_PickerView.h
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/9.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJ_PickerView : UIView

// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;


//
@property (nonatomic, strong) UIWindow *maskWindow;


// 顶部视图
@property (nonatomic, strong) UIView *topView;
// 左边取消按钮
@property (nonatomic, strong) UIButton *cancelButton;
// 右边确定按钮
@property (nonatomic, strong) UIButton *defaultButton;
// 分割线
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, copy) void(^dismissWithAnimation)(NSString *string);

@end
