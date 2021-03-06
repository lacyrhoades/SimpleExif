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

@property (nonatomic, strong, readonly) NSMutableDictionary *exifDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary *tiffDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary *gpsDictionary;

- (void)addLocation:(CLLocation *)currentLocation;
- (void)addUserComment:(NSString *)comment;
- (void)addCreationDate:(NSDate *)date;
- (void)addDescription:(NSString *)description;
- (void)addProjection:(NSString *)projection;
- (void)addCameraMake:(NSString *)make;
- (void)addCameraModel:(NSString *)model;
- (void)addArtist:(NSString *)artist;

- (void)setValue:(NSString *)key forExifKey:(NSString *)value;

@end
