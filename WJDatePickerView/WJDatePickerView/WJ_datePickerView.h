//
//  WJ_datePickerView.h
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/8.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WJDateResultBlock) (NSString *selectValue);

@interface WJ_datePickerView : UIView

// 时间选择器
- (instancetype)initWithTitle:(NSString *)title startDate:(NSString *)startDate endDate:(NSString *)endDate resultBlock:(WJDateResultBlock)resultBlock;

- (void)showWithAnimation:(BOOL)animation;


@end
