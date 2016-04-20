//
//  TestTextField.m
//  TestOneDemo
//
//  Created by Yuu_zhang on 16/3/21.
//  Copyright © 2016年 Phyllis. All rights reserved.
//

#import "TestTextField.h"

@implementation TestTextField

//UITextField 的子类可以重新以下方法，只有子类可以。可以更改原来clear等的位置。。
- (CGRect)clearButtonRectForBounds:(CGRect)bounds{
    return bounds;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    return bounds;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return bounds;
}

- (CGRect)borderRectForBounds:(CGRect)bounds{
    return bounds;
}
- (CGRect)textRectForBounds:(CGRect)bounds{
    return bounds;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return bounds;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return bounds;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
