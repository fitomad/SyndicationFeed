//
//  AlternateEnclosureParser.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

final class AlternateEnclosureParser: NSObject {
	private var currentElement = ""
	private var currentAttributes = [String : String]()
	
	private var mapper = AlternateEnclosureMapper()
	private var alternateEnclosure: AlternateEnclosure?
	
	private let rootXMLDelegate: XMLParserDelegate
	private weak var rootParser: XMLParser?
	
	weak var delegate: AlternateEnclosureParserDelegate?
	
	init(rootXMLDelegate: XMLParserDelegate, rootParser: XMLParser?) {
		self.rootXMLDelegate = rootXMLDelegate
		self.rootParser = rootParser
	}
	
	func didStartParseElement(withAttributes attributes: [String : String]) {
		alternateEnclosure = try? mapper.mapToAlternateEnclosure(from: attributes)
	}
}

extension AlternateEnclosureParser: Restorable {
	func restoreParserDelegate() {
		rootParser?.delegate = rootXMLDelegate
	}
}

extension AlternateEnclosureParser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		currentElement = elementName
		currentAttributes = attributeDict
		
		if elementName == Podcasting.Source.tagName {
			if let source = try? mapper.mapToSource(from: attributeDict) {
				alternateEnclosure?.sources.append(source)
			}
		}
		
		if elementName == Podcasting.Integrity.tagName {
			if let integrity = try? mapper.mapToIntegrity(from: attributeDict) {
				alternateEnclosure?.integrity = integrity
			}
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == Podcasting.AlternateEnclosure.tagName {
			if let alternateEnclosure {
				delegate?.parser(self, didFinishParse: alternateEnclosure)
			} else {
				delegate?.parser(self, didFailWithError: .malformedContent)
			}
			
			restoreParserDelegate()
		}
	}
}
