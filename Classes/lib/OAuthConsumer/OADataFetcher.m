//
//  OADataFetcher.m
//  OAuthConsumer
//
//  Created by Jon Crosby on 11/5/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "OADataFetcher.h"


@implementation OADataFetcher

- (void)fetchDataWithRequest:(OAMutableURLRequest *)aRequest 
					delegate:(id)aDelegate 
		   didFinishSelector:(SEL)finishSelector 
			 didFailSelector:(SEL)failSelector 
{
    request = aRequest;
    delegate = aDelegate;
    didFinishSelector = finishSelector;
    didFailSelector = failSelector;
    
    [request prepare];
    
//    responseData = [NSURLConnection sendSynchronousRequest:request
//                                         returningResponse:&response
//                                                     error:&error];
	
//    if (response == nil || responseData == nil || error != nil) {
//        OAServiceTicket *ticket= [[[OAServiceTicket alloc] initWithRequest:request
//                                                                 response:response
//                                                               didSucceed:NO] autorelease];
//        [delegate performSelector:didFailSelector
//                       withObject:ticket
//                       withObject:error];
//    } else {
//        OAServiceTicket *ticket = [[[OAServiceTicket alloc] initWithRequest:request
//                                                                  response:response
//                                                                didSucceed:[(NSHTTPURLResponse *)response statusCode] < 400] autorelease];
//        [delegate performSelector:didFinishSelector
//                       withObject:ticket
//                       withObject:responseData];
//    }  
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate: self];
    
	if (connection)
	{

	}
	else
	{
        OAServiceTicket *ticket= [[[OAServiceTicket alloc] initWithRequest:request
                                                                  response:response
                                                                didSucceed:NO] autorelease];
        [delegate performSelector:didFailSelector
                       withObject:ticket
                       withObject:error];
	}
}

#pragma mark -
#pragma mark NSURLConnection methods

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)space {
	if([[space authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        return YES; // Self-signed cert will be accepted
	}
	return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse
{
	if (response)
		[response release];
	response = [aResponse retain];
//    int statusCode = [(NSHTTPURLResponse*) response statusCode];
//    if (statusCode != 200) {
//        OAServiceTicket *ticket= [[[OAServiceTicket alloc] initWithRequest:request
//                                                                  response:response
//                                                                didSucceed:NO] autorelease];
//        [delegate performSelector:didFailSelector
//                       withObject:ticket
//                       withObject:error];
//        return;
//    }
    if (responseData)
        [responseData release];
    responseData = [[NSMutableData data] retain];
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    //NSLog(@"Connection OADataFetcher.m %@",data);
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)_error
{
    error = [_error retain];
    OAServiceTicket *ticket= [[[OAServiceTicket alloc] initWithRequest:request
                                                              response:response
                                                            didSucceed:NO] autorelease];
    [delegate performSelector:didFailSelector
                   withObject:ticket
                   withObject:error];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    int statusCode = [(NSHTTPURLResponse*) response statusCode];
    
    if (statusCode != 200) {
        OAServiceTicket *ticket= [[[OAServiceTicket alloc] initWithRequest:request
                                                                  response:response
                                                                didSucceed:NO] autorelease];
        [delegate performSelector:didFailSelector
                       withObject:ticket
                       withObject:error];
    } else {
        OAServiceTicket *ticket = [[[OAServiceTicket alloc] initWithRequest:request
                                                                   response:response
                                                                 didSucceed:[(NSHTTPURLResponse *)response statusCode] < 400] autorelease];
       
        //NSLog(@"OADataFetch/connectionDidFinishLoading %d -- %@", statusCode, responseData);
        [delegate performSelector:didFinishSelector
                       withObject:ticket
                       withObject:responseData];
    }
}

- (void) dealloc {
    [connection release];
    [responseData release];
    [response release];
    [error release];
    [super dealloc];
}

@end
