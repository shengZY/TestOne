//
//  YZTCheckResultView.m
//  16_0324密码状态图表
//
//  Created by ChuckonYin on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CheckResultView.h"
#import "UIColor+Hex.h"
const CGFloat CheckResultViewInfoDefaultFont = 14.0f;
const CGFloat CheckResultViewInfoDefaultWidth = 150.0f;
const CGFloat CheckResultViewImageDefaultHeight = 18.0f;
const CGFloat CheckResultViewTriangleDefaultHeight = 6.0f;
@interface CheckResultView()

@property (nonatomic, assign) CGPoint mCenter;

@property (nonatomic, assign) CheckResultViewPopDirection direction;

@property (nonatomic, assign) CheckResultViewResult result;

@property (nonatomic, strong) CheckResultViewDetailView *detailView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CheckResultView

- (instancetype)initWithCenter:(CGPoint)center popDirection:(CheckResultViewPopDirection)direction{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
//        self.hidden = YES;
        self.alpha = 0;
//        self.backgroundColor = [UIColor grayColor];
        self.mCenter = center;
        _direction = direction;
        _infoWidth = CheckResultViewInfoDefaultWidth;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.detailView];
    [self addSubview:self.imageView];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CheckResultViewImageDefaultHeight, CheckResultViewImageDefaultHeight)];
        _imageView.center = CGPointMake(200, 100);
    }
    return _imageView;
}

- (void)setMCenter:(CGPoint)mCenter{
    _mCenter = mCenter;
    self.frame = CGRectMake(_mCenter.x-200, _mCenter.y-100, 400, 100 + CheckResultViewImageDefaultHeight/2.0f);
}

- (void)popWithInfo:(NSString *)info center:(CGPoint)center resultType:(CheckResultViewResult)result{
    self.mCenter = center;
    [self popWithInfo:info resultType:result];
}

- (void)popWithInfo:(NSString *)info resultType:(CheckResultViewResult)result{
    switch (result) {
        case YZTCheckResultViewResultFalse :{
            self.imageView.image = [UIImage imageNamed:@"warning"];
        }
            break;
            
    }
    [self.detailView refreshWithInfo:info];
}

- (CheckResultViewDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[CheckResultViewDetailView alloc] initWithHostView:self];
        _detailView.hostView = self;
    }
    return _detailView;
}

- (void)dismiss{
//    self.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

@end

@interface CheckResultViewDetailView()

@property (nonatomic, assign) CheckResultViewPopDirection direction;

@property (nonatomic, strong) UILabel *infoLab;

@property (nonatomic, strong) UIView *backCover;

@property (nonatomic, assign) CGFloat infoWidth;

@property (nonatomic, assign) CGFloat infoHeight;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, assign) CGFloat infoLabBottomY;

@end

@implementation CheckResultViewDetailView

- (instancetype)initWithHostView:(CheckResultView *)hostView{
    if (self = [super initWithFrame:hostView.bounds]) {
        
        _hostView = hostView;
        
        self.backgroundColor = [UIColor clearColor];
        
        
        _backCover = [[UIView alloc] init];
        _backCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _backCover.clipsToBounds = YES;
        _backCover.layer.cornerRadius = 4;
        [self addSubview:_backCover];
        
        _infoLabBottomY = 100 - CheckResultViewImageDefaultHeight/2.0 - CheckResultViewTriangleDefaultHeight;
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.textColor = [UIColor whiteColor];
        _infoLab.textAlignment = NSTextAlignmentCenter;
        _infoLab.numberOfLines = 0;
        _infoLab.font = [UIFont systemFontOfSize:CheckResultViewInfoDefaultFont];
        [self addSubview:_infoLab];
    }
    return self;
}

- (void)refreshWithInfo:(NSString *)iofo{
    _info = iofo;
    _infoWidth = CheckResultViewInfoDefaultWidth;
    _infoHeight = [_info cr_heightForFont:[UIFont systemFontOfSize:CheckResultViewInfoDefaultFont] width:_infoWidth];
    if (_infoHeight<[UIFont systemFontOfSize:CheckResultViewInfoDefaultFont].ascender+4) {
        //只有一行,调整宽度
        [self adjustDetailInfoWidth:[_info cr_widthForFont:[UIFont systemFontOfSize:CheckResultViewInfoDefaultFont]] height:_infoHeight];
    }
    else{
        //多行，调整宽度
        [self adjustDetailInfoWidth:_infoWidth height:_infoHeight];
    }
    _infoLab.text = iofo;
//    self.hostView.hidden = NO;
//    [UIView animateWithDuration:0.5 animations:^{
//        
//    } completion:^(BOOL finished) {
//    }];
    self.hostView.alpha = 1.0;
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame)+2.5, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame)-2.5, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } completion:^(BOOL finished) {
        
    }];
    
    [self setNeedsDisplay];
}

- (void)adjustDetailInfoWidth:(CGFloat)width height:(CGFloat)height{
    switch (_hostView.direction) {
        case YZTCheckResultViewPopDirectionLeft: {
            _infoLab.frame = CGRectMake(200.0- width*8.0/10.0, _infoLabBottomY - height-7.5, width, height);
            break;
        }
        case YZTCheckResultViewPopDirectionCenter: {
            _infoLab.frame = CGRectMake(200.0- width*5.0/10.0, _infoLabBottomY - height-7.5, width, height);
            break;
        }
        case YZTCheckResultViewPopDirectionRight: {
            _infoLab.frame = CGRectMake(200.0- width*2.0/10.0, _infoLabBottomY - height-7.5, width, height);
            break;
        }
    }
    _backCover.frame = CGRectMake(_infoLab.frame.origin.x-15, _infoLab.frame.origin.y-7.5, _infoLab.frame.size.width + 30, _infoLab.frame.size.height+15);
}



- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(200.0, 100-CheckResultViewImageDefaultHeight/2.0)];
    [path addLineToPoint:CGPointMake(200.0-5.0, 100-CheckResultViewImageDefaultHeight/2.0 - CheckResultViewTriangleDefaultHeight)];
    [path addLineToPoint:CGPointMake(200.0+5.0, 100-CheckResultViewImageDefaultHeight/2.0 - CheckResultViewTriangleDefaultHeight)];
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.85] setFill];
    [path fill];
}

@end


@implementation NSString(YZTCheckResultView)

- (CGSize)cr_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
        if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            NSMutableDictionary *attr = [NSMutableDictionary new];
            attr[NSFontAttributeName] = font;
            if (lineBreakMode != NSLineBreakByWordWrapping) {
                NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
                paragraphStyle.lineBreakMode = lineBreakMode;
                attr[NSParagraphStyleAttributeName] = paragraphStyle;
            }
            CGRect rect = [self boundingRectWithSize:size
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attr context:nil];
            result = rect.size;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
        }
    return result;
}

- (CGFloat)cr_widthForFont:(UIFont *)font {
    CGSize size = [self cr_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)cr_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self cr_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

@end














