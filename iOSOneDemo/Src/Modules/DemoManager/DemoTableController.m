//
//  DemoTable.m
//  XXXX
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "DemoTableController.h"
#import "DemoDataModel.h"
#import "DemoManager.h"

@interface DemoTableController () <UITableViewDataSource, UITableViewDelegate>

#pragma mark - < Private properties >

@property (nonatomic, copy) NSArray<DemoDataModel *> *dataSource;
@property (nonatomic, assign) BOOL isAllSpread; // 全展开

#pragma mark - < UI Controls >

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation DemoTableController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEnvironment];
    [self initWindow];
    [self initUI];
    [self initAction];
    [self initDataSource];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - < Init Methods >

- (void)initWindow {
    self.title = @"iOS一个Demo就够了";
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"展开" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBarItemClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)initEnvironment {
    _isAllSpread = NO;
}

- (void)initUI {
    _tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator =NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)initAction{
    
}

- (void)initDataSource {
    self.dataSource = [[DemoManager sharedManager] exportDemos];
}


#pragma mark - < Public Methods >


#pragma mark - < Main Logic >

- (void)onRightBarItemClicked:(id)sender {
    _isAllSpread = !_isAllSpread;
    for (DemoDataModel *demo in self.dataSource) {
        demo.isSpread = _isAllSpread;
        if (demo.spreadDemosCount > 0) {
            for (DemoDataModel *subDemo in demo.spreadDemos) {
                subDemo.isSpread = _isAllSpread;
            }
        }
    }
    
    self.navigationItem.rightBarButtonItem.title = (_isAllSpread)? @"收起": @"展开";
    
    [_tableView reloadData];
}


#pragma mark - < Delegate Methods >


#pragma mark [ TableView delegate ]

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DemoDataModel *model = self.dataSource[section];
    return [model spreadDemosCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoDataModel *demo = self.dataSource[indexPath.section].spreadDemos[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    if (demo.type == DemoTypeCategory) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.contentView.backgroundColor = kAppColor.demoCategoryBg;
    }
    else {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = kAppColor.demoControllerBg;
    }
    cell.textLabel.text = demo.displayName;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.tag = section;
    view.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [view addGestureRecognizer:tap];
    view.backgroundColor = kAppColor.demoSectionBg;
    
    XXXXLabel *label = [XXXXLabel labelWithType:XXXXLabelTypeDefault];
    label.frame = CGRectMake(20, 0, kAppDimension.screenWidth, 44);
    [label setText:_dataSource[section].displayName
              font:kAppFont.h4 color:kAppColor.h1];
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    return view;
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
    DemoDataModel *demo = self.dataSource[index];
    NSLog(@"点击了%@", demo.displayName);
    
    //修改section的关闭和打开
    demo.isSpread = !demo.isSpread;
    
    //刷新section的方法
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DemoDataModel *demo = self.dataSource[indexPath.section].spreadDemos[indexPath.row];
    
    //判断点击的cell 对应的数据是否是city
    if (demo.type == DemoTypeController) {
        Class demoClass = NSClassFromString(demo.name);
        [self.navigationController pushViewController:[demoClass new] animated:YES];
        NSLog(@"Go to demo ==> %@", demo.displayName);
    }
    else {
        NSMutableArray *pathArr = [NSMutableArray array];
        if (demo.isSpread) {
            NSLog(@"关闭 ==> %@", demo.displayName);
            NSInteger spreadDemoCount = demo.spreadDemosCount;
            demo.isSpread = NO;
            
            if (spreadDemoCount > 0) {
                for (NSInteger i = 1; i <= spreadDemoCount; i++) {
                    NSIndexPath *path =[NSIndexPath indexPathForRow:(indexPath.row + i) inSection:indexPath.section];
                    [pathArr addObject:path];
                }

                [tableView beginUpdates];
                [tableView deleteRowsAtIndexPaths:pathArr withRowAnimation:UITableViewRowAnimationBottom];
                [tableView endUpdates];
            }
        }
        else {
            NSLog(@"打开 ==> %@", demo.displayName);
            demo.isSpread = YES;
            if (demo.spreadDemosCount > 0) {
                for (NSInteger i = 1; i <= demo.spreadDemosCount; i++) {
                    NSIndexPath *path =[NSIndexPath indexPathForRow:(indexPath.row + i) inSection:indexPath.section];
                    [pathArr addObject:path];
                }
                [tableView beginUpdates];
                [tableView insertRowsAtIndexPaths:pathArr withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView endUpdates];
            }
        }
        [tableView reloadData];
    }
}

#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >


@end














