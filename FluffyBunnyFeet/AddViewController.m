#import "AddViewController.h"
#import "SearchTableViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *searchWebButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];	
    // Do any additional setup after loading the view.
    self.searchWebButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.searchWebButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToList:(UIStoryboardSegue *) segue {
    SearchTableViewController * source = [segue sourceViewController];
    Result * selectedResult = source.selectedResult;
    if (selectedResult != nil) {
        self.titleField.text = selectedResult.originalTitle;
        self.yearField.text = selectedResult.originalTitle;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"searchFromWebSegue"]) {
        NSString *titleToSearch = self.titleField.text;
        SearchTableViewController *controller = (SearchTableViewController *)[[segue destinationViewController] topViewController];
        controller.titleToSearch=titleToSearch;
        return;
    }
    if (sender != self.saveButton) return;
    if (self.titleField.text.length > 0) {
        self.entry = [[MovieEntry alloc] init];
        self.entry.title = self.titleField.text;
        self.entry.year = self.yearField.text.intValue;
    }
}
@end
