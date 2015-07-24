//
//  VRememberTableView.m
//  iRemember
//
//  Created by Cc on 14-6-29.
//  Copyright (c) 2014年 CenterC. All rights reserved.
//

#import "VRememberTableView.h"
#import "CMGlobel.h"

@interface VRememberTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSArray *mArray_groups;

@end

@implementation VRememberTableView

- (void)awakeFromNib
{
    self.delegate = self;
    self.dataSource = self;
    [self setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self awakeFromNib];
    }
    return self;
}

- (void)dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    SDKLog(@"%@",self);
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pArray_DataSource.count > 0 ? self.pArray_DataSource.count : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getTableViewCellHeight];
}

- (CGFloat)getTableViewCellHeight
{
    CGFloat h = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat rowH = self.pArray_DataSource.count > 0 ? 45 : self.bounds.size.height - h;
    return rowH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pArray_DataSource.count == 0) {
        
        UITableViewCell *cell = [self getEmptyCellInTableView:tableView];
        
        return cell;
    }
    else {
        static NSString *SimpleTableIdentifier = @"VRememberTableView_SimpleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: SimpleTableIdentifier];
        }
        if (indexPath.row % 2 == 0) {
            [cell setBackgroundColor:[UIColor yellowColor]];
        }
        else {
            [cell setBackgroundColor:[UIColor redColor]];
        }
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"12");
}

- (UITableViewCell*)getEmptyCellInTableView:(UITableView *)tableView
{
    static NSString *SimpleTableIdentifier = @"VRememberTableView_EmptyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: SimpleTableIdentifier];
    }
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 65, 200/2, 86/2.0)];
        imageView.image = [UIImage imageNamed:@"Main_Glass"];
        [cell addSubview:imageView];
        
    }
    
    {//clipboard
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 150, 398/2.0, 600/2.0)];
        imageView.image = [UIImage imageNamed:@"Main_Clipboard"];
        [cell addSubview:imageView];
       
    }
    {//pen
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 156, 26/2.0, 450/2.0)];
        imageView.image = [UIImage imageNamed:@"Main_Pen"];
        [cell addSubview:imageView];
        
    }
    {//Eraser
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 474, 150/2.0, 70/2.0)];
        imageView.image = [UIImage imageNamed:@"Main_Eraser"];
        [cell addSubview:imageView];
        
    }
    [cell setBackgroundColor:gUI_main_backgroundColor];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
@end
