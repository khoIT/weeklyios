#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

-(IBAction)Clear{
    
}


-(IBAction)Update{

    NSMutableArray *partyScores = [[NSMutableArray alloc] init]; //Array of score to sort
    NSMutableArray *todayparties = [[NSMutableArray alloc] init]; //Array of best parties today
    NSMutableArray *tomorrowparties = [[NSMutableArray alloc] init]; //Array of best parties tomorrow
    NSMutableArray *data =[[NSMutableArray alloc] init]; //Array of object to hold data
    NSInteger numParties = 4;
    
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
            
                int numDisplay = 8; //number of parties to display
            
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
                    
                    //Add the party to today table
                    if (dataDay == day && dataMonth == month){
                        [todayparties addObject:name];
                    }
                    if (dataDay == day+1 && dataMonth == month){
                        [tomorrowparties addObject:name];
                    }
                    
                    [partyScores removeObjectAtIndex:index];
                    [data removeObjectAtIndex:index];
                    numDisplay--;
                }
            NSLog(@"%d",todayparties.count);
            
          
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        //Out put the parties to screen
        for(int i=0; i<numParties; i++){
            UILabel *label = [self valueForKey: [NSString stringWithFormat:@"today%d", i+1]];
            if(i < todayparties.count){
                [label setText:[NSString stringWithFormat:@"%d. %@",i+1,[todayparties objectAtIndex:i]]];
            } else {
                [label setText:[NSString stringWithFormat:@"%d. Unranked",i+1]];
            }
        }
        for(int i=0; i<numParties; i++){
            UILabel *label = [self valueForKey: [NSString stringWithFormat:@"tomorrow%d", i+1]];
            if(i < tomorrowparties.count){
                [label setText:[NSString stringWithFormat:@"%d. %@",i+1,[tomorrowparties objectAtIndex:i]]];
            } else {
                [label setText:[NSString stringWithFormat:@"%d. Unranked",i+1]];
            }
        }
    }];
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
