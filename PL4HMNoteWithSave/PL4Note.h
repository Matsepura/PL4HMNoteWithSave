//
//  PL4Note.h
//  PL4HMNoteWithSave
//
//  Created by Semen on 22.07.15.
//  Copyright (c) 2015 Semen Matsepura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PL4Note : NSObject

- (NSString *) writeDate;
#warning судя по коду сюда передается строка, так поменяйте тип с id на NSString
#warning так же я бы изменил название аргумента в методе на что-то созвучное со словом Note или текст, например
-(id)grabNote:(id) noteTextView;
- (NSString*)loadFromFile;

@end
