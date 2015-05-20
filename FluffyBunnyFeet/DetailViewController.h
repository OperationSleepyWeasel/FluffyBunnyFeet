#import <UIKit/UIKit.h>
#import "MovieEntry.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) MovieEntry *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

