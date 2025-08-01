//
//  ItemParser.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

typealias ItemHanler = TagHandler & ItemTagHandler

final class ItemParser: NSObject {
	var episode = Item()
	var itemAlternateEnclosures = [AlternateEnclosure]()
	var itemValues = [PodcastValue]()
	
	var handlers: [any ItemHanler]
	
	weak var delegate: ItemParserDelegate?
	
	private var rootXMLParser: XMLParser?
	private var nestedXMLParserDelegate: XMLParserDelegate?
	
	private var currentCharacters = ""
	private var currentAttributes = [String : String]()
	
	init(rootXMLParser parser: XMLParser) {
		rootXMLParser = parser
		
		handlers = [
			ItemRSSHandler(),
			ItemPodcastingHandler(),
			ItemApplePodcastHandler()
		]
		
		super.init()
		
		createChain()
	}
	
	private func createChain() {
		for index in 0 ..< (handlers.count - 1) {
			handlers[index].nextHandler = handlers[index + 1]
		}
	}
}

extension ItemParser: Restorable {
	func restoreParserDelegate() {
		self.rootXMLParser?.delegate = self
		nestedXMLParserDelegate = nil
	}
}

extension ItemParser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		currentCharacters = ""
		currentAttributes = attributeDict
		
		if elementName == Podcasting.AlternateEnclosure.tagName {
			let alternateEnclosureParser = AlternateEnclosureParser(attributtes: attributeDict)
			alternateEnclosureParser.delegate = self
			
			rootXMLParser?.delegate = alternateEnclosureParser
			nestedXMLParserDelegate = alternateEnclosureParser
		}
		
		if elementName == Podcasting.Value.tagName {
			let valueParser = ValueParser(attributes: attributeDict)
			valueParser.delegate = self
			
			rootXMLParser?.delegate = valueParser
			nestedXMLParserDelegate = valueParser
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == RSS.Item.tagName {
			handlers.forEach { $0.applyChanges(to: &episode) }
			episode.podcasting?.alternateEnclosures = itemAlternateEnclosures.isEmpty ? nil : itemAlternateEnclosures
			episode.podcasting?.values = itemValues.isEmpty ? nil : itemValues
			
			delegate?.parser(self, didFinishParse: episode)
		} else {
			handlers.first?.processTag(elementName, text: currentCharacters, withAttributes: currentAttributes)
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		currentCharacters.append(string)
	}
}

extension ItemParser: AlternateEnclosureParserDelegate {
	func parser(_ parser: AlternateEnclosureParser, didFinishParse alternateEnclosure: AlternateEnclosure) {
		itemAlternateEnclosures.append(alternateEnclosure)
		restoreParserDelegate()
	}
	
	func parser(_ parser: AlternateEnclosureParser, didFailWithError error: SyndicationFeedError) {
		restoreParserDelegate()
	}
}

extension ItemParser: ValueParserDelegate {
	func parser(_ parser: ValueParser, didFinishParse value: PodcastValue) {
		itemValues.append(value)
		restoreParserDelegate()
	}
	
	func parser(_ parser: ValueParser, didFailWithError error: SyndicationFeedError) {
		restoreParserDelegate()
	}
}
