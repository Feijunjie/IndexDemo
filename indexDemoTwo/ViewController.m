//
//  ViewController.m
//  indexDemoTwo
//
//  Created by rhjt on 16/7/11.
//  Copyright © 2016年 junjie. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#define NEW_USER(str) [[User alloc] init:str name:str]
@interface ViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ttt";
    [self setupSubviews];
    [self configureSections];
}

- (void)setupSubviews {
    
    // setup tableview
    CGRect frame = self.view.bounds;
    self.tableView =
    [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    
}

//配置分组信息
- (void)configureSections {
   //初始化测试数据
    NSMutableArray *city = [[NSMutableArray alloc] init];
    _userArray = [NSMutableArray arrayWithObjects:@"北京",@"安徽",@"合肥",@"邯郸",@"蚌埠",@"上海",@"广州",@"西安",@"淮南",@"江西",@"武汉",@"广西",@"河北",@"俄罗斯",@"盐城",@"江苏",@"新疆",@"乌鲁木齐", nil];
    for (int i = 0; i < _userArray.count; i++) {
        [city addObject:[[User alloc] init:_userArray[i] name:_userArray[i]]];
    }

    
    
    //获得当前UILocalizedIndexedCollation对象并且引用赋给collation,A-Z的数据
    self.collation = [UILocalizedIndexedCollation currentCollation];
    
    //获得索引数和section标题数
    NSInteger index, sectionTitlesCount = [[_collation sectionTitles] count];
    
    //临时数据，存放section对应的userObjs数组数据
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //设置sections数组初始化：元素包含userObjs数据的空数据
    for (index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    //将用户数据进行分类，存储到对应的sesion数组中
    for (User *userObj in city) {
        
        //根据timezone的localename，获得对应的的section number
        NSInteger sectionNumber = [_collation sectionForObject:userObj collationStringSelector:@selector(username)];
        
        //获得section的数组
        NSMutableArray *sectionUserObjs = [newSectionsArray objectAtIndex:sectionNumber];
        
        //添加内容到section中
        [sectionUserObjs addObject:userObj];
    }
    
    //排序，对每个已经分类的数组中的数据进行排序，如果仅仅只是分类的话可以不用这步
    for (index = 0; index < sectionTitlesCount; index++) {
        
        NSMutableArray *userObjsArrayForSection = [newSectionsArray objectAtIndex:index];
        
        //获得排序结果
        NSArray *sortedUserObjsArrayForSection = [_collation sortedArrayFromArray:userObjsArrayForSection collationStringSelector:@selector(username)];
        
        //替换原来数组
        [newSectionsArray replaceObjectAtIndex:index withObject:sortedUserObjsArrayForSection];
    }
    self.sectionsArray = newSectionsArray;
}

#pragma mark -- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // The number of sections is the same as the number of titles in the collation.
    return [[_collation sectionTitles] count];
    
}

//设置每个Section下面的cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // The number of time zones in the section is the count of the array associated with the section in the sections array.
    NSArray *UserObjsInSection = [_sectionsArray objectAtIndex:section];
    
    return [UserObjsInSection count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get the time zone from the array associated with the section index in the sections array.
    NSArray *userNameInSection = [_sectionsArray objectAtIndex:indexPath.section];
    
    // Configure the cell with the time zone's name.
    User *userObj = [userNameInSection objectAtIndex:indexPath.row];
    cell.textLabel.text = userObj.username;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
 * 跟section有关的设定
 */
//设置section的Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *UserObjsInSection = [_sectionsArray objectAtIndex:section];
    if(UserObjsInSection == nil || [UserObjsInSection count] <= 0) {
        return nil;
    }
    return [[_collation sectionTitles] objectAtIndex:section];
}
//设置索引标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [_collation sectionIndexTitles];
}
//关联搜索
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [_collation sectionForSectionIndexTitleAtIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
