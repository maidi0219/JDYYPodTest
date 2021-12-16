//
//  NSString+Extention.h
//  BookKeeping
//
//  Created by Kingdee on 15/2/13.
//  Copyright (c) 2015年 Kingdee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extention)

- (BOOL)isNumber;
/**
 *  检查手机号是否合法
 */
+ (BOOL)isValidateMobile:(NSString *)mobileNumber;

/**
 *  检查零售的手机号是否合法，跟零售web端一致
 */
+(BOOL)isValidateMobileAtPos:(NSString *)mobileNumber;

/**
 *  检查邮箱是否合法
 */
+ (BOOL)isValidateEmail:(NSString *)email;
/**
 *  检查网址是否合法
 */
+ (BOOL)isValidateUrl:(NSString *)url;

/**
 *  检查账号是否合法
 */
+ (BOOL)isValidateUserName:(NSString *)userName;
/**
 *  检查密码是否合法
 */
+ (BOOL)isValidatePwd:(NSString *)pwd;
/**
 *  只能由数字、字母、-或_等字符组成
 */
+ (BOOL)containOnlyLetterNumberUnderlineDash:(NSString *)str;
/**
 *  最后修改时间标识
 */
+ (NSString *)lasttagWithModifyTimeString:(NSString *)modityTime;

/**
 *  字符串是否包含汉字
 */
+(BOOL)isChinese:(NSString *)text;
/**
 *  末尾是数字则+1
 */
- (NSString *)increaseTail;
/*
 *  保留字符串中的数字
 */
- (NSString *)numberString;


- (NSString *)encodeToPercentEscapeString;


+ (NSString *)joinStringWithArray:(NSArray *)array byJoinString:(NSString *)joinString;

/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

+(NSString*)decimalDigits:(NSNumber*)oldNumber newNuberLength:(int)newNuberLength;

//字典中的number类型转换成String类型
+(NSDictionary*)numberToString:(NSDictionary*)indataDic;

#pragma mark - 与textField相关的检查
/**
 *  检查插入一段字符串后的字符串是否为百分号数（即不能大于100）
 *  @warning    这个方法不对输入参数进行检查。
 *
 *  @param text   原字符串
 *  @param string 插入的字符串
 *  @param range  字符串插入的位置
 *
 *  @return YES：插入后其值x满足0<=x<=100
            NO：其值超过范围，或插入数据有误
 */
+ (BOOL)checkPercentDecimalText:(NSString *)text afterInsertString:(NSString *)string atRange:(NSRange)range;
/**
 *  检查插入一段字符串后小数点精度是否正确
 *  @warning    这个方法只对精度进行检查，不对输入参数进行检查。这个方法需要结合UITextFieldInputType使用
 *
 *  @param text         原字符串
 *  @param string       插入的字符串
 *  @param range        字符串插入的位置
 *  @param precision    允许的精度
 *
 *  @return 插入字符串后精度是否满足
 */
+ (BOOL)checkDotPrecisionWithText:(NSString *)text afterInsertString:(NSString *)string atRange:(NSRange)range allowedPrecision:(NSInteger)precision;

/**
 *  检查插入一段字符串后字符串长度是否正确
 *  @warning    这个方法不对输入参数进行检查。
 *
 *  @param text         原字符串
 *  @param string       插入的字符串
 *  @param range        字符串插入的位置
 *  @param precision    允许的精度
 *
 *  @return 插入字符串后长度是否满足
 */
+ (BOOL)checkLengthWithText:(NSString *)text afterInsertString:(NSString *)string atRange:(NSRange)range allowedLength:(NSInteger)Length;

#pragma mark - 与打印相关的字符串操作
/**
 *  得到中英文混合字符串长度
 */
+ (NSInteger)getToInt:(NSString*)strtemp;

/**
 *  将text转换成汉字string，用于准确计算text在打印机上显示的size
 */
+ (NSString *)chineseCodeStringFromText:(NSString *)text;

+ (CGFloat)widthOfText:(NSString *)text font:(UIFont *)font;


/**
 *  md5 32位（小写）
 */
+ (NSString *)md5WithString:(NSString *)string ;

- (NSString*)trim;

/**
 字典的升序排列以及字符串的拼接
 
 @param params 待排序的字典
 @return 拼接好的字符串
 */
+ (NSString *)getStringWithDic:(NSDictionary*)params;


/**
 随机字符串 - 生成指定长度的字符串
 */
+(NSString *)randomStringWithLength:(NSInteger)len ;

+ (NSString *)transform:(NSString *)chinese;

+ (BOOL)isAllNum:(NSString *)string;//判断字符串是否是数字

+(NSString*)lastNumberAutoAdd:(NSString*)str;


//汉字转成首字母[你好-->NH]
+(NSString *)transformToFirstNo:(NSString *)chinese;

+(BOOL)isEmpty:(NSString*)text;

+(NSString*)utf8EncodingWithString:(NSString*)string;//url含中文需转译

//HMAC-SHA256加密
+ (NSString *)hmacSHA256WithSecret:(NSString *)secret content:(NSString *)content;
@end
