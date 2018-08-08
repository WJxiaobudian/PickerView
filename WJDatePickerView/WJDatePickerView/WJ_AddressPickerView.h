//
//  WJ_AddressPickerView.h
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/8.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WJDateResultBlock) (NSString *selectValue);

@interface WJ_AddressPickerView : UIView

- (void)showWithAnimation:(BOOL)animation;

- (instancetype)initWithNum:(NSInteger)num title:(NSString *)title result:(WJDateResultBlock)resultValue;

@end
