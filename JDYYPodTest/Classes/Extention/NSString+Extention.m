//
//  NSString+Extention.m
//  BookKeeping
//
//  Created by Kingdee on 15/2/13.
//  Copyright (c) 2015年 Kingdee. All rights reserved.
//

#import "NSString+Extention.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Extention)
// "^[1][34578][0-9]{9}$"


+(BOOL)isValidateMobile:(NSString *)mobileNumber {
    
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    NSString * CM     = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSString * CU     = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString * CT     = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * All_Head_1     = @"^1\\d{10}$";
    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestHead1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", All_Head_1];
    
//    BOOL res1 = [regextestmobile evaluateWithObject:mobileNumber];
//    BOOL res2 = [regextestcm evaluateWithObject:mobileNumber];
//    BOOL res3 = [regextestcu evaluateWithObject:mobileNumber];
//    BOOL res4 = [regextestct evaluateWithObject:mobileNumber];
    BOOL res5 = [regextestHead1 evaluateWithObject:mobileNumber];
    
//    if (res1 || res2 || res3 || res4 ){
    if (res5){
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isValidateMobileAtPos:(NSString *)mobileNumber {
    NSString * All_Head_1     = @"^[1][34578][0-9]{9}$";
    NSPredicate *regextestHead1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", All_Head_1];
    BOOL res5 = [regextestHead1 evaluateWithObject:mobileNumber];
    if (res5){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
+ (BOOL)isValidateUrl:(NSString *)url{
    NSString *urlRegex = @"[a-zA-z]+://[^s]*";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",urlRegex];
    
    return [urlTest evaluateWithObject:url];
}

+ (BOOL)isValidateUserName:(NSString *)userName{
    NSString *userNameRegex = @"[a-zA-Z0-9]{4,20}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",userNameRegex];
    
    return [predicate evaluateWithObject:userName];
}

+ (BOOL)isValidatePwd:(NSString *)pwd{
    NSString *pwdRegex = @"[a-zA-Z0-9]{6,20}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pwdRegex];
    
    return [predicate evaluateWithObject:pwd];
}

+(BOOL)containOnlyLetterNumberUnderlineDash:(NSString *)str{
    NSString *pwdRegex = @"[a-zA-Z_0-9-]+";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pwdRegex];
    
    return [predicate evaluateWithObject:str];
}

+ (NSString *)lasttagWithModifyTimeString:(NSString *)modityTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    NSDate *lastModifyDate = [formatter dateFromString:modityTime];
    NSTimeInterval lasttagTime = [lastModifyDate timeIntervalSince1970]*1000;
    NSString *lasttag = [NSString stringWithFormat:@"%.0f",lasttagTime];
    return lasttag;
}

//是否是数
- (BOOL)isNumber {
    return [self mj_isPureInt]||[self isFloat];
}

+(BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++){
         c=[string characterAtIndex:i];
         if (!isdigit(c)) {
             return NO;
         }
    }
    return YES;
}
//返回字符串后面一段数字
+(NSString*)lastNumberAutoAdd:(NSString*)str{
    if (str.length ==0) return @"";
    NSString *numStr = @"";
    for (int i=0; i<str.length; i++){
        char c;
        c=[str characterAtIndex:i];
        if (isdigit(c)) {
            numStr = [numStr stringByAppendingString:[NSString stringWithFormat:@"%c",c]];
        }else{
            numStr = @"";
        }
    }
    long numLength = numStr.length;
    if (numLength) {
        //前一段非数字
        NSString *preStr = [str substringToIndex:str.length - numStr.length];
        long num = numStr.longLongValue +1;
        numStr = [NSString stringWithFormat:@"%ld",num];
        //补0
        while (numStr.length < numLength) {
            numStr = [@"0" stringByAppendingString:numStr];
        }
        return [preStr stringByAppendingString:numStr];
    }
    return numStr;
}


//浮点形判断：
- (BOOL)isFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (NSString *)increaseTail{
    if (self.length > 20) {
        return self;
    }
    if ([self mj_isPureInt]){
        if (self.length == [NSString stringWithFormat:@"%lld",[self longLongValue]].length) {
            return [NSString stringWithFormat:@"%lld",[self longLongValue] + 1];
        } else if (self.longLongValue == 0){
            NSString *str = @"";
            for (int a=0 ; a<self.length-1 ;a++) {
                str = [NSString stringWithFormat:@"0%@",str];
            }
            return [NSString stringWithFormat:@"%@1",str];
        }
    }{
        
    }
    NSUInteger lengthSub = 1;
    NSString *sub = nil;
    do {
        if (lengthSub > self.length) {
            break;
        }
        sub = [self substringFromIndex:self.length - lengthSub];
        lengthSub ++ ;
    } while ([sub mj_isPureInt]);
    
    NSString *numString = [self substringFromIndex:self.length - lengthSub + 2];
    long long num = [numString longLongValue];
    if (num > 0) {
        NSString *stringTmp1 = [NSString stringWithFormat:@"%lld",num];
        NSRange range = [self rangeOfString:stringTmp1];
        num ++;
        NSString *stringTmp2 = [NSString stringWithFormat:@"%lld",num];
        if (num % 10 == 0) {
            if ([[self substringFromIndex:(self.length - stringTmp2.length)] mj_isPureInt]) {
                range.location = range.location - 1;
                range.length = range.length + 1;
            }
        }
        return [self stringByReplacingCharactersInRange:range withString:stringTmp2];
    } else {
        return self;
    }
}

- (NSString *)numberString{
    return [self stringByReplacingOccurrencesOfString:@"[^0-9]"
                                           withString:@""
                                              options:NSRegularExpressionSearch
                                                range:NSMakeRange(0, self.length)];
}
- (BOOL)mj_isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (NSString *)encodeToPercentEscapeString
{
    NSString *input = self;
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)input,NULL,(CFStringRef)@"!*'();:@+$,/?%#[]",kCFStringEncodingUTF8);
    return outputStr;
}


+ (NSString *)joinStringWithArray:(NSArray *)array byJoinString:(NSString *)joinString{
    NSMutableString *joinedString = [[NSMutableString alloc] initWithCapacity:array.count];
    for (id object in array) {
        [joinedString appendFormat:@"%@%@",object,joinString];
    }
    [joinedString deleteCharactersInRange:NSMakeRange(joinedString.length - 1, 1)];
    return joinedString;
}

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
//oldNumber需要改变的数字 newNuberLength保留多少位小数点
+(NSString*)decimalDigits:(NSNumber*)oldNumber newNuberLength:(int)newNuberLength{
    NSNumberFormatter *nFormat = [[NSNumberFormatter alloc] init];
    [nFormat setDecimalSeparator:@"."];//小数点
    [nFormat setNumberStyle:NSNumberFormatterNoStyle];
    [nFormat setMaximumFractionDigits:newNuberLength];
    [nFormat setRoundingMode:NSNumberFormatterRoundHalfUp];
    NSString *newStr =[nFormat stringFromNumber:oldNumber];
    if ([newStr hasPrefix:@"."]) {//".15" 类似的字符修改成 "0.15"
        NSMutableString *tempStr = [NSMutableString stringWithString:newStr];
       [tempStr insertString:@"0" atIndex:0];
        return tempStr;
    }else if ([newStr hasPrefix:@"-."]){//"-.15" 类似的字符修改成 "-0.15"
        NSMutableString *tempStr = [NSMutableString stringWithString:newStr];
        [tempStr insertString:@"0" atIndex:1];
        return tempStr;
    }
    return newStr;
}

//字典中的number类型转换成String类型
+(NSDictionary*)numberToString:(NSDictionary*)indataDic{
    __weak typeof (self)wSelf = self;
    [indataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull object, BOOL * _Nonnull stop) {
        if ([object isKindOfClass:[NSNumber class]]) {
            NSNumber *num = object;
            
            [indataDic setValue:[NSString stringWithFormat:@"%@",num] forKey:key];
        }
        else if ([object isKindOfClass:[NSArray class]]){
            [wSelf arrayMethod:(NSArray *)object];
        }
    }];
    return indataDic;
}

+(void)arrayMethod:(NSArray*)array{
    __weak typeof (self)wSelf = self;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            [wSelf numberToString:(NSDictionary*)object];
        }
        else if ([object isKindOfClass:[NSArray class]]){
            [wSelf arrayMethod:(NSArray *)object];
        }
    }];
}


/**
 *  检查插入一段字符串后的字符串是否为百分号数（即不能大于100）
 *
 *  @param text   原字符串
 *  @param string 插入的字符串
 *  @param range  字符串插入的位置
 *
 *  @return YES：插入后其值x满足0<=x<=100
            NO：其值超过范围，或插入数据有误
 */
+ (BOOL)checkPercentDecimalText:(NSString *)text afterInsertString:(NSString *)string atRange:(NSRange)range{
    // 如果插入第一位，必须是数字
    if (range.location == 0 && [string rangeOfString:@"^[0-9]+$" options:NSRegularExpressionSearch].location == NSNotFound) {
        return NO;
    }
    if (text.length < range.location) {
        return NO;
    }
    NSMutableString *tempMuStr = [[NSMutableString alloc] initWithCapacity:text.length + string.length - range.length];
    [tempMuStr appendString:text];
    // 将新输入的字符串加入后判断其值是否大于100
    [tempMuStr replaceCharactersInRange:range withString:string];

    if (tempMuStr.floatValue > 100 || tempMuStr.floatValue < 0) {
        return NO;
    }
    return YES;
}

/**
 *  检查插入一段字符串后小数点精度是否正确
 *  @warning    这个方法只对精度进行检查，不对输入参数类型进行检查。这个方法需要结合UITextFieldInputType使用
 *
 *  @param text         原字符串
 *  @param string       插入的字符串
 *  @param range        字符串插入的位置
 *  @param precision    允许的精度
 *
 *  @return 插入字符串后精度是否满足
 */
+ (BOOL)checkDotPrecisionWithText:(NSString *)text afterInsertString:(NSString *)string atRange:(NSRange)range allowedPrecision:(NSInteger)precision{
    // 1. 如果没有小数点，直接返回
    if([text rangeOfString:@"."].location == NSNotFound){
        return YES;
    }
    // 2. 可删
    if ([string length] == 0) {
        return YES;
    }
    
    // 3. 判断插入后的字符串精度是否支持
    NSMutableString *afterText = [[NSMutableString alloc] initWithCapacity:text.length + string.length - range.length];
    [afterText appendString:text];
    [afterText replaceCharactersInRange:range withString:string];
    
    NSInteger dotLoc = [afterText rangeOfString:@"."].location;
    if (dotLoc == NSNotFound) {
        return YES;
    }
    
    if (afterText.length - dotLoc - 1  <= precision) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkLengthWithText:(NSString *)text afterInsertString:(NSString *)string atRange:(NSRange)range allowedLength:(NSInteger)Length{
    if ([string length] == 0) {
        return YES;
    }
    NSMutableString *afterText = [[NSMutableString alloc] initWithCapacity:text.length + string.length - range.length];
    [afterText appendString:text];
    [afterText replaceCharactersInRange:range withString:string];
    if (afterText.length <= Length) {
        return YES;
    }
    return NO;

}

#pragma mark - 与打印相关的字符串操作

+ (NSInteger)getToInt:(NSString*)strtemp{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return [da length];
}

- (NSInteger)countOfChineseNumber{
    NSInteger actualLength = [NSString getToInt:self];
    NSInteger length = self.length;
    return actualLength - length;
    
}

- (NSInteger)countOfEnglishNumber{
    return self.length - [self countOfChineseNumber];
}

+ (NSString *)chineseCodeStringFromText:(NSString *)text{
    static NSString *chineseCode = @"测";
    NSInteger actualLength = [NSString getToInt:text];
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:actualLength / 2];
    for (int i = 0 ; i < actualLength / 2; i++) {
        [string appendString:chineseCode];
    }
    if (actualLength % 2 != 0) {
        [string appendString:@"0"];
    }
    return [string copy];
}

+ (CGFloat)widthOfText:(NSString *)text font:(UIFont *)font{
    return [text sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, 26)].width;
}

+(BOOL)isChinese:(NSString *)text{
    NSString * regex = @"^[\u4e00-\u9fa5]{0,}$";//@"^[A-Za-z0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:text];
    return isMatch;
}
/**
 *  md5 32位（小写）
 */
+ (NSString *)md5WithString:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)string.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

- (NSString*)trim{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 字典的升序排列以及字符串的拼接
 
 @param params 待排序的字典
 @return 拼接好的字符串
 */
+ (NSString *)getStringWithDic:(NSDictionary*)params{
    //排序key
    NSArray *keyArray = [params allKeys];//获取待排序的key
    if (!keyArray || keyArray.count == 0) {
        return nil;
    }
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];//获取排序后的key
    //排序后的以key=value拼接的数组
    NSMutableArray *valueArray = [NSMutableArray array];
    for(NSString *sortSring in sortArray){
        NSString *signSring = [NSString stringWithFormat:@"%@=%@",sortSring,[params objectForKey:sortSring]];
        [valueArray addObject:signSring];
    }
    
    // 就是用“&”把每个排序后拼接的数组，用字符串拼接起来
    NSString *string = [valueArray componentsJoinedByString:@"&"];
    return string;
}

+(NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)letters.length)]];
    }
    return randomString;
}

+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [[pinyin uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//汉字字符串首字母
+(NSString *)transformToFirstNo:(NSString *)chinese{
    NSArray *stringArray = [self subStringWithNoSpace:chinese];
    NSString *tempStr = @"";
    for (NSString *str in stringArray) {
        if (![str isEqualToString:@" "]) {
            tempStr = [tempStr stringByAppendingString:[[self transform:str] substringToIndex:1]];
        }
        
    }
    return tempStr;
}

+ (NSArray *)subStringWithNoSpace:(NSString *)text
{
    NSMutableArray *textArray = @[].mutableCopy;
    for (NSInteger i = 0; i < text.length; i++) {
        NSString *str = [text substringToIndex:1];
        text = [text substringFromIndex:1];
        i = 0;
        [textArray addObject:str];
        if (text.length == 1) {
            [textArray addObject:text];
        }
    }
    return textArray;
}

+(BOOL)isEmpty:(NSString*)text{
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (text == nil){
        return YES;
    }
    return NO;
}
+(NSString*)utf8EncodingWithString:(NSString*)string{
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)hmacSHA256WithSecret:(NSString *)secret content:(NSString *)content
{
    //密钥转换成 const char
    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
      // 加密的内容有可能有中文 所以用NSUTF8StringEncoding
    const char *cData = [content cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //SHA256加密
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSMutableString *hexString = [NSMutableString string];
    //转换成字符串
    for (int i=0; i<sizeof(cHMAC); i++)
    {
        [hexString appendFormat:@"%02x", cHMAC[i]];
    }
    return hexString;
}
@end
