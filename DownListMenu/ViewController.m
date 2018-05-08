//
//  ViewController.m
//  DownListMenu
//
//  Created by ZLWL on 2018/5/8.
//  Copyright © 2018年 YAND. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 推荐将`MenuListView`设置为tableView的第一组的组头视图
    UIImage *defImg = [UIImage imageNamed:@"gc_navi_arrow_down"];
    UIImage *selImg = [UIImage imageNamed:@"gc_navi_arrow_up"];
    CGRect frame = CGRectMake(0.f, 0.f, kS_W, 40.f);
    NSArray *titles = @[@"自助餐", @"附近", @"智能排序"];
    MenuListView *menu = [[MenuListView alloc] initWithFrame:frame Titles:titles defImage:defImg selImage:selImg];
    
    __weak typeof (menu)weakMenu = menu;
    menu.clickMenuButton = ^(MenuButton *button, NSInteger index, BOOL selected){
        // NSLog(@"点击了第 %ld 个按钮，选中还是取消？:%d", index, selected);
        if (index == 0) {
            weakMenu.dataSource = @[@"自助餐",@"火锅",@"海鲜",@"烧烤啤酒",@"甜点饮食",@"生日蛋糕",@"小吃快餐"];
        }
        else if (index == 1) {
            weakMenu.dataSource = @[@"附近",@"新津县",@"都江堰",@"温江区",@"郫县",@"龙泉驿区",@"锦江区"];
        }
        else if (index == 2) {
            weakMenu.dataSource = @[@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高"];
        }
    };
    
    // 选中下拉列表某行时的回调（这个回调方法请务必实现！）
    menu.clickListView = ^(NSInteger index, NSString *title){
        NSLog(@"选中了：%ld   标题：%@", index, title);
    };
    
    return menu;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ZFMainVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = @"看见好看姐夫好垃圾卡是否好看健身房好看撒后方可手机话费萨克积分戽水抗旱发顺丰副书记客户反馈到健身房萨克积分灰色空间峰会上";
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"下拉列表Demo";
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
