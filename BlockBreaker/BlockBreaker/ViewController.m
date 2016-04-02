//
//  ViewController.m
//  BlockBreaker
//
//  Created by 王壮 on 16/4/2.
//  Copyright © 2016年 王壮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollisionBehaviorDelegate>

@property (nonatomic,strong) UIDynamicAnimator *animator;

@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) UICollisionBehavior*  collision;
@property (nonatomic,assign) CGAffineTransform trans;
@end

@implementation ViewController

- (NSMutableArray *)array {
    if (_array == nil) {
        _array  = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    int totalcol = 8;
    int total = 40;
    int margin = 5;
    //设置方块的位置
    CGFloat viewOneX = 20;
    CGFloat viewOneY = 100;
    CGFloat viewW = 40;
    CGFloat viewH = 40;
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.animator = animator;
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    self.collision = collision;
    
    collision.collisionDelegate = self;
    
    UIGravityBehavior *behavior = [[UIGravityBehavior alloc] init];
    
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    UIDynamicItemBehavior *item2 = [[UIDynamicItemBehavior alloc] init];
    
    //创建方块
    for (int i = 0; i<total ; ++i) {
        
        int row = i / totalcol;
        
        int col = i % totalcol;
        
        CGFloat viewX = viewOneX + (viewW + margin) * col;
        
        CGFloat viewY = viewOneY + (viewH + margin) * row;
        
        UIView *view = [[UIView alloc] init];
        
        view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 256.0 green:arc4random() % 255 / 256.0 blue:arc4random() % 255 / 256.0 alpha:1];
        
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
        
        self.trans = view.transform;
        
        item2.angularResistance = 0;
        
        item2.resistance = MAXFLOAT;
        
        item2.elasticity = 0;
        
        [item2 addItem:view];
        
        [collision addItem:view];
        
        [self.array addObject:view];
        
        [self.view addSubview:view];
        
    }
    
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] init];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(arc4random() % (int)self.view.frame.size.width + 50 - 50, 500, 50, 50)];
    
    iconView.layer.cornerRadius = 50 * 0.5;
    
    iconView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:iconView];
    
    item.resistance = 1;
    
    item.elasticity = 2;
    
    [item addItem:iconView];
    
    [self.animator addBehavior:collision];
    [self.animator addBehavior:behavior];
    
    [self.animator addBehavior:item2];
    
    [collision addItem:iconView];
    
    [behavior addItem:iconView];
    
    [self.animator addBehavior:item];
    
}

#pragma mark -  碰撞的代理方法
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p {
    
    UIView *view = (UIView *) item2;
    
    view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 256.0 green:arc4random() % 255 / 256.0 blue:arc4random() % 255 / 256.0 alpha:1];
    
    if ([item1 class] != [item2 class])  {
        
        UIView *view = (UIView *)item1;
        
        [self.collision removeItem:item1];
        
        [view removeFromSuperview];
        
    }
    
}

@end
