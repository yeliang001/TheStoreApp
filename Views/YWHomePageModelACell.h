//
//  HomePageModelACell.h
//  TheStoreApp
//
//  Created by yuan jun on 13-1-15.
//
//

#import <UIKit/UIKit.h>
#import "YWAdFloorInfoData.h"
#import "YWSpecialRecommendInfoData.h"

@protocol HomePageModelACellDelegate;

@interface YWHomePageModelACell : UITableViewCell
{
    UIImageView*adBg;
    NSArray* keywordsArray;
    UIImageView* bigImg;
    UIView* promotionImg;
    
    UIButton *headBtn;
    
    BOOL isLeft;
    __weak id <HomePageModelACellDelegate>delegate;
}

@property(nonatomic,weak)id <HomePageModelACellDelegate>delegate;
@property(nonatomic,strong)NSArray* keywordsArray;
@property(nonatomic,assign)BOOL isLeft;
- (void)freshCell:(int)tag style:(int)style title:(NSString*)title;
-(void)loadBigImg:(NSString*)bigImgStr;
-(void)loadFistImg:(NSString*)firstImgStr title:(NSString*)title subTitle:(NSString*)subtit;
-(void)loadsecondImg:(NSString*)secondImgStr title:(NSString*)title subTitle:(NSString*)subtit;
-(void)loadBtn:(YWAdFloorInfoData *)floor index:(int)index;
-(void)loadHeadBtn:(YWAdFloorInfoData *)floor;
@end
@protocol HomePageModelACellDelegate <NSObject>
-(void)keywordBtnSelceted:(UIButton*)button type:(int)type;
-(void)promotionTapcell:(YWHomePageModelACell*)cell withIdenty:(int)tag;
-(void)pushSmallBtn:(YWHomePageModelACell*)cell withCellIdent:(int)cellTag withBtnIndex:(int)btnTag;
-(void)pushHeadBtn:(YWHomePageModelACell*)cell;
@end