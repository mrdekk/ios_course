    NSString* path = [ [ NSBundle mainBundle ] pathForResource: @"rss" ofType: @"xml" ];

    NSData* data = [ NSData dataWithContentsOfFile: path ];
    
    NSXMLParser* parser = [ [ [ NSXMLParser alloc ] initWithData: data ] autorelease ];
    parser.delegate = self;
    [ parser parse ];
    
    NSError* error = [ NSError errorWithDomain: @"my.domain" code: 12312 userInfo: [ NSDictionary dictionaryWithObjectsAndKeys: @"key1", @"A", @"key2", @"B", nil ] ];

#pragma mark - NSXMLParsingDelegate

-( void ) parser: ( NSXMLParser* )parser didStartElement: ( NSString* )elementName namespaceURI: ( NSString* )namespaceURI qualifiedName: ( NSString* )qName attributes: ( NSDictionary* )attributeDict
{
    // do nothing
}

-( void ) parser: ( NSXMLParser* )parser didEndElement: ( NSString* )elementName namespaceURI: ( NSString* )namespaceURI qualifiedName: ( NSString* )qName
{
    // do nothing
}

-( void ) parser: ( NSXMLParser* )parser foundCharacters: ( NSString* )string
{
    // do nothing
}
