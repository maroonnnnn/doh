//
//  SetTempCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "SetTempCell.h"



@implementation SetTempCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //温度模式选择状态初始化
        _isSelect = YES;
        
//        [self setCButton];
//        [self setFButton];
    }
    return self;
}


- (void)setCButton{
    _CelsiusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _CelsiusButton.frame = CGRectMake(151, 35, 46, 30);
    _CelsiusButton.titleLabel.text = @"°C";
    _CelsiusButton.layer.cornerRadius = 10;
    
    //选中状态  边框与title改变颜色
    if (_isSelect) {
        _CelsiusButton.layer.borderColor = COLOR.CGColor;
        _CelsiusButton.titleLabel.textColor = COLOR;
    }else{
        _CelsiusButton.layer.borderColor = [UIColor blackColor].CGColor;
        _CelsiusButton.titleLabel.textColor = [UIColor blackColor];
    }
    
    _CelsiusButton.layer.borderWidth = 2;
    [_CelsiusButton addTarget:self action:@selector(CButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_CelsiusButton];
}
- (void)CButtonClick{
    _isSelect = YES;
    
    //CButton改变颜色
    _CelsiusButton.layer.borderColor = COLOR.CGColor;
    _CelsiusButton.titleLabel.textColor = COLOR;
    
    //FButton变黑色
    _FahrenheitButton.layer.borderColor = [UIColor blackColor].CGColor;
    _FahrenheitButton.titleLabel.textColor = [UIColor blackColor];
}
- (void)setFButton{
    _FahrenheitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _FahrenheitButton.frame = CGRectMake(255, 35, 46, 30);
    _FahrenheitButton.titleLabel.text = @"°F";
    _FahrenheitButton.layer.cornerRadius = 10;
    
    //选中状态  边框与title改变颜色
    if (!_isSelect) {
        _FahrenheitButton.layer.borderColor = COLOR.CGColor;
        _FahrenheitButton.titleLabel.textColor = COLOR;
    }else{
        _FahrenheitButton.layer.borderColor = [UIColor blackColor].CGColor;
        _FahrenheitButton.titleLabel.textColor = [UIColor blackColor];
    }
    
    _FahrenheitButton.layer.borderWidth = 2;
    [_FahrenheitButton addTarget:self action:@selector(FButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_FahrenheitButton];
}

- (void)FButtonClick{
    _isSelect = NO;
    
    //FButton改变颜色
    _FahrenheitButton.layer.borderColor = COLOR.CGColor;
    _FahrenheitButton.titleLabel.textColor = COLOR;
    
    //CButton变黑色
    _CelsiusButton.layer.borderColor = [UIColor blackColor].CGColor;
    _CelsiusButton.titleLabel.textColor = [UIColor blackColor];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
