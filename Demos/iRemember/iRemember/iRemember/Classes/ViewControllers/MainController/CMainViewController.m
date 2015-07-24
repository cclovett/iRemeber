//
//  CMainViewController.m
//  iRemember
//
//  Created by Cc on 15/6/22.
//  Copyright (c) 2015年 CenterC. All rights reserved.
//

#import "CMainViewController.h"
#import "CMGlobel.h"
#import "VRememberTableView.h"
#import "CoreDataManager.h"

@interface CMainViewController ()
<
    VRememberUpDownRefreshViewDelegate
>

    @property (nonatomic,strong) VRememberTableView *mIB_tableView;

@end

@implementation CMainViewController

- (instancetype)initWithDelegate:(id<CMainViewControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        self.pDelegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initmIB_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initmIB_tableView
{
    if (self.mIB_tableView == nil) {
        
        self.mIB_tableView = [[VRememberTableView alloc] initWithFrame:self.view.bounds];
        self.mIB_tableView.backgroundColor = gUI_main_backgroundColor;
        [self.view addSubview:self.mIB_tableView];
        
        self.mV_upDownRefreshView = [[VRememberUpDownRefreshView alloc] initWithDirection:eVRememberUpDownRefreshDirection_down withDelegate:self];
        [self.mIB_tableView addSubview:self.mV_upDownRefreshView];
        
        [self reflashIB_tableViewDataSource];
    }
}

- (void)reflashIB_tableViewDataSource
{
    CCoreDataManagedObjectContext *context = [[CoreDataManager instance] pCreatePrivateQueueContext];
    NSArray *arrObjs = nil;//[MORememberGroup c_searchAllValidGroupsInContext:context];
    self.mIB_tableView.pArray_DataSource = nil;//[arrObjs c_getManagedObjectIDs];
    [self.mIB_tableView reloadData];
}

- (void)dgVRememberUpDownRefreshView_refresh:(VRememberUpDownRefreshView *)refreshView
{
    [self.pDelegate dgVRememberUpDownRefreshView_refresh:refreshView];
}

@end
