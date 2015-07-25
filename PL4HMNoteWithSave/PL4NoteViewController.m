//
//  PL4NoteViewController.m
//
//
//  Created by Semen on 22.07.15.
//
//

#import "PL4NoteViewController.h"
#import "PL4Note.h"


@interface PL4NoteViewController ()

@property (weak, nonatomic) IBOutlet UITextField *noteNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteRecordingTextView;
@property (assign, nonatomic) NSInteger countOfPushReturn;

@end

@implementation PL4NoteViewController


- (IBAction)saveNote:(id)sender {
    PL4Note *save = [PL4Note new];
    [save grabNote:self.noteRecordingTextView.text];
    
}
- (IBAction)downloadNote:(id)sender {
    PL4Note *save = [PL4Note new];
    self.noteRecordingTextView.text = [save loadFromFile];
    self.noteNameTextField.text = @"Сохраненная заметка";
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.noteRecordingTextView forKey:@"note"];
}


//- (id)initWithCoder:(NSCoder *)aDecoder{
//{
//    self = [super init];
//    if (self) {
//        _noteRecordingTextView = [aDecoder decodeObjectForKey:@"note"];
//    }
//    return self;
//}
//
//}

// метод для перехода по кнопке return от noteNameTextField к noteRecordingTextView
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.noteRecordingTextView becomeFirstResponder];
    return YES;

}

// метод скрываиня клавиатуры по нажатию кнопки return в noteRecordingTextView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    PL4Note *new = [[PL4Note alloc] init];
    if (textView == self.noteRecordingTextView) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            if (_countOfPushReturn < 1) {
                NSString *allInOne = [NSString stringWithFormat:@"%@ \n%@", [new writeDate],textView.text ];
                 textView.text = allInOne;
            }
            _countOfPushReturn++;
            return NO;

        }
    }
    return YES;
}

-(void)setup{
    [self.noteNameTextField setDelegate:self];
    [self.noteRecordingTextView setDelegate:self];
}

//-(void) goBackString{
//    NSString *backString = [NSString stringWithFormat:@"bla bla bla"];
//    //не работает!!!
//    
//    NSArray *oneFromString = [[NSArray alloc] initWithContentsOfFile:backString];
//    NSLog(@"123");
//    for (NSString *string in oneFromString) {
//        NSLog(@"array%@", string);
//    }
//    NSLog(@"321");
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
//    [self goBackString];

//    [self textFieldShouldReturn:self.noteNameTextField];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
