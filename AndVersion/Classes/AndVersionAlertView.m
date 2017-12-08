//
//  AndVersionAlertView.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 05/10/2017.
//

#define AND_VERSION_TABLE_MARGIN 15.0f

#define AND_VERSION_HEADER_HEIGHT 50.0f
#define AND_VERSION_BUTTON_HEIGHT 44.0f
#define AND_VERSION_BUTTON_MARGIN 20.0f

#define AND_VERSION_MAX_TABLE_WIDTH 500.0f

#import "AndVersionAlertView.h"
#import "UILabel+Misc.h"
#import "UIButton+AndVersion.h"
#import "AndVersion.h"
#import "AndVersionConfiguration.h"

@interface AndVersionAlertView()<UITableViewDataSource, UITableViewDelegate>{
    AndVersionAlertViewType alertType;
    NSArray <NSString *> * whatsNewList;
}

@property (nonatomic) UITableView *table;
@property (nonatomic) UIView *bgView;

@property CGFloat maxTableHeight;
@property CGFloat actualTableHeight;

@property AndVersionConfiguration *configuration;

@end

@implementation AndVersionAlertView

-(void) show:(AndVersionAlertViewType)andVersionAlertViewType whatsNew:(NSArray <NSString *> *) whatsNew
{
    alertType = andVersionAlertViewType;
    whatsNewList = whatsNew;
    
    _configuration = [AndVersion sharedAndVersion].configuration;
    
    UIView* superview = [UIApplication sharedApplication].keyWindow;
    self.frame = superview.bounds;
    self.backgroundColor = [UIColor clearColor];
    
    [self addTransparentBackGroundView];
    [self createTable];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    [superview addSubview:self];
}

-(void) addTransparentBackGroundView{
    if(_bgView){
        return;
    }
    
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = _configuration.infoViewBacgroundColor;
    _bgView.alpha = _configuration.infoViewBacgroundAlpha;
    
    [self addSubview:_bgView];
}

-(void) createTable{
    _table = [[UITableView alloc] initWithFrame:[self createTableFrame] style:UITableViewStyleGrouped];
    
    _table.backgroundColor = [UIColor clearColor];
    _table.separatorColor = _configuration.infoViewTableSeperatorColor;
    _table.dataSource = self;
    _table.delegate = self;
    
    [self addSubview:_table];
}

- (CGRect) createTableFrame{
    _actualTableHeight = 0;
    
    CGFloat y = AND_VERSION_TABLE_MARGIN;
    CGFloat x = AND_VERSION_TABLE_MARGIN;
    CGFloat width = self.bounds.size.width - (2 * AND_VERSION_TABLE_MARGIN);
    
    _maxTableHeight = self.bounds.size.height - (2 * AND_VERSION_TABLE_MARGIN);
    
    if(width > AND_VERSION_MAX_TABLE_WIDTH){
        width = AND_VERSION_MAX_TABLE_WIDTH;
        x = (self.bounds.size.width - AND_VERSION_MAX_TABLE_WIDTH) / 2;
    }
    
    return CGRectMake(x, y, width, 200);
}

-(void) onOkButtonClicked:(UIButton*)sender
{
    [self removeFromSuperview];
}

-(void) onOpenItunesButtonClicked:(UIButton*)sender
{
    NSString *iTunesLink = [NSString stringWithFormat: @"itms://itunes.apple.com/us/app/apple-store/id%@", [[AndVersion sharedAndVersion] appStoreId]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

- (void) orientationChanged:(NSNotification *)note
{
    UIView* superview = [UIApplication sharedApplication].keyWindow;
    self.frame = superview.bounds;
    _bgView.frame = self.bounds;
    _table.frame = [self createTableFrame];
    
    [_table reloadData];
}

#pragma TABLE

#pragma TABLE HEADER

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AND_VERSION_HEADER_HEIGHT;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.lineBreakMode = NSLineBreakByTruncatingTail;
    lbl.numberOfLines=0;
    lbl.textColor = _configuration.infoViewTitleColor;
    lbl.font = _configuration.infoViewTitleFont;
    
    if(alertType == AndVersionAlertViewTypeNewVersion){
        lbl.text = [AndVersion sharedAndVersion].configuration.infoViewTitleForNewVersion;
    }else{
        lbl.text = [AndVersion sharedAndVersion].configuration.infoViewTitleForNeedUpdate;
    }
    
    return lbl;
}

#pragma TABLE FOOTER

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AND_VERSION_BUTTON_HEIGHT + 2 * AND_VERSION_BUTTON_MARGIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, AND_VERSION_BUTTON_HEIGHT + 2 * AND_VERSION_BUTTON_MARGIN)];
    
    CGFloat buttonY = AND_VERSION_BUTTON_MARGIN;
    CGFloat buttonX = AND_VERSION_BUTTON_MARGIN;
    
    if(alertType != AndVersionAlertViewTypeOptionalUpdate){
        CGFloat buttonWidth = tableView.frame.size.width - (2 * AND_VERSION_BUTTON_MARGIN);
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWidth, AND_VERSION_BUTTON_HEIGHT)];
        [btn configureButton:_configuration];
        
        if(alertType == AndVersionAlertViewTypeMandatoryUpdate){
            btn.backgroundColor = _configuration.infoViewUpdateButtonColor;
            [btn.titleLabel setTextColor:_configuration.infoViewUpdateButtonTextColor];
            [btn setTitle:[AndVersion sharedAndVersion].configuration.infoViewUpdateButtonTitle forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(onOpenItunesButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        }else{
            btn.backgroundColor = _configuration.infoViewOKButtonColor;
            [btn.titleLabel setTextColor:_configuration.infoViewOKButtonTextColor];
            [btn setTitle:[AndVersion sharedAndVersion].configuration.infoViewOKButtonTitle forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(onOkButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
        }
        
        [footerView addSubview:btn];
    }else{
        CGFloat buttonWidth = (tableView.frame.size.width - (3 * AND_VERSION_BUTTON_MARGIN)) / 2;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWidth, AND_VERSION_BUTTON_HEIGHT)];
        [btn configureButton:_configuration];
        
        btn.backgroundColor = _configuration.infoViewContinueButtonColor;
        [btn.titleLabel setTextColor:_configuration.infoViewContinueButtonTextColor];
        [btn setTitle:[AndVersion sharedAndVersion].configuration.infoViewContinueButtonTitle forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(onOkButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
        
        buttonX += buttonWidth + AND_VERSION_BUTTON_MARGIN;
        btn = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonWidth, AND_VERSION_BUTTON_HEIGHT)];
        [btn configureButton:_configuration];
        
        btn.backgroundColor = _configuration.infoViewUpdateButtonColor;
        [btn.titleLabel setTextColor:_configuration.infoViewUpdateButtonTextColor];
        [btn setTitle:[AndVersion sharedAndVersion].configuration.infoViewUpdateButtonTitle forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(onOpenItunesButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:btn];
    }
    
    return footerView;
}


/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TEST_SUMMARY_CONTROL_HEIGHTS;
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 10.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return whatsNewList.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TitleDetailTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        cell.textLabel.numberOfLines=0;
        cell.textLabel.textColor = _configuration.infoViewWhatsNewTextColor;
        cell.textLabel.font = _configuration.infoViewWhatsNewFont;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [whatsNewList objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self changeTableHeight:_table.contentSize.height + 80];
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    [self changeTableHeight:_table.contentSize.height];
}

-(void) changeTableHeight:(CGFloat) height{
    if(_actualTableHeight > height){
        return;
    }
    
    if(height < _maxTableHeight){
        _actualTableHeight = height;
        [_table setScrollEnabled:NO];
    }else{
        _actualTableHeight = _maxTableHeight;
        [_table setScrollEnabled:YES];
    }
    
    CGFloat tableY = ([[UIScreen mainScreen] bounds].size.height - _actualTableHeight) / 2;
    CGRect frame = CGRectMake(_table.frame.origin.x, tableY, _table.frame.size.width, _actualTableHeight);
    _table.frame = frame;
}

@end
