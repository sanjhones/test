
#import "Utility.h"
@implementation Utility
UIView *panelU;NSInteger numberOfSpinnersU;
+(void) getRequestServerWith :(NSDictionary *) parameters :(NSString * ) url  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"GET: %@\nPARAMETERS: %@", url, parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]] && [[responseObject valueForKey:@"status"] intValue] == 1)
        {
            NSError * error = [[NSError alloc] initWithDomain:@"Error" code:0 userInfo:responseObject];
            failure(error);
        }
        else if (success)
            success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if (failure)
             failure(error);
     }];
}
+ (void)postRequestServerWith :(NSDictionary *) parameters :(NSString * ) url  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"POST: %@\nPARAMETERS: %@", url, parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if([responseObject isKindOfClass:[NSDictionary class]] && [[responseObject valueForKey:@"status"] intValue] == 1)
         {
             NSError * error = [[NSError alloc] initWithDomain:@"Error" code:0 userInfo:responseObject];
             failure(error);
         }
         else if (success)
             success(responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if (failure)
             failure(error);
     }];
}
+ (void) postMultiPartequestServerWith: (NSString *) imageParameterName :(NSString *) imagename :(UIImage *) image :(NSDictionary *) parameters :(NSString * ) url  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSData *pngData = UIImagePNGRepresentation(image);
    NSData *syncResData;
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.timeoutInterval = 20.0;
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/536.26.14 (KHTML, like Gecko) Version/6.0.1 Safari/536.26.14" forHTTPHeaderField:@"User-Agent"];
    
    NSMutableData *body = [NSMutableData data];
    if(parameters != nil)
    {
        for (NSString *param in parameters) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    // [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"file.png\"\r\n", imageParameterName] dataUsingEncoding:NSUTF8StringEncoding]];
    if(imagename)
    {
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", imageParameterName,imagename] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[NSData dataWithData:pngData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
    NSError *error = nil;
    NSURLResponse *responseStr = nil;
    syncResData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseStr error:&error];
    if(!error)
        success([NSJSONSerialization JSONObjectWithData:syncResData options:0 error:&error]);
    else
        failure(error);
}
UIAlertView * toast;
+(UIAlertView *) toast :(NSString *) message {
    toast = [[UIAlertView alloc] initWithTitle:@"Test Message" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, 40, 40)];
    image.image = [UIImage imageNamed:@"logo-profile"];
    [toast addSubview:image];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(toasted:) userInfo:nil repeats:NO];
    if(!toast.visible)
        return toast;
    else
    {
        sleep(60);
        return toast;
    }
}
+ (void)toasted:(NSTimer *)timer {
    [toast dismissWithClickedButtonIndex:0 animated:YES];
}
+(UIStoryboard *) getStoryBoard
{
    //    UIStoryboard *storyboard;
    //    return storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIStoryboard *storyBoard;
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    // NSLog(@"H: %f",iOSDeviceScreenSize.height);
    //NSLog(@"W: %f",iOSDeviceScreenSize.width);
    if(iOSDeviceScreenSize.height == 480)
    {
        storyBoard = [UIStoryboard storyboardWithName:@"iPhone4s" bundle:nil];
    }
    else if(iOSDeviceScreenSize.height == 568)
        storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    else if(iOSDeviceScreenSize.height == 1024)
        storyBoard = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    else
        storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyBoard;
}
+(void) setPadding :(UITextField *) textField
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 3;
    textField.autocorrectionType=UITextAutocorrectionTypeNo;
}
+(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxWidth = 0;
    float maxHeight = 0;
    if(actualWidth>actualHeight) {
        maxWidth = 300;
        maxHeight = maxWidth/imgRatio;
    }
    else{
        maxHeight=200;
        maxWidth = maxHeight*imgRatio;
    }
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 1.0; //50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    return [UIImage imageWithData:imageData];
}
@end
