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
-(id)grabNote:(id) noteTextView;
- (NSString*)loadFromFile;

@end
