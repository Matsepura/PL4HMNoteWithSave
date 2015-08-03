//
//  PL4Note.m
//  PL4HMNoteWithSave
//
//  Created by Semen on 22.07.15.
//  Copyright (c) 2015 Semen Matsepura. All rights reserved.
//

#import "PL4Note.h"

@interface PL4Note ()

@property (strong, nonatomic) id note;

@end

@implementation PL4Note

#pragma mark - write Data

- (NSString *) writeDate{
    NSDate *dateNow = [[NSDate alloc] init];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeStyle:NSDateFormatterMediumStyle];
    [format setDateStyle:NSDateFormatterMediumStyle];
    NSString *string = [format stringFromDate:dateNow];
    return string;
}

#pragma mark - saveYourNote

-(id)grabNote:(id) noteTextView{
//    NSString *note = [NSString new];
    self.note = noteTextView;
    
    //Этот метод у вас возвращает путь к файлу.
    //Зачем его вызывать и не принимать от него никакого результата?? в этом нет смысла
    [self fileName];
    
    [self saveToFile];
    NSLog(@"сохранялка работает");
    return _note;
}

#warning получается, что у вас любая заметка пишется в одно и то же место
#warning добавьте к note поле name или id  или что-то в этом роде чтоб генерить путь на основе этого параметра свой для каждой заметки

- (NSString *)fileName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *cachePath = [paths objectAtIndex:0];
    
    
    
    BOOL isDir = NO;
    
    NSError *error;
    
    
#warning эту проверку я бы запихал в метод saveToFile т.к. назначение текущего метода тупо вернуть путь к файлу
    if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir == NO) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
    }

    
    return [NSString stringWithFormat:@"%@/mynotes.data", cachePath];
    
}

-(void)saveToFile {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[self note]];
    [data writeToFile:[self fileName] atomically:NO];
}

-(void)generatedAndSave{
#warning снова лишняя строка
    [self fileName];
    
    
    [self saveToFile];
}

- (NSString*)loadFromFile {
    NSData *data = [NSData dataWithContentsOfFile: [self fileName]];
     self.note = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (!self.note) {
        self.note = [PL4Note new];
    }
    NSLog(@"загрузка пашет");
    //Здесь
    NSString *string = [NSString stringWithFormat:self.note];
    return string;

}





@end
