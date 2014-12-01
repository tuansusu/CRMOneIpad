//
//  ExampleHTMLStringToAttributedString.m
//  Voffice2.1
//
//  Created by VTIT on 8/20/13.
//
//

#import "ExampleHTMLStringToAttributedString.h"

@implementation ExampleHTMLStringToAttributedString

@synthesize mpString;
@synthesize mfFontSize;
@synthesize mpAttributedString;
@synthesize appendThisString;
@synthesize mbIsBold;
@synthesize mbIsItalic;

+(NSAttributedString*) getAttributedStringForHTMLText:(NSString*)htmlText WithFontSize:(CGFloat)fontSize {
    
    ExampleHTMLStringToAttributedString *me = [[ExampleHTMLStringToAttributedString alloc] initWithString:htmlText];
    return [me getAttributedStringWithFontSize:fontSize];
}

- (id)initWithString:(NSString*)inString {
    self = [super init];
    if (self) {
        if ([inString hasPrefix:@""]) {
            mpString = inString;
        } else {
            mpString = [NSString stringWithFormat:@"%@", inString];
        }
        mpAttributedString = [NSMutableAttributedString new];
    }
    return self;
}

-(NSAttributedString*) getAttributedStringWithFontSize:(CGFloat)fontSize {
    
    mfFontSize = fontSize;
    
    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[mpString dataUsingEncoding:NSUTF8StringEncoding]];
    parser.delegate = self;
    if (![parser parse]) {
        return nil;
    }
    
    return mpAttributedString;
}

-(void) appendTheAccumulatedText {
    UIFont *theFont = nil;
    
    if (mbIsBold && mbIsItalic) {
        // http://stackoverflow.com/questions/1384181/italic-bold-and-underlined-font-on-iphone
        theFont = [UIFont fontWithName:@"Helvetica-BoldOblique" size:mfFontSize];
    } else if (mbIsBold) {
        theFont = [UIFont boldSystemFontOfSize:mfFontSize];
    } else if (mbIsItalic) {
        theFont = [UIFont italicSystemFontOfSize:mfFontSize];
    } else {
        theFont = [UIFont systemFontOfSize:mfFontSize];
    }
    
    NSAttributedString *appendThisAttributedString =
    [[NSAttributedString alloc]
     initWithString:appendThisString
     attributes:@{NSFontAttributeName : theFont}];
    
    [mpAttributedString appendAttributedString:appendThisAttributedString];
    
    [appendThisString setString:@""];
}

#pragma NSXMLParserDelegate delegate

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    appendThisString = [NSMutableString new];
    mbIsBold = NO;
    mbIsItalic = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"body"]){
    } else if ([elementName isEqualToString:@"i"]) {
        [self appendTheAccumulatedText];
        mbIsItalic = YES;
    } else if ([elementName isEqualToString:@"b"]) {
        [self appendTheAccumulatedText];
        mbIsBold = YES;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"body"]){
        [self appendTheAccumulatedText];
    } else if ([elementName isEqualToString:@"i"]) {
        [self appendTheAccumulatedText];
        mbIsItalic = NO;
    } else if ([elementName isEqualToString:@"b"]) {
        [self appendTheAccumulatedText];
        mbIsBold = NO;
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [appendThisString appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
}

@end
