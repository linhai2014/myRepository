//
//  ECHomeViewController.m
//  ExpenseClaim
//
//  Created by yulinhai on 2019/4/15.
//  Copyright © 2019年 linhai. All rights reserved.
//

#import "ECHomeViewController.h"
#import "ECGridItemModel.h"
#import "ECHomeTableViewCell.h"

static NSString * const kCellID = @"ViewControllerCell";
#define kHomeTableViewControllerCellId @"HomeTableViewController"

@interface ECHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) NSMutableArray  <ECGridItemModel *> *gridDataArray;
@property(nonatomic, strong) ECGridView_Config *gridViewConfig;
@end

@implementation ECHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.isSelectCell = NO;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (ECGridView_Config *)gridViewConfig {
    if (!_gridViewConfig) {
        _gridViewConfig = [[ECGridView_Config alloc] init];
        _gridViewConfig.rowCount = 2;
        _gridViewConfig.dataArray = self.gridDataArray;
    }
    return _gridViewConfig;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ECHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeTableViewControllerCellId];
        if (!cell)
        {
            cell = [[ECHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kHomeTableViewControllerCellId];
        }
        
        [cell setData:self.gridViewConfig];
//        cell.gridViewConfig = self.gridViewConfig;
//        cell.gridViewConfig.dataArray = self.gridDataArray;
//        cell.model = self.gridDataArray;
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
        }
        
        cell.textLabel.text = self.dataArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.numberOfLines = 0;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    self.gridView = nil;
//    self.gridDataArray = nil;
//
//    switch (indexPath.row) {
//        case 0:
//        {
//            self.isSelectCell = !self.isSelectCell;
//            if (self.isSelectCell)
//            {
//                self.ba_GridViewConfig.gridViewType = BAGridViewTypeTitleImage;
//                cell.textLabel.text = @"1、图上文下(点击更换样式)";
//            }
//            else
//            {
//                self.ba_GridViewConfig.gridViewType = BAGridViewTypeImageTitle;
//                cell.textLabel.text = @"1、文上图下(点击更换样式)";
//            }
//
//            self.tableView.tableFooterView = [UIView new];
//            UIView *footView = [self.view viewWithTag:100];
//
//            if (!footView)
//            {
//                footView = [UIView new];
//                footView.backgroundColor = [UIColor redColor];
//                footView.frame = CGRectMake(0, 20, BAKit_SCREEN_WIDTH, kGridView_H2);
//                footView.tag = 100;
//                self.gridView.frame = footView.bounds;
//                [footView addSubview:self.gridView];
//            }
//            self.tableView.tableFooterView = footView;
//        }
//            break;
//        case 1:
//        {
//            self.ba_GridViewConfig.gridViewType = BAGridViewTypeBgImageTitle;
//            self.tableView.tableFooterView = [UIView new];
//
//            UIView *footView = [self.view viewWithTag:101];
//
//            if (!footView)
//            {
//                footView = [UIView new];
//                footView.backgroundColor = [UIColor redColor];
//                footView.frame = CGRectMake(0, 20, BAKit_SCREEN_WIDTH, kGridView_H2);
//                footView.tag = 101;
//                self.gridView.frame = footView.bounds;
//                [footView addSubview:self.gridView];
//            }
//            self.tableView.tableFooterView = footView;
//        }
//            break;
//        case 2:
//        {
//            self.ba_GridViewConfig.gridViewType = BAGridViewTypeTitleDesc;
//            self.tableView.tableFooterView = [UIView new];
//
//            UIView *footView = [self.view viewWithTag:102];
//
//            if (!footView)
//            {
//                footView = [UIView new];
//                footView.backgroundColor = [UIColor redColor];
//                footView.frame = CGRectMake(0, 20, BAKit_SCREEN_WIDTH, kGridView_H2);
//                footView.tag = 102;
//                self.gridView2.frame = footView.bounds;
//                [footView addSubview:self.gridView2];
//            }
//
//            self.tableView.tableFooterView = footView;
//        }
//            break;
//
//
//        default:
//            break;
//    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 15;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger dataCount = self.gridViewConfig.dataArray.count;
    NSInteger rowCount = self.gridViewConfig.rowCount;
    
    NSInteger lineNum = dataCount % rowCount == 0 ? dataCount / rowCount : dataCount / rowCount + 1;
    return lineNum * (ItemMargin + ItemHeight) + ItemMargin;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.tableFooterView = [UIView new];
        //        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
//        _dataArray = @[@"图上文下", @"两行文字"];
        _dataArray = @[@"图上文下"];
    }
    return _dataArray;
}

- (NSMutableArray <ECGridItemModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;
        
        NSArray *imageNameArray = @[@"tabbar_ExpenseClaimHL",
                                    @"tabbar_ExpenseClaim",
                                    @"tabbar_HomeHL",
                                    @"tabbar_RecordHL"];

        NSArray *titleArray = @[@"签报", @"商圈", @"印章", @"出行"];
        
//        NSArray *imageNameArray = @[@"tabbar_ExpenseClaimHL",
//                                    @"tabbar_ExpenseClaim",
//                                    @"tabbar_HomeHL"];
//
//        NSArray *titleArray = @[@"签报", @"商圈", @"印章"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            ECGridItemModel *model = [ECGridItemModel new];
            if (imageNameArray.count > 0)
            {
                model.imageName = imageNameArray[i];
            }

            model.titleString = titleArray[i];
            [self.gridDataArray addObject:model];
        }
    }
    return _gridDataArray;
}

@end
