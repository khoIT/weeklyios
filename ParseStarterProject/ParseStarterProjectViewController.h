@interface ParseStarterProjectViewController : UIViewController{
    
    //Today's Parties
    IBOutlet UILabel *today1;
    IBOutlet UILabel *today2;
    IBOutlet UILabel *today3;
    IBOutlet UILabel *today4;
    
    //Tomorrow's Parties
    IBOutlet UILabel *tomorrow1;
    IBOutlet UILabel *tomorrow2;
    IBOutlet UILabel *tomorrow3;
    IBOutlet UILabel *tomorrow4;
    
    //Header Text
    IBOutlet UILabel *tomorrowLabel;
    IBOutlet UILabel *todayLabel;
    IBOutlet UILabel *IntroLabel;
    
    //The two buttons at the bottom of the page
    IBOutlet UIButton *Clear;
    IBOutlet UIButton *Update;
    
}

-(IBAction)Update;
-(IBAction)Clear;

@end
