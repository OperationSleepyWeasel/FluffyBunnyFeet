#import <UIKit/UIKit.h>
#import "Result.h"

@interface SearchTableViewController : UITableViewController

@property (strong, nonatomic) NSString *titleToSearch;

@property Result *selectedResult;

@end
