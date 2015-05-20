#import "SearchTableViewController.h"
#import "Result.h"

@interface SearchTableViewController ()

@property NSMutableArray *foundMovies;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //TODO: remove then
    self.label.text = self.titleToSearch;
    self.foundMovies = [[NSMutableArray alloc] init];
    [self fetchGreeting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fetchGreeting;
{
    NSString *url = @"";
    NSString *apiKey = @"8ec7476e88d48365fd343370b9947b76";
    NSString *baseUrl = @"http://api.themoviedb.org/3";
    NSString *searchPath = @"/search/movie";
    url = [url stringByAppendingString:baseUrl];
    url = [url stringByAppendingString:searchPath];
    url = [url stringByAppendingString:@"?query="];
    url = [url stringByAppendingString:self.titleToSearch];
    url = [url stringByAppendingString:@"&api_key="];
    url = [url stringByAppendingString:apiKey];
    
    NSURL *searchUrl = [NSURL URLWithString:url];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"string url" message:url delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:searchUrl];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *searchResult = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             self.label.text = [[searchResult objectForKey:@"total_results"] stringValue];
             
             NSArray *results = [searchResult objectForKey:@"results"];
             
             for (int i = 0; i < results.count; i++) {
                 Result *result = [[Result alloc] init];
                 result.originalTitle = [results[i] objectForKey:@"original_title"];
                 
                 NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                 [formatter setDateFormat:@"yyyy-MM-dd"];
                 result.releaseDate = [formatter dateFromString:[results[i] objectForKey:@"release_date"]];
                 
                 [self.foundMovies addObject: result];
             }
             [self.tableView reloadData];
         }
     }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foundMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell" forIndexPath:indexPath];
    
    Result *result = self.foundMovies[indexPath.row];
    cell.textLabel.text = [result originalTitle];
    
    return cell;
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"MovieSelected"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedResult = self.foundMovies[indexPath.row];
    }
}


@end
