//
//  ExifContainer.h
//  Pods
//
//  Created by Nikita Tuk on 02/02/15.
//
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface ExifContainer : NSObject

- (void)addLocation:(CLLocation *)currentLocation;
- (void)addUserComment:(NSString *)comment;
- (void)addCreationDate:(NSDate *)date;
- (void)addDescription:(NSString *)description;
- (void)addProjection:(NSString *)projection;
- (void)addLensModel:(NSString *)model;
- (void)addLensMake:(NSString *)make;
- (void)addArtist:(NSString *)artist;

- (void)setValue:(NSString *)key forExifKey:(NSString *)value;

- (NSDictionary *)exifData;
@end
