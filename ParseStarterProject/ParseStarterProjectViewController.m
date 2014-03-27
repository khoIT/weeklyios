#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

-(IBAction)Clear{
    
}


-(IBAction)Update{

    NSMutableArray *partyScores = [[NSMutableArray alloc] init]; //Array of score to sort
    NSMutableArray *displayparties = [[NSMutableArray alloc] init]; //Array of name to display
    NSMutableArray *data =[[NSMutableArray alloc] init]; //Array of object to hold data

    PFQuery *query = [PFQuery queryWithClassName:@"Todo"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);

            // Circle through all the objects from the query
            for (PFObject *object in objects) {
                
                //Adding all the objects and score
                [data addObject:object];
                [partyScores addObject:[NSNumber numberWithInteger:[object[@"FratScore"] intValue]]];            }
            
                int numDisplay = 4; //number of parties to display
            
                while(numDisplay>=1){
                    
                    NSNumber *max = [partyScores valueForKeyPath:@"@max.self"];
                    NSUInteger index = [partyScores indexOfObject:max]; //position of party with highest score
                    NSString *name = [data objectAtIndex:index][@"FratName"];
                    
                    //Format system's date
                    NSDate *date = [NSDate date];
                    NSCalendar *gregorian = [NSCalendar currentCalendar];
                    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
                    NSInteger day = [dateComponents day];
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"M"];
                    NSInteger month = [[formatter stringFromDate:date] intValue];
                    
                    //Format data's date
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    [df setDateFormat:@"MMM"];
                    NSDate *aDate = [df dateFromString:[data objectAtIndex:index][@"PartyDateMonth"]];
                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:aDate];
                    NSInteger dataMonth = [components month];
                    NSInteger dataDay = [[data objectAtIndex:index][@"PartyDateDay"] intValue];
                    
                    //If the system date is the same with data's date, add the party to display table
                    if (dataDay == day && dataMonth == month){
                        [displayparties addObject:name];
                        NSLog(@"The current name is %@,%d,%@",[displayparties lastObject],data.count,[data objectAtIndex:index][@"FratScore"]);
                        
                    }
                    [partyScores removeObjectAtIndex:index];
                    [data removeObjectAtIndex:index];
                    numDisplay--;
                }
                
                [today1 setText:[NSString stringWithFormat:@"1. %@", [displayparties objectAtIndex:0]]];
                [today2 setText:[NSString stringWithFormat:@"2. %@", [displayparties objectAtIndex:1]]];
                [today3 setText:[NSString stringWithFormat:@"3. %@", [displayparties objectAtIndex:2]]];
                [today4 setText:[NSString stringWithFormat:@"4. %@", [displayparties objectAtIndex:3]]];
                
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
