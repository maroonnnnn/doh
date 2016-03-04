//
//  NewsCell.m
//  Simply_Weather
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 maroonnnnn. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+AFNetworking.h"

@implementation NewsCell

+ (NewsCell *)newsCellTableView:(UITableView *)tableView model:(NewsModel *)model{
    
    static NSString *cellID = @"NEWSCELL";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil] lastObject];
    }

    [cell.pic setImageWithURL:[NSURL URLWithString:model.pic]];
    cell.title.text = model.title;
    cell.intro.text = model.intro;
    cell.comment.text = model.comment;
    //cell被选中时无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
