//
//  WJ_AddressPickerView.m
//  WJDatePickerView
//
//  Created by 王洁 on 2018/8/8.
//  Copyright © 2018年 王洁. All rights reserved.
//

#import "WJ_AddressPickerView.h"
#import "ProvinceModel.h"
#import "WJ_PickerView.h"

#define kScreenWidth self.frame.size.width
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface WJ_AddressPickerView()<UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *_title;
    
    NSString *_provinceStr;
    NSString *_provinceCode;
    
    NSString *_cityStr;
    NSString *_cityCode;
    
    NSString *_areaStr;
    NSString *_areaCode;
    
    WJDateResultBlock _resultBlock;
    NSInteger _num;
    
    UIPickerView *_pickerView;
    NSDictionary *_areaDic;
    NSMutableArray *_provinceArr;
}

// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) WJ_PickerView *alertView;
//
@property (nonatomic, strong) UIWindow *maskWindow;

@end

@implementation WJ_AddressPickerView

- (void)initSubView {
    self.frame = UIScreen.mainScreen.bounds;
    [self addSubview:self.backgroundView];
    [self addSubview:self.alertView];
    self.alertView.titleLabel.text = _title;
    __block typeof(self) weakSelf = self;
    self.alertView.dismissWithAnimation = ^(NSString *string) {
        [weakSelf dismissWithAnimation:YES];
        if ([string isEqualToString:@"1"]) {
            [weakSelf defaultButton:nil];
        }
    };
    [self.alertView addSubview:self.pickerView];
}

- (instancetype)initWithNum:(NSInteger)num title:(NSString *)title result:(WJDateResultBlock)resultValue {
    _title = title;
    _num = num;
    if (self = [super init]) {
        [self initSubView];
        [self prepareData];
        _resultBlock = resultValue;
    }
    return self;
}

- (void)prepareData {
    //area.plist是字典
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    _areaDic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
    //city.plist是数组
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *dataCity = [[NSMutableArray alloc] initWithContentsOfFile:plist];
    
    _provinceArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataCity) {
        ProvinceModel *model  = [[ProvinceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        model.citiesArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in model.cities) {
            CityModel *cityModel = [[CityModel alloc]init];
            [cityModel setValuesForKeysWithDictionary:dic];
            [model.citiesArr addObject:cityModel];
        }
        [_provinceArr addObject:model];
    }
}

- (void)didTapBackgroundView:(UITapGestureRecognizer *)tap {
    [self dismissWithAnimation:YES];
}

- (void)defaultButton:(UIButton *)sender {
    NSString *string = [NSString stringWithFormat:@"%@ -- %@ --- %@ --- %@ --- %@ --- %@",_provinceStr, _provinceCode, _cityStr, _cityCode, _areaStr, _areaCode];
    if (_resultBlock) {
        _resultBlock(string);
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _num;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == component) {
        return _provinceArr.count;
    } else if(1==component) {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model =   _provinceArr[rowProvince];
        return model.citiesArr.count;
    } else {
        NSArray *arr =  _areaDic[[self componentString]];
        return arr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == component) {
        ProvinceModel *model = _provinceArr[row];
        return model.name;
    } else if(1==component)  {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[row];
        return cityModel.name;
    } else {
        
        NSArray *arr = _areaDic[[self componentString]];
        AreaModel *areaModel = [[AreaModel alloc]init];
        [areaModel setValuesForKeysWithDictionary:arr[row]];
        return areaModel.name;
    }
}

- (NSString *)componentString {
    NSInteger rowProvince = [_pickerView selectedRowInComponent:0];
    NSInteger rowCity = [_pickerView selectedRowInComponent:1];
    ProvinceModel *model = _provinceArr[rowProvince];
    CityModel *cityModel = model.citiesArr[rowCity];
    NSString *str = [cityModel.code description];
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(0 == component) {
        [pickerView reloadComponent:1];
        if (_num >2) {
            [pickerView reloadComponent:2];
        }
    } else if(1 == component) {
        if (_num >2) {
            [pickerView reloadComponent:2];
            
        }
    }
    
    NSInteger selectOne = [pickerView selectedRowInComponent:0];
    ProvinceModel *model = _provinceArr[selectOne];
    _provinceStr = model.name;
    _provinceCode = model.code;
    
    NSInteger selectTwo = [pickerView selectedRowInComponent:1];
    CityModel *cityModel = model.citiesArr[selectTwo];
    _cityStr = cityModel.name;
    _cityCode = cityModel.code;
    if (_num > 2) {
        NSInteger selectThree = [pickerView selectedRowInComponent:2];
        NSString *str = [cityModel.code description];
        NSArray *arr = _areaDic[str];
        AreaModel *areaModel = [[AreaModel alloc]init];
        [areaModel setValuesForKeysWithDictionary:arr[selectThree]];
        _areaStr = areaModel.name;
        _areaCode = areaModel.code;
    }
   
    NSString *string = [NSString stringWithFormat:@"%@ -- %@ --- %@ --- %@ --- %@ --- %@",_provinceStr, _provinceCode, _cityStr, _cityCode, _areaStr, _areaCode];
    if (_resultBlock) {
        _resultBlock(string);
    }
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

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [_pickerView selectRow:0 inComponent:0 animated:YES];
        
    }
    return _pickerView;
}

@end
