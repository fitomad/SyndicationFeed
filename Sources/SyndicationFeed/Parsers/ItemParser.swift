//
//  ItemParser.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

typealias ItemHanler = TagHandler & ItemTagHandler

final class ItemParser: NSObject {
	private var parseFailures = [SyndicationFeedError]()
	
	private var episode = Item()
	private var itemAlternateEnclosures = [AlternateEnclosure]()
	private var itemValues = [PodcastValue]()
	
	private var handlers: [any ItemHanler]
	
	weak var delegate: ItemParserDelegate?
	
	private var rootXMLDelegate: XMLParserDelegate?
	private var rootParser: XMLParser?
	private var nestedXMLDelegate: (any XMLParserDelegate)?
	
	private var currentCharacters = ""
	private var currentAttributes = [String : String]()
	
	init(rootXMLDelegate: XMLParserDelegate, rootParser: XMLParser?) {
		self.rootXMLDelegate = rootXMLDelegate
		self.rootParser = rootParser
		
		handlers = [
			ItemRSSHandler(),
			ItemPodcastingHandler(),
			ItemApplePodcastHandler()
		]
		
		super.init()
		
		createChain()
	}
	
	deinit {
		nestedXMLDelegate = nil
	}
	
	private func createChain() {
		for index in 0 ..< (handlers.count - 1) {
			handlers[index].nextHandler = handlers[index + 1]
		}
	}
}

extension ItemParser: Restorable {
	func restoreParserDelegate() {
		rootParser?.delegate = rootXMLDelegate
	}
}

extension ItemParser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		currentCharacters = ""
		currentAttributes = attributeDict
		
		if elementName == Podcasting.AlternateEnclosure.tagName {
			let alternateEnclosureParser = AlternateEnclosureParser(rootXMLDelegate: self, rootParser: rootParser)
			alternateEnclosureParser.delegate = self
			alternateEnclosureParser.didStartParseElement(withAttributes: attributeDict)
			
			nestedXMLDelegate = alternateEnclosureParser
			rootParser?.delegate = alternateEnclosureParser
		}
		
		if elementName == Podcasting.Value.tagName {
			let valueParser = ValueParser(rootXMLDelegate: self, rootParser: rootParser)
			valueParser.delegate = self
			valueParser.didStartParseElement(withAttributes: attributeDict)
			
			nestedXMLDelegate = valueParser
			rootParser?.delegate = valueParser
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == RSS.Item.tagName {
			handlers.forEach { $0.applyChanges(to: &episode) }
			episode.podcasting?.alternateEnclosures = itemAlternateEnclosures.isEmpty ? nil : itemAlternateEnclosures
			episode.podcasting?.values = itemValues.isEmpty ? nil : itemValues
			
			handlers.removeAll()
			
			delegate?.parser(self, didFinishParse: episode, withErrors: parseFailures)
			restoreParserDelegate()
		} else {
			do {
				try handlers.first?.processTag(elementName, text: currentCharacters, withAttributes: currentAttributes)
			} catch {
				parseFailures.append(error)
			}
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		currentCharacters.append(string)
	}
}

extension ItemParser: AlternateEnclosureParserDelegate {
	func parser(_ parser: AlternateEnclosureParser, didFinishParse alternateEnclosure: AlternateEnclosure) {
		itemAlternateEnclosures.append(alternateEnclosure)
	}
	
	func parser(_ parser: AlternateEnclosureParser, didFailWithError error: SyndicationFeedError) {
		
	}
}

extension ItemParser: ValueParserDelegate {
	func parser(_ parser: ValueParser, didFinishParse value: PodcastValue) {
		itemValues.append(value)
	}
	
	func parser(_ parser: ValueParser, didFailWithError error: SyndicationFeedError) {

	}
}
