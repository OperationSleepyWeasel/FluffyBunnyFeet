#import <UIKit/UIKit.h>
#import "Result.h"

@interface SearchTableViewController : UITableViewController

@property (strong, nonatomic) NSString *titleToSearch;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property Result *selectedResult;

@end
