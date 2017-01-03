#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utility : NSObject

+(void) getRequestServerWith :(NSDictionary *) parameters :(NSString * ) url  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)postRequestServerWith :(NSDictionary *) parameters :(NSString * ) url  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void) postMultiPartequestServerWith: (NSString *) imageParameterName :(NSString *) imagename :(UIImage *) image :(NSDictionary *) parameters :(NSString * ) url  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+(UIAlertView *) toast :(NSString *) message ;
+ (void)toasted:(NSTimer *)timer;
+(UIStoryboard *) getStoryBoard;
+(UIImage *)resizeImage:(UIImage *)image;
@end
