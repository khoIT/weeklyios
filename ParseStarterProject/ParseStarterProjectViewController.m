#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

-(IBAction)Clear{
    
}


-(IBAction)Update{

    //frat name array
    NSMutableArray *parties = [[NSMutableArray alloc] init];
    //frat score array
    NSMutableArray *partyScores = [[NSMutableArray alloc] init];
    NSMutableArray *displayparties = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Todo"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            
            int maxFinder = -1;
            
            for (PFObject *object in objects) {
                
                //how to add the the arraylists
                //partyArray is defined in the ParseStarterPorj...h
                [parties addObject:object[@"FratName"]];
                
                int i;
                NSString* string = object[@"FratScore"];
                i = [string intValue];
                NSLog(@"Number %i: Party %@ has score %i", [parties count], object[@"FratName"],i);
                
                //add the frat scores to a separate list
                //by doing this, we can find out the top frat
                //by getting the cell number
                //of the highest score in the list
                //this use the cell number to find
                //the name of the frat in partyArray
                
                [partyScores addObject:[NSNumber numberWithInteger:i]];
                
            }
            
            NSLog(@"The top score is %i", maxFinder);
            
            int numDisplay = 4; //number of parties to display
            
            while(numDisplay>=1){
                NSNumber *max = [partyScores valueForKeyPath:@"@max.self"];
                
                NSUInteger index = [partyScores indexOfObject:max];
                NSString *name = [parties objectAtIndex:index];

                //check if the system date is the same with party's date
                [displayparties addObject:name];
                
                [partyScores removeObjectAtIndex:index];
                [parties removeObjectAtIndex:index];
                numDisplay--;
            }
            
            [today1 setText:[NSString stringWithFormat:@"1. %@", [displayparties objectAtIndex:0]]];
            [today2 setText:[NSString stringWithFormat:@"2. %@", [displayparties objectAtIndex:1]]];
            [today3 setText:[NSString stringWithFormat:@"3. %@", [displayparties objectAtIndex:0]]];
            [today4 setText:[NSString stringWithFormat:@"4. %@", [displayparties objectAtIndex:1]]];
            
            
        

            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        

        
    }];


    
    //.text needs a label to remember and reference to
//    NSString *saveString = .text;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:saveString forKey:@"saveString"];
//    [defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
