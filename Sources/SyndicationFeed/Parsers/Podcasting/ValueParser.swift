//
//  ValueParser.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 27/7/25.
//

import Foundation

final class ValueParser: NSObject {
	var value: PodcastValue?
	weak var delegate: ValueParserDelegate?
	
	private let rootXMLDelegate: XMLParserDelegate
	private weak var rootParser: XMLParser?
	
	init(rootXMLDelegate: XMLParserDelegate, rootParser: XMLParser?) {
		self.rootXMLDelegate = rootXMLDelegate
		self.rootParser = rootParser
	}
	
	func didStartParseElement(withAttributes attributes: [String : String]) {
		let mapper = ValueMapper()
		value = try! mapper.mapToValue(from: attributes)
	}
}

extension ValueParser: Restorable {
	func restoreParserDelegate() {
		rootParser?.delegate = rootXMLDelegate
	}
}

extension ValueParser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		if elementName == Podcasting.ValueRecipient.tagName {
			let mapper = ValueMapper()
			if let recipient = try? mapper.mapToValueRecipient(from: attributeDict) {
				value?.recipients.append(recipient)
			}
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == Podcasting.Value.tagName {
			if let value {
				delegate?.parser(self, didFinishParse: value)
				restoreParserDelegate()
			}
		}
	}
}
