//
//  WZAutoLoopViewTestVC.m
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import "WZAutoLoopViewTestVC.h"
#import "WZAutoLoopView.h"
#import "WZBannerModel.h"

@interface WZAutoLoopViewTestVC ()

@property (nonatomic, strong) WZAutoLoopView *autoLoopView;

@end

@implementation WZAutoLoopViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    _autoLoopView = [[WZAutoLoopView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200.f)];
    _autoLoopView.backgroundColor = [UIColor redColor];
    _autoLoopView.stretchAnimation = YES;
    _autoLoopView.banners = [self getModel];
    
    [self.tableView setTableHeaderView:_autoLoopView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)getModel
{
    WZBannerModel * model1 = [[WZBannerModel alloc]
                              initWithBannerImage:@"http://pic3.zhimg.com/f4825a9f42c749875e828bb0df03311e.jpg"
                              bannerLink:nil
                              newsId:@"9065662"
                              newsTitle:@"冬天还是不够冷，我要去西伯利亚感受一下"];
    WZBannerModel * model2 = [[WZBannerModel alloc]
                              initWithBannerImage:@"http://pic1.zhimg.com/485645626bd64f93c69c2e357c8b1bc8.jpg"
                              bannerLink:nil
                              newsId:@"9065662"
                              newsTitle:@"知乎好问题 · 你在出差过程中总结了哪些经验？"];
    WZBannerModel * model3 = [[WZBannerModel alloc]
                              initWithBannerImage:@"http://pic4.zhimg.com/c72a8f7b4de4d30c2223892f2069d94f.jpg"
                              bannerLink:nil
                              newsId:@"9065662"
                              newsTitle:@"为什么国产电影总是花大量的钱在明星身上？"];
    WZBannerModel * model4 = [[WZBannerModel alloc]
                              initWithBannerImage:@"http://pic3.zhimg.com/65e1e452a62f7e279f516b654b5af3e2.jpg"
                              bannerLink:nil
                              newsId:@"9065662"
                              newsTitle:@"苹果的 AirPods 开卖了，这是用了一个多月的体验"];
    WZBannerModel * model5 = [[WZBannerModel alloc]
                              initWithBannerImage:@"http://pic1.zhimg.com/76b28d30f82e95e6d08fa536d52b0a68.jpg"
                              bannerLink:nil
                              newsId:@"9065662"
                              newsTitle:@"美欧日拒绝承认中国市场经济地位，还能愉快地赚钱吗？"];
    
    return  @[model1,model2,model3,model4,model5];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.tableView){
        
        CGFloat offSetY = scrollView.contentOffset.y;
        
        if ([self.tableView.tableHeaderView isKindOfClass:[WZAutoLoopView class]]) {
            [(WZAutoLoopView *)(self.tableView.tableHeaderView) parallaxHeaderViewWithOffset:scrollView.contentOffset];
        }
        
        CGFloat dateHeaderHeight = 44;
        if (offSetY <= dateHeaderHeight && offSetY >= 0) {
            
//                        scrollView.contentInset = UIEdgeInsetsMake(-offSetY, 0, 0, 0);
        }
        else if (offSetY >= dateHeaderHeight) {//偏移20
            
//                        scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        }
 
    }
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
