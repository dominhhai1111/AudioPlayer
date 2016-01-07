//
//  Music.m
//  ModelViewController4
//
//  Created by Do Minh Hai on 12/28/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "Music.h"
//#import "DataManager.h"
//#import "VSModel.h"
#import "ViewController.h"
#import "Songs.h"
#import "Topic.h"
#import "TopicData.h"
#import "UIColor+Extend.h"
@interface Music ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

//@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation Music
/*
{
    DataManager* dataManager;
}
 */
{
  
    NSArray* arrayTopic;
    NSMutableArray* filteredNames;
    BOOL isFiltered ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     UIColor* textColor = [[UIColor alloc] initWithHex:@"#1693A7" alpha:1.0];
    //[self presentViewController:viewController animated:YES completion:nil];
    filteredNames = [[NSMutableArray alloc] init];
    arrayTopic = [[TopicData sharedData] arrayTopic];
   
    [self.searchBar sizeToFit];
    self.searchBar.delegate=self;
    [self.searchBar setBackgroundColor:textColor];
    /*
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView=self.searchController.searchBar;
    self.searchController.searchResultsUpdater=self;
    self.searchController.searchBar.delegate= self;
 */
   // dataManager = [DataManager getSingleton];
    
    // Do any additional setup after loading the view.
    
   //  tap = [[UITapGestureRecognizer alloc] initWithTarget:self
   //                                                action:@selector(changeView:)];
    /*
    [self.tableVie addGestureRecognizer:tap]
     */
}

-(NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    if (isFiltered== TRUE) {
        if (filteredNames.count > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    return arrayTopic.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isFiltered==TRUE) {
        if (filteredNames.count > 0) {
            return [filteredNames count];
        } else {
            return 0;
        }
    }
    Topic *topic = arrayTopic[section];
    return topic.arraySongs.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    /*
    VSModel* model = dataManager.data[indexPath.row];
    cell.textLabel.text=model.album_name;
    cell.detailTextLabel.text=model.singer;
    cell.imageView.image=model.photo;
    */
    if (isFiltered==TRUE && filteredNames.count > 0) {
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:filteredNames[indexPath.row]];
        NSRange range = [filteredNames[indexPath.row] rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.textLabel.attributedText = attributedText;
        
        for (Topic*topic in arrayTopic) {
            for (Songs*song in topic.arraySongs) {
                if (song.name == filteredNames[indexPath.row]) {
                    cell.textLabel.text=song.name;
                    cell.detailTextLabel.text=song.singer;
                    cell.imageView.image=song.photo;
                    //[cell addGestureRecognizer:tap];
                    return cell;
                }
            }
        }
        
    }

    Topic* topic = arrayTopic[indexPath.section];
    Songs* song = topic.arraySongs[indexPath.row];
    cell.textLabel.text=song.name;
    cell.detailTextLabel.text=song.singer;
    cell.imageView.image=song.photo;
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (isFiltered==TRUE) {
        return nil;
    }
    Topic* topic= arrayTopic[section];
    return topic.name;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    //backgroundColor
     UIColor* textColor = [[UIColor alloc] initWithHex:@"#1693A7" alpha:1.0];
    
    view.tintColor= textColor;
    
    //text color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView*)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
#pragma mark- Search Results Updating
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    //[filteredNames removeAllObjects];
    //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self beginswith [c] %@",self.searchController.searchBar.text];
    if(text.length == 0)
    {
        isFiltered = FALSE;
        [searchBar resignFirstResponder];
    }
    else
    {
        isFiltered = TRUE;
    filteredNames = [[NSMutableArray alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [c] %@",self.searchBar.text];
    
    for (Topic*topic in arrayTopic) {
        for (Songs*song in topic.arraySongs) {
            NSArray *array=@[song.name] ;
            NSArray *matches = [array filteredArrayUsingPredicate:predicate];
            [filteredNames addObjectsFromArray:matches];

        }
           }
     
    //filteredNames = [arrayTopic filteredArrayUsingPredicate:predicate];
    }
    [self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    isFiltered = FALSE;
    [self.tableView reloadData];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController*  viewController= (ViewController*)segue.destinationViewController;
    if (isFiltered) {
          NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        for (Topic*topic in arrayTopic) {
            for (Songs*song in topic.arraySongs) {
                if (song.name == filteredNames[selectedIndexPath.row]) {
                    viewController.song = song;
                }
            }
        }
    }else{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    Topic* topic = arrayTopic[selectedIndexPath.section];
    Songs* song = topic.arraySongs[selectedIndexPath.row];
    viewController.song = song;
    }
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSong"]) {
        NSIndexPath *indexPath = nil;
       // Recipe *recipe = nil;
        
        if (self.searchController.searchBar.text.length > 0 && filteredNames.count > 0) {
           // indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
          //  recipe = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
          //  recipe = [recipes objectAtIndex:indexPath.row];
        }
         [self presentViewController:viewController animated:YES completion:nil];
       // RecipeDetailViewController *destViewController = segue.destinationViewController;
       // destViewController.recipe = recipe;
    }
}
 let candy: Candy
 if searchController.active && searchController.searchBar.text != "" {
 candy = filteredCandies[indexPath.row]
 } else {
 candy = candies[indexPath.row]
 }
 */
/*
#pragma mark - UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataManager.data.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    VSModel* model = dataManager.data[indexPath.row];
    cell.textLabel.text=model.album_name;
    cell.detailTextLabel.text=model.singer;
    cell.imageView.image=model.photo;
    return cell;
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
