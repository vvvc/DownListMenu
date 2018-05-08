//
//  ZFMainVC.m
//  ZFMenuTableView
//
//  Created by 张锋 on 16/6/6.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import "ZFMainVC.h"
#import "MenuListView.h"

@interface ZFMainVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ZFMainVC

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
    NSArray *titles = @[@"自助餐", @"附近", @"智能排序", @"筛选"];
    MenuListView *menu = [[MenuListView alloc] initWithFrame:frame Titles:titles defImage:defImg selImage:selImg];
    
    __weak typeof (menu)weakMenu = menu;
    menu.clickMenuButton = ^(MenuButton *button, NSInteger index, BOOL selected){
        // NSLog(@"点击了第 %ld 个按钮，选中还是取消？:%d", index, selected);
        if (index == 0) {
            weakMenu.dataSource = @[@"自助餐",@"火锅",@"海鲜",@"烧烤啤酒",@"甜点饮食",@"生日蛋糕",@"小吃快餐",@"日韩料理",@"西餐",@"聚餐宴请",@"川菜",@"江浙菜",@"香锅烤鱼",@"粤菜",@"中式烧烤/烤串",@"西北菜",@"咖啡酒吧",@"京菜鲁菜",@"湘菜",@"生鲜蔬果",@"东北菜",@"云贵菜",@"东南亚菜",@"素食",@"创意菜",@"躺/粥/炖菜",@"新疆菜",@"其他美食"];
        }
        else if (index == 1) {
            weakMenu.dataSource = @[@"附近",@"新津县",@"都江堰",@"温江区",@"郫县",@"龙泉驿区",@"锦江区",@"金牛区",@"成华区",@"青羊区",@"武侯区"];
        }
        else if (index == 2) {
            weakMenu.dataSource = @[@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高"];
        }
        else if (index == 3) {
            weakMenu.dataSource = @[@"只看免预约",@"节假日可用",@"用餐时间段",@"用餐人数",@"餐厅地点"];
        }
    };
    
    // 选中下拉列表某行时的回调（这个回调方法请务必实现！）
    menu.clickListView = ^(NSInteger index, NSString *title){
        NSLog(@"选中了：%d   标题：%@", index, title);
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
    cell.textLabel.text = @"艾泽拉斯火锅火爆开业，凡进店吃火锅的一律打五折优惠！并且可享受一次免费`军团再临`体验机会！";
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"仿美团下拉列表";
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

@end
