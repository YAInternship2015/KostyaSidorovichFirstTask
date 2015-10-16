//
//  WODSignature.h
//  
//
//  Created by Woddi on 19.09.15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WODSignature : NSManagedObject

@property (nonatomic, retain) NSString *pictureSignature;
@property (nonatomic, retain) NSString *pictureNamed;
@property (nonatomic, retain) NSString *pictureIdNamed;
@property (nonatomic, retain) NSDate *currentDate;

@end
