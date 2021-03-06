//
//  MDSearchBar.m
//  SearchBarProject
//
//  Created by Alexander on 12.11.13.
//  Copyright (c) 2013 ООО "МД технолоджис". All rights reserved.
//

#import "MDSearchBarController.h"

@implementation MDSearchBarController

@synthesize active = _active;




-(id)init{
    if (self = [super init]){
        self.searchBarView = [MDSearchBar view];
        self.searchView = [MDSearchView view];
        self.searchBarView.searchController = self;
        self.searchView.searchController = self;
        self.isValid = NO;
        [self.searchBarView initlayout];
    }
    return self;
}


-(void)setActive:(BOOL)active{
    _active = active;
    [self.searchBarView activateSearch:active];
    if (active){
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        CGRect windFrame = [self.searchBarView.superview convertRect:self.searchBarView.frame toView:window];
        //self.searchView.frame = CGRectMake(windFrame.origin.x, windFrame.origin.y+windFrame.size.height, windFrame.size.width, window.frame.size.height - windFrame.origin.y+windFrame.size.height);
        int number = 1;//[self.delegate tableView:self.searchView.searchTable numberOfRowsInSection:0];
        self.searchView.frame = CGRectMake(windFrame.origin.x, windFrame.origin.y+windFrame.size.height, windFrame.size.width, number * 40);

        self.searchView.alpha = 0;
        [window addSubview:self.searchView];
        [UIView animateWithDuration:0.3 animations:^{
            self.searchView.alpha = 1;
        }];
        
    }else{
        [self.searchBarView.textField resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            self.searchView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.searchView removeFromSuperview];
        }];
        
        
    }
}



#pragma MDSearchBarViewControllerDelegate


#pragma UITableViewDelegate & DataSource
    
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if ([self.delegate respondsToSelector:_cmd]){
//        return [self.delegate numberOfSectionsInTableView:tableView];
//    }
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:_cmd]){
        int number = [self.delegate tableView:tableView numberOfRowsInSection:section];
        self.searchView.searchTable.hidden = number>0 ? NO : YES;
        //self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, self.searchView.frame.origin.y, self.searchView.frame.size.width, number * 40);
        self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, (389-self.searchView.frame.size.height - self.searchBarView.frame.size.height), self.searchView.frame.size.width, number * 40);
//        int height = self.searchBarView.frame.origin.y - self.searchView.frame.size.height;
        NSLog([NSString stringWithFormat:@"%f",self.searchView.frame.size.height]);
        NSLog([NSString stringWithFormat:@"%f",self.searchView.frame.origin.y]);
//        if(height < 0)
//            height = self.searchView.frame.size.height;
//        self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, height, self.searchView.frame.size.width, number * 40);

        return number;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:_cmd]){
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:_cmd]){
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.delegate respondsToSelector:_cmd]){
        return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:_cmd]){
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:_cmd]){
        return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
   // return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
}


#pragma TextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (!self.active)
    self.active = YES;
    
    if ([self.delegate respondsToSelector:@selector(searchBar:searchWithText:)]){
        [self.delegate searchBar:self searchWithText:self.searchBarView.textField.text];
    }
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchBar:searchWithText:)]){
        [self.delegate searchBar:self searchWithText:self.searchBarView.textField.text];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.delegate respondsToSelector:@selector(searchBar:searchWithText:)]){
        [self.delegate searchBar:self searchWithText:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    }
    return YES;
}



-(void)reloadData{
    [self.searchView.searchTable reloadData];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBarView.textField resignFirstResponder];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length>0){
        [self.searchBarView.textField resignFirstResponder];
    }else{
        self.active = NO;
    }
    return YES;
}



@end
