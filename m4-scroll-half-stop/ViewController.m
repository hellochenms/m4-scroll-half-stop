//
//  ViewController.m
//  m4-scroll-half-stop
//
//  Created by Chen,Meisong on 2018/10/22.
//  Copyright © 2018年 xyz.chenms. All rights reserved.
//

#import "ViewController.h"
#import "M7TempDataGenerator.h"
#import "M4TouchPenetrateScrollView.h"
#import "M4Status3ScrollViewHelper.h"
#import "M4Status2ScrollViewHelper.h"

static const NSString *kCellIdentifer = @"kCellIdentifer";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic) UILabel *header;
@property (nonatomic) UIView *naviBar;
@property (nonatomic) UIView *bgView;
@property (nonatomic) UIButton *bgButton;
@property (nonatomic) M4TouchPenetrateScrollView *tableView;
@property (nonatomic) NSArray *datas;
@property (nonatomic) M4Status3ScrollViewHelper *status3ScrollHelper;
@property (nonatomic) M4Status2ScrollViewHelper *status2ScrollHelper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.bgButton];
    [self.view addSubview:self.naviBar];
    [self.view addSubview:self.tableView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView setContentOffset:[self.status3ScrollHelper startOffset]];
//        [self.tableView setContentOffset:[self.status2ScrollHelper startOffset]];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.header.frame = CGRectMake(0, 0, 0, 80);
    self.bgView.frame = self.view.bounds;
    self.bgButton.frame = CGRectMake(20, 64, 160, 40);
    self.naviBar.frame = CGRectMake(0, 0, width, 64);
    self.tableView.frame = CGRectMake(0, 64, width, CGRectGetHeight(self.view.bounds) - 64);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.naviBar.alpha = [self.status3ScrollHelper naviBarProgressWithScrollView:scrollView];
//    self.naviBar.alpha = [self.status2ScrollHelper naviBarProgressWithScrollView:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    scrollView.bounces = [self.status3ScrollHelper bouncesWithScrollView:scrollView];
//    scrollView.bounces = [self.status2ScrollHelper bouncesWithScrollView:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    BOOL shouldUse = NO;
    CGPoint target = [self.status3ScrollHelper targetPointWithScrollView:scrollView
                                                                velocity:velocity
                                                               shouldUse:&shouldUse];
//    CGPoint target = [self.status2ScrollHelper targetPointWithScrollView:scrollView
//                                                                velocity:velocity
//                                                               shouldUse:&shouldUse];
    if (shouldUse) {
        *targetContentOffset = target;
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifer forIndexPath:indexPath];
    cell.textLabel.text = self.datas[indexPath.row];

    return cell;
}

#pragma mark - Event
- (void)onTapBgButton {
    NSLog(@"【chenms】  %s", __func__);
}

#pragma mark - Getter
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[M4TouchPenetrateScrollView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = [self.status3ScrollHelper contentInset];
//        _tableView.contentInset = [self.status2ScrollHelper contentInset];
        _tableView.tableHeaderView = self.header;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifer];
    }
    return _tableView;
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blueColor];
    }
    return _bgView;
}

- (NSArray *)datas {
    if(!_datas){
        _datas = [M7TempDataGenerator textArrayForCount:20];
    }

    return _datas;
}
- (UIButton *)bgButton{
    if(!_bgButton){
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgButton setTitle:@"背景上的按钮" forState:UIControlStateNormal];
        [_bgButton addTarget:self action:@selector(onTapBgButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}

- (UIView *)naviBar{
    if(!_naviBar){
        _naviBar = [[UIView alloc] init];
        _naviBar.backgroundColor = [UIColor redColor];
        _naviBar.alpha = 0;
    }
    return _naviBar;
}

- (UILabel *)header{
    if(!_header){
        _header = [[UILabel alloc] init];
        _header.textAlignment = NSTextAlignmentCenter;
        _header.backgroundColor = [UIColor greenColor];
        _header.text = @"header";
    }
    return _header;
}

- (M4Status3ScrollViewHelper *)status3ScrollHelper {
    if(!_status3ScrollHelper){
        _status3ScrollHelper = [M4Status3ScrollViewHelper new];
        _status3ScrollHelper.naviBarTriggerY = 100;
        _status3ScrollHelper.neckY = 150;
        _status3ScrollHelper.ankleY = 450;
    }

    return _status3ScrollHelper;
}
- (M4Status2ScrollViewHelper *)status2ScrollHelper {
    if(!_status2ScrollHelper){
        _status2ScrollHelper = [M4Status2ScrollViewHelper new];
        _status2ScrollHelper.naviBarTriggerY = 100;
        _status2ScrollHelper.neckY = 150;
    }

    return _status2ScrollHelper;
}
@end
