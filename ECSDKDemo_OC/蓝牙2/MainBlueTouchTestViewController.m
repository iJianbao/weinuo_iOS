//
//  ViewController.m
//  ZLCBlueTooth
//
//  Created by shining3d on 16/8/17.
//  Copyright © 2016年 shining3d. All rights reserved.
//

#import "MainBlueTouchTestViewController.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MainBlueTouchTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainBlueTouchTestViewController
{
	UITableView *blueListTableview;
	NSMutableArray *dataSource;
	NSMutableArray *advertisementsDataSource;
}






- (void)viewDidLoad {
	[super viewDidLoad];
    self.title                             = @"Bluetooth";
    self.view.backgroundColor              = [UIColor whiteColor];



    UIBarButtonItem *barItem               = [[UIBarButtonItem alloc]initWithTitle:@"scan" style:UIBarButtonItemStyleDone target:self action:@selector(scanStart:)];
    self.navigationItem.rightBarButtonItem = barItem;
	
	
	[self setTableView];//设置tableview
	
	
	[BLEManager sharedManagerWithDelegate:self];    //遵循蓝牙代理
//    [BLEManager sharedManager].delegate  =self;
	
	
}

- (void)scanStart:(UIBarButtonItem *)item
{
//	[[BLEManager sharedManager]disableBLEManager]; //断开蓝牙
	[[BLEManager sharedManager] scanningForPeripherals];//开始扫描
	[SVProgressHUD show];//转圈
}


#pragma mark --根据蓝牙设备数据设置tableview
- (void)setTableView
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout               = UIRectEdgeNone;

    dataSource                                = [[NSMutableArray alloc]init];//加入数据源
	advertisementsDataSource                  = [[NSMutableArray alloc]init];//数据源

    blueListTableview                         = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    blueListTableview.delegate                = self;
    blueListTableview.dataSource              = self;
    blueListTableview.tableFooterView         = [[UIView alloc]init];
	[self.view addSubview:blueListTableview];
	//让底部不被遮挡
	blueListTableview.autoresizingMask  = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return dataSource.count;
}
//设置tableview cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	
	CBPeripheral *p = dataSource[indexPath.row];//获取到设备
	cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",p.name,[p.identifier.UUIDString substringToIndex:5]];//将设备名显示到cell
	
	
	NSDictionary *ad = [advertisementsDataSource objectAtIndex:indexPath.row];
	
	//peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
	NSString *localName;
	if ([ad objectForKey:@"kCBAdvDataLocalName"]) {
		localName = [NSString stringWithFormat:@"%@(%@)",[ad objectForKey:@"kCBAdvDataLocalName"],[p.identifier.UUIDString substringToIndex:5]];
	}else{
		localName = [NSString stringWithFormat:@"%@(%@)",p.name,[p.identifier.UUIDString substringToIndex:5]];
	}
	
	cell.textLabel.text = localName;
	return cell;
}


#pragma mark-- tableview点击连接事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD dismiss];//结束转圈
    
	NSInteger index = indexPath.row;
	if(index == -1){
		[[BLEManager sharedManager] stopScanningForPeripherals];//停止扫描
		return;
	}
	
	NSLog(@"选择是设备：%@",[dataSource objectAtIndex:index]);
	
	PeripheralViewController *per = [[PeripheralViewController alloc]init];
	per.periperal = [dataSource objectAtIndex:index];
	[self.navigationController pushViewController:per animated:YES];
	
	//连接当前点击设备
//	[[BLEManager sharedManager] connectingPeripheral:[dataSource objectAtIndex:index]];//连接设备
}


# pragma mark - BLEManager Methods
- (void)BLEManagerDisabledDelegate {
	
}



#pragma mark --接收到扫描到得所有设备
- (void)BLEManagerReceiveAllPeripherals:(NSMutableArray *) peripherals andAdvertisements:(NSMutableArray *)advertisements {

	[SVProgressHUD dismiss];//结束转圈
	[dataSource addObjectsFromArray:peripherals];//加入数据源
	[advertisementsDataSource addObjectsFromArray:advertisements];
	[blueListTableview reloadData];

}

@end
