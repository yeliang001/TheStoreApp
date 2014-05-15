//
//  YWHomeViewController.m
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWHomeViewController.h"
#import "NSString+MD5Addition.h"
#import "YWSpecialRecommendInfoData.h"

#define moduleTag 302
#define MODEAL_IMAGE_WIDTH  52
#define MODEAL_IMAGE_HEIGHT 52
#import "UIImageView+WebCache.h"
@interface YWHomeViewController ()

@end

@implementation YWHomeViewController
@synthesize modelATable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
//    [self initData];
 
    self.title = @"首页";
 
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self initHomePageUI];
    [self setUpNewThread];
 
    // Do any additional setup after loading the view from its nib.
}

//建立新线程
-(void)setUpNewThread
{
    //获取热销图
    [self otsDetatchMemorySafeNewThreadSelector:@selector(newThreadGetHotPage) toTarget:self withObject:nil];
}

-(void)newThreadGetHotPage {
    homeAction = [[YWHomeAction alloc] init];
    homeAction.m_delegate = self;
    [homeAction requestAction];
}

#pragma mark - request delegate
-(NSDictionary*)onRequestCouponListAction{
    return @{@"area": @"0"};
}

-(void)onResponseCouponListActionSuccess{
    YWHomePageData *tempPage = [homeAction getHomeSpcecialList];
    if (tempPage!=nil && ![tempPage isKindOfClass:[NSNull class]]){
        hotTopPage = tempPage;
        for (int i=0; i<[hotTopPage.objList count]; i++)
        {
            YWSpecialRecommendInfoData *SpecialRecommend = (YWSpecialRecommendInfoData*)[hotTopPage.objList objectAtIndex:i];
            NSString *hotProductImgUrlStr = SpecialRecommend.pic;
            if (hotProductImgUrlStr==nil)
            {
                continue;
            }
            //保存数据 缓存
            [self savePagesToLocal:hotTopPage];
        }
        //楼层数据
        [m_AdArray removeAllObjects];
        m_AdArray = hotTopPage.adFloorList;
        
        //更新界面
        [self performSelectorOnMainThread:@selector(updateHotPage) withObject:nil waitUntilDone:YES];

    }
}

-(void)onResponseCouponListActionFail{

}

-(void)savePagesToLocal:(YWHomePageData*)aPage
{
    NSArray* arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [arr objectAtIndex:0];
    NSString* filename = [path stringByAppendingPathComponent:@"SaveHotPages_130502.plist"];
    NSData* pageData = [NSKeyedArchiver archivedDataWithRootObject:aPage];
    [pageData writeToFile:filename atomically:NO];
}

#pragma mark - 刷新热销图
-(void)updateHotPage
{
    [self.view setUserInteractionEnabled:YES];
    
    //焦点图
    [m_PageView reloadPageView];
    
    //楼层
    [self updateCMSModuleA];
}

//刷新模块A列表
-(void)updateCMSModuleA
{
    UIView*moduleView=[self.main_ScrollView viewWithTag:moduleTag];
    CGFloat yValueInScroll=120+moduleView.frame.size.height;
    [modelATable reloadData];
    [self adjustModulesHeight];
    int  increace = m_AdArray.count;
    [self.main_ScrollView setContentSize:CGSizeMake(320, yValueInScroll+increace*180.0)];
}


-(void)adjustModulesHeight{
    UIView*moduleView=[self.main_ScrollView viewWithTag:moduleTag];
    
    moduleView.frame=CGRectMake(0, 120, 320, 100);
    modelATable.frame=CGRectMake(0, 120+100, 320, 750*m_AdArray.count); //改为了4个模块，所以y ＝ 120 ＋ 100
}

#pragma mark - 初始化UI
-(void)initHomePageUI
{
    CGFloat yValue=0.0;
    
    UIImageView *logoDescribeView=[[UIImageView alloc]initWithFrame:CGRectMake(138,1,45,41)];
	logoDescribeView.image=[UIImage imageNamed:@"homepage_logo.png"];
    
    //scroll view
	self.main_ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,yValue,320,480-20-49)];
    if (iPhone5) {
        [self.main_ScrollView setFrame:CGRectMake(0,yValue,320,568-20-49)];
    }
    //    [m_ScrollView setDelaysContentTouches:NO];
    [self.main_ScrollView setShowsVerticalScrollIndicator:NO];
    [self.main_ScrollView setScrollsToTop:NO];
    [self.main_ScrollView setAlwaysBounceVertical:YES];
    [self.main_ScrollView setDelegate:self];
    [self.main_ScrollView setContentSize:CGSizeMake(320, 600)];
	[self.view addSubview:self.main_ScrollView];
    
    //下拉刷新控件
    if (m_RefreshHeaderView!=nil) {
        m_RefreshHeaderView = nil;
    }
    m_RefreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -self.main_ScrollView.bounds.size.height, 320, self.main_ScrollView.bounds.size.height)];
    m_RefreshHeaderView.delegate=self;
    [self.main_ScrollView addSubview:m_RefreshHeaderView];
    [m_RefreshHeaderView refreshLastUpdatedDate];
    
    //焦点图
    m_PageView = [[YWHomeHotPageView alloc] initWithFrame:CGRectMake(0, 0, 320, 120) delegate:self showStatusBar:YES sleepTime:5];
    [self.main_ScrollView addSubview:m_PageView];
    
    //搜索
//	OTSSearchView *searchView=[[OTSSearchView alloc] initWithFrame:CGRectMake(0, yValue+80, 260, 40) delegate:m_Search];
//    searchView.backgroundColor = [UIColor clearColor];
//    searchView.tag = searchViewTag;
//    [self.view addSubview:searchView];
//    [searchView release];
//    //    yValue+=40.0;
    
    //扫描
//    UIButton *scanButton=[[UIButton alloc] initWithFrame:CGRectMake(270, yValue+80, 40, 40)];
//    [scanButton setBackgroundImage:[UIImage imageNamed:@"modelscan.png"] forState:UIControlStateNormal];
//    [scanButton addTarget:nil action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
//    scanButton.tag = scanViewTag;
//    [self.view addSubview:scanButton];
    
    // 功能模块
    [self initFunctionModules];
    
    // 广告模块
//    if (m_AdArray!=nil&&m_AdArray.count>0) {
//        [self updateCMSModuleA];
//    }
//    
//	[self setUniqueScrollToTopFor:m_ScrollView];
}

#pragma mark - 五个功能模块
-(void)initFunctionModules
{
    CGFloat yValueInScroll=120.0;
    UIView *moduleView=[[UIView alloc] initWithFrame:CGRectMake(0, yValueInScroll, 320, 100)];
    moduleView.tag=moduleTag;
    [self.main_ScrollView addSubview:moduleView];
    
    CGFloat xValue=10.0;
    CGFloat yValue=10.0;
    int i;
    for (i=0; i< 5; i++)
    {
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(xValue, yValue, MODEAL_IMAGE_WIDTH, MODEAL_IMAGE_HEIGHT)];
        [button setTag:100+i];
        NSString *moduleName;
        UIImage *image;
        switch (i)
        {
            case 0:
                moduleName=@"当季热销";
                image=[UIImage imageNamed:@"homeHot.png"];
                break;
                
            case 1:
                moduleName = @"对症找药";
                image = [UIImage imageNamed:@"homeYao.png"];
                break;
                
            case 2:
                moduleName = @"我的收藏";
                image = [UIImage imageNamed:@"homeFavorite.png"];
                break;
                
            case 3:
                moduleName = @"浏览历史";
                image = [UIImage imageNamed:@"homeHistory.png"];
                break;
                
            case 4:
                moduleName=@"物流查询";
                image=[UIImage imageNamed:@"homeLogistics.png"];
                break;
            default:
                break;
        }
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moduleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [moduleView addSubview:button];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(xValue-13, yValue+53, MODEAL_IMAGE_WIDTH+26, 30)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:moduleName];
        [label setFont:[UIFont systemFontOfSize:14.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [moduleView addSubview:label];
        
        xValue += 10 + MODEAL_IMAGE_WIDTH;
    }
    modelATable=[[UITableView alloc]initWithFrame:CGRectMake(0, yValueInScroll+200, 320, 750) style:UITableViewStylePlain];
    modelATable.delegate=self;
    modelATable.dataSource=self;
    modelATable.scrollEnabled=NO;
    [self.main_ScrollView addSubview:modelATable];
}

#pragma mark - 五个功能模块点击事件
//点击模块
-(void)moduleBtnClicked:(id)sender
{
    UIButton *  button=(UIButton*)sender;
    int index=[button tag]-100;
    switch (index)
    {
            
        case 0:
        {
            //热门推荐
//            [self removeSubControllerClass:[RecommendViewController class]];
//            RecommendViewController *recommendVC = [[[RecommendViewController alloc] initWithNibName:@"RecommendViewController" bundle:nil] autorelease];
//            [self pushVC: recommendVC animated:YES];
            break;
            
        }
        case 1:
        {
            //团购
//            [self enterIntoGroupList];
            break;
        }
            
        case 2:
        {
            //我的收藏
//            if ([GlobalValue getGlobalValueInstance].ywToken != nil)
//            {
//                MyFavorite *myFavorite = [[[MyFavorite alloc]initWithNibName:@"MyFavorite" bundle:nil] autorelease];
//                myFavorite->fromTag = FROM_HOMEPAGE_TO_FAVORITE;
//                [self pushVC:myFavorite animated:YES];
//            }
//            else
//            {
//                [SharedDelegate enterUserManageWithTag:15];
//            }
            break;
        }
        case 3:
        {
            //历史记录
//            [self removeSubControllerClass:[MyBrowse class]];
//            MyBrowse *browse=[[[MyBrowse alloc]initWithNibName:@"MyBrowse" bundle:nil] autorelease];
//            [self pushVC:browse animated:YES];
            break;
        }
        case 4:
        {
//            //物流查询
//            [self enterLogisticQuery];
            break;
        }
        default:
            break;
    }
}

#pragma mark EGORefreshTableHeaderView相关delegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    [self refreshHomePageData];
}

- (void)refreshHomePageData{
    
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return isRefreshingHotPage;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return [NSDate date];
}

#pragma mark   焦点图pageview相关delegate
- (void)pageView:(YWHomeHotPageView *)pageView pageChangedTo:(NSIndexPath *)indexPath{
}

- (void)pageView:(YWHomeHotPageView *)pageView didTouchOnPage:(NSIndexPath *)indexPath{
    
}

- (UIView *)pageView:(YWHomeHotPageView *)pageView pageAtIndexPath:(NSIndexPath *)indexPath{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageView.frame.size.width, pageView.frame.size.height)];
    NSInteger i=[indexPath row];
    if (i>=[hotTopPage.objList count]) {
        imageView.image = [UIImage imageNamed:@"defaultimg320x120.png"];
    }
    else
    {
        YWSpecialRecommendInfoData *SpecialRecommend = (YWSpecialRecommendInfoData*)[hotTopPage.objList objectAtIndex:i];
        NSString *hotProductImgUrlStr = SpecialRecommend.pic;
        //SDWEBiMAGE
        [imageView setImageWithURL:[NSURL URLWithString:hotProductImgUrlStr]];

    }
    return imageView;
}


- (NSInteger)numberOfPagesInPageView:(YWHomeHotPageView *)pageView {
    if (hotTopPage==nil || hotTopPage.objList==nil)
    {
        return 1;
    }
    return [hotTopPage.objList count];
}
 
#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_AdArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identify=@"cell";
    YWHomePageModelACell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil)
    {
        cell=[[YWHomePageModelACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.delegate = self;
    
    YWAdFloorInfoData *floor = m_AdArray[indexPath.row];
    if (floor && [floor isKindOfClass:[YWAdFloorInfoData class]])
    {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.isLeft = indexPath.row%2;
        cell.tag=indexPath.row;
        
        [cell adjustLeftright];
        YWSpecialRecommendInfoData *product = floor.bigPage;
        NSString *strPic = product.pic;
        [cell loadBigImg:strPic];
        
        [cell loadBtn:floor index:indexPath.row];
        
        [cell loadHeadBtn:floor];
    }
    return cell;
}

#pragma mark - 楼层小按钮点击事件入口
-(void)pushSmallBtn:(YWHomePageModelACell *)cell withCellIdent:(int)cellTag withBtnIndex:(int)btnTag{
    YWAdFloorInfoData *floor = [m_AdArray objectAtIndex:cellTag];
    if (floor == nil)
    {
        return;
    }
    
//    YWSpecialRecommendInfoData *specialRecommentInfo = floor.productList[btnTag];
//    if (specialRecommentInfo.type == kYaoSpecialCatagory)
//    {
//        NSString *content = specialRecommentInfo.content;
//        int catalogId = [[content substringFromIndex:10] intValue];
//        [self enterIntoCategoryList:catalogId];
//    }
}

#pragma mark - 适配ios7
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000

- (void) viewDidLayoutSubviews
{
    if (ISIOS7)
    {
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
    }
}
#endif

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
