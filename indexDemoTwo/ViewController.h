//
//  ViewController.h
//  indexDemoTwo
//
//  Created by rhjt on 16/7/11.
//  Copyright © 2016年 junjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *userArray; //数据源数组
@property (nonatomic, strong) NSMutableArray *sectionsArray;//存放section对应的userObjs数组数据

//UITableView索引搜索工具
@property (nonatomic, strong) UILocalizedIndexedCollation *collation;

@end

