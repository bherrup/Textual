// Created by Satoshi Nakagawa <psychs AT limechat DOT net> <http://github.com/psychs/limechat>
// You can redistribute it and/or modify it under the new BSD license.

@implementation TopicSheet

@synthesize uid;
@synthesize cid;
@synthesize text;

- (id)init
{
	if ((self = [super init])) {
		[NSBundle loadNibNamed:@"TopicSheet" owner:self];
	}

	return self;
}

- (void)start:(NSString *)topic
{
	[[[delegate master] formattingMenu] enableSheetField:text];
	
	[text setFilteredAttributedStringValue:[topic attributedStringWithIRCFormatting]];
	
	[self startSheet];
}

- (void)ok:(id)sender
{
	if ([delegate respondsToSelector:@selector(topicSheet:onOK:)]) {
		NSString *topic = [[text attributedStringValue] attributedStringToASCIIFormatting];
		
		[delegate topicSheet:self onOK:topic];
	}
	
	[super ok:nil];
}

#pragma mark -
#pragma mark NSWindow Delegate

- (void)windowWillClose:(NSNotification *)note
{
	[[[delegate master] formattingMenu] enableWindowField:[[delegate master] text]];
	
	if ([delegate respondsToSelector:@selector(topicSheetWillClose:)]) {
		[delegate topicSheetWillClose:self];
	}
}

@end