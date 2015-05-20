#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController

@property (strong, nonatomic) NSString *titleToSearch;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
