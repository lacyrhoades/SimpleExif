//
//  ExifContainer.m
//  Pods
//
//  Created by Nikita Tuk on 02/02/15.
//
//

#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>
#import "ExifContainer.h"

NSString const * kCGImagePropertyProjection = @"ProjectionType";

@interface ExifContainer ()

@property (nonatomic, strong) NSMutableDictionary *exifDictionary;
@property (nonatomic, strong) NSMutableDictionary *tiffDictionary;
@property (nonatomic, strong) NSMutableDictionary *gpsDictionary;

@end

@implementation ExifContainer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.exifDictionary = [[NSMutableDictionary alloc] init];
        self.tiffDictionary = [[NSMutableDictionary alloc] init];
        self.gpsDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addLocation:(CLLocation *)currentLocation {
    CLLocationDegrees latitude  = currentLocation.coordinate.latitude;
    CLLocationDegrees longitude = currentLocation.coordinate.longitude;

    NSString *latitudeRef = nil;
    NSString *longitudeRef = nil;

    if (latitude < 0.0) {

        latitude *= -1;
        latitudeRef = @"S";

    } else {

        latitudeRef = @"N";

    }

    if (longitude < 0.0) {

        longitude *= -1;
        longitudeRef = @"W";

    } else {

        longitudeRef = @"E";

    }

    self.gpsDictionary[(NSString*)kCGImagePropertyGPSTimeStamp] = [self getUTCFormattedDate:currentLocation.timestamp];

    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLatitudeRef] = latitudeRef;
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLatitude] = [NSNumber numberWithFloat:latitude];

    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLongitudeRef] = longitudeRef;
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSLongitude] = [NSNumber numberWithFloat:longitude];

    self.gpsDictionary[(NSString*)kCGImagePropertyGPSDOP] = [NSNumber numberWithFloat:currentLocation.horizontalAccuracy];
    self.gpsDictionary[(NSString*)kCGImagePropertyGPSAltitude] = [NSNumber numberWithFloat:currentLocation.altitude];
}

- (void)addUserComment:(NSString*)comment {
    NSString *key = kCGImagePropertyExifUserComment;
    [self setValue:comment forExifKey:key];
}

- (void)addCreationDate:(NSDate *)date {
    NSString *dateString = [self getUTCFormattedDate:date];
    NSString *key = kCGImagePropertyExifDateTimeOriginal;
    [self setValue:dateString forExifKey:key];
}

- (void)addDescription:(NSString*)description {
    [self setValue:description forTiffKey:kCGImagePropertyTIFFImageDescription];
}

- (void)addProjection:(NSString *)projection {
    [self setValue:projection forExifKey:kCGImagePropertyProjection];
}

- (void)addCameraMake:(NSString *)make {
    [self setValue:make forTiffKey:kCGImagePropertyTIFFModel];
}

- (void)addCameraModel:(NSString *)model {
    [self setValue:model forTiffKey:kCGImagePropertyTIFFMake];
}

- (void)addArtist:(NSString *)artist {
    [self setValue:artist forTiffKey:kCGImagePropertyTIFFArtist];
}

- (void)setValue:(NSString *)key forExifKey:(NSString *)value {
    [self.exifDictionary setObject:value forKey:key];
}

- (void)setValue:(NSString *)key forTiffKey:(NSString *)value {
    [self.tiffDictionary setObject:value forKey:key];
}

#pragma mark - Helpers

- (NSString *)getUTCFormattedDate:(NSDate *)localDate {
    static NSDateFormatter *dateFormatter = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];

    });


    return [dateFormatter stringFromDate:localDate];
}

@end
