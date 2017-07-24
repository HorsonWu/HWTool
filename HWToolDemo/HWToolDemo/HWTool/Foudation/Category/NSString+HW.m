//
//  NSString+HW.m
//  WanZhongLife
//
//  Created by HorsonWu on 15/12/9.
//  Copyright © 2015年 com.revenco.company. All rights reserved.
//

#import "NSString+HW.h"

@implementation NSString (HW)

static char fxTwoCharToHex(char a, char b)
{
    char encoder[3] = {0,0,0};
    
    encoder[0] = a;
    encoder[1] = b;
    
    return (char) strtol(encoder,NULL,16);
}

- (NSString *)urlEncodeString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), kCFStringEncodingUTF8));
    return result ;
}


#pragma mark -- 对字符串的常用判断
- (BOOL) isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL) isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL) isValidateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}

- (BOOL) isValidatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL) isValidateNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{3,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL) isValidateQQNumber
{
    NSString *qqRegex = @"[1-9][0-9]{4,11}";
    NSPredicate *qqPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [qqPredicate evaluateWithObject:self];
}


#pragma mark -- 文件目录部分的操作
- (NSString *)appendDocumentDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendCacheDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

- (NSString *)appendTempDir{
    NSString *path = NSTemporaryDirectory();
    return [self appendWithPath:path];
}
// 在传入的路径后拼接当前的字符串
- (NSString *)appendWithPath:(NSString *)path{
    return [path stringByAppendingPathComponent:self];
}

- (CGFloat)getHeightWithLabelWidth:(float)labelWidth fontSize:(float)fontSize {
    
    CGSize size = CGSizeMake(labelWidth, CGFLOAT_MAX);
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                     context:NULL];
    return rect.size.height;
}

- (NSInteger)getCharCount {
    NSUInteger len = self.length;
    // 汉字字符集
    NSString * pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    return len + numMatch;
}

/**
 *  显示高亮字体
 */
- (NSAttributedString *)attributedStringWithHighLightString:(NSString *)keyword hightLightColor:(UIColor *)color{
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc]initWithString:self];
    if (!keyword || [keyword isKindOfClass:[NSNull class]]) {
        return result;
    }
    NSRange keywordRange = [self.uppercaseString rangeOfString:keyword];
    if (keywordRange.location == NSNotFound) {
        return result;
    }
    [result addAttribute:NSForegroundColorAttributeName value:color range:keywordRange];
    return result;
}
/**
 *  合并字符串
 */
- (NSAttributedString *)appendAttributedString:(NSAttributedString *)attributedString {
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc]initWithString:self];
    [result appendAttributedString:attributedString];
    return result;
}

+ (void)convertString:(NSString *)source toHexBytes:(unsigned char *)hexBuffer
{
    const char * bytes = [source cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char * index = hexBuffer;
    
    while ((*bytes) && (*(bytes +1))) {
        *index = fxTwoCharToHex(*bytes, *(bytes + 1));
        
        ++index;
        bytes += 2;
    }
    
    *index = 0;
}

+ (NSString *)intervalFromNowTime
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld", (long)interval];
}

+ (NSString *)deleteChinesSpace:(NSString *)sourceText
{
    return [sourceText stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+(NSString *)stringFromObject:(id)obj
{
    NSString *ret = nil;
    
    if ([obj isKindOfClass:[NSNumber class]]) {
        ret = [NSString stringWithFormat:@"%ld", [obj longValue]];
    }
    else {
        ret = obj;
    }
    
    return ret;
}

+ (NSDictionary *)parseURLQueryString:(NSString *)queryString
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *pair in pairs) {
        NSArray *keyValue = [pair componentsSeparatedByString:@"="];
        
        if([keyValue count] == 2) {
            NSString *key = [keyValue objectAtIndex:0];
            NSString *value = [keyValue objectAtIndex:1];
            
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if(key && value)
                [dict setObject:value forKey:key];
        }
    }
    
    return dict;
}

+ (NSString *)replaceUnicode:(NSString *)unicodeString
{
    NSString *tempStr1 = [unicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (NSAttributedString *)attributedStringWithHighLightString:(NSString *)keyword highLightColor:(UIColor *)hightLightColor highLightFontSize:(CGFloat)highLightFontSize andOriginColor:(UIColor *)originColor andOriginFontSize:(CGFloat)originFontSize{
    
    NSMutableAttributedString * result = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSRange resultRange = [self.uppercaseString rangeOfString:self];
    [result addAttribute:NSForegroundColorAttributeName value:originColor range:resultRange];
    [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:originFontSize] range:resultRange];
    
    
    if (!keyword || [keyword isKindOfClass:[NSNull class]]) {
        return result;
    }
    NSRange keywordRange = [self.uppercaseString rangeOfString:keyword];
    if (keywordRange.location == NSNotFound) {
        return result;
    }
    //高亮部分的文字
    [result addAttribute:NSForegroundColorAttributeName value:hightLightColor range:keywordRange];
    [result addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:highLightFontSize] range:keywordRange];
    
    
    return result;
}

- (NSString *)appendNonullString:(NSString *)aString {
    if (aString == nil || [aString isKindOfClass:[NSNull class]]) {
        return self;
    }
    return [self stringByAppendingString:aString];
}

- (NSString *)appendNonullString:(NSString *)aString hint:(BOOL)showHint {
    if (aString == nil || [aString isKindOfClass:[NSNull class]]) {
        return showHint ? @"暂无" : @"";
    }
    return [self stringByAppendingString:aString];
}




@end
