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

// метод для перехода по кнопке return от noteNameTextField к noteRecordingTextView
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
#warning вот эта строка не нужна т.е. когда вы сообщаете кому-то becomeFirstResponder, то этот кто-то автоматом становится респондером. А респондером может быть лишь один обьект, поэтому предыдущий респондер перестает быть респондером автоматически
    [textField resignFirstResponder];
    
    [self.noteRecordingTextView becomeFirstResponder];
    return YES;

}

#warning старайтесь более сжато передавать информацию. Программисту понятно, что это метод. Пишите только суть, я бы написал так: Перекинем фокус в поле ввода ниже,  
// метод скрываиня клавиатуры по нажатию кнопки return в noteRecordingTextView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
#warning зачем тут инитить записку при каждом новом вводе символа?  Может переместить эту инициализацию куда-то внутрь условия?
    PL4Note *new = [[PL4Note alloc] init];
    
#warning старайтесь избегать вложенности с ифами, например проверяя какое-то условие, и, если оно не выполнилось, просто выходите из метода типа такого:
    
    //раскомментируйте строки с 58 по 71 ( cmd + / ) и закомментируйте с 75 по 86
//    if (textView != self.noteRecordingTextView) {
//        return YES;
//    }
//    if ( ! [text isEqualToString:@"\n"]) {
//        return YES;
//    }
//    
//    [textView resignFirstResponder];
//    if (_countOfPushReturn < 1) {
//        NSString *allInOne = [NSString stringWithFormat:@"%@ \n%@", [new writeDate],textView.text ];
//        textView.text = allInOne;
//    }
//    _countOfPushReturn++;
//    return NO;
    
    
    
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


#warning вот этих вот всех комментариев быть не должно сотрите это
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
#warning еще лишний код. Его стоит убрать
//    [self goBackString];

//    [self textFieldShouldReturn:self.noteNameTextField];
    // Do any additional setup after loading the view.
}


#warning все, что ниже, слудет удалить
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
