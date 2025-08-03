//
//  LiveItemParser.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

final class LiveItemParser: NSObject {
	private var currentElement = ""
	private var currentCharacters = ""
	private var currentAttributes = [String : String]()
	private var liveItemProperties = [String : String]()
	
	private var rootXMLDelegate: XMLParserDelegate?
	private weak var rootXMLParser: XMLParser?
	private var nestedXMLDelegate: XMLParserDelegate?
	
	private var liveItem: Channel.LiveItem?
	weak var delegate: LiveItemParserDelegate?
	
	let mapper = LiveItemMapper()
	
	init(rootXMLDelegate: XMLParserDelegate, rootParser: XMLParser?) {
		self.rootXMLDelegate = rootXMLDelegate
		self.rootXMLParser = rootParser
	}
	
	deinit {
		nestedXMLDelegate = nil
	}
	
	func didStartParseElement(withAttributes attributes: [String : String]) {
		liveItem = try? mapper.mapToLiveItem(using: attributes)
	}
	
	private func appendContentLink(_ contentLink: ContentLink?) {
		guard let contentLink else {
			return
		}
		
		if liveItem?.links == nil {
			liveItem?.links = [ContentLink]()
		}
		
		liveItem?.links?.append(contentLink)
	}
}

extension LiveItemParser: Restorable {
	func restoreParserDelegate() {
		rootXMLParser?.delegate = rootXMLDelegate
	}
}

extension LiveItemParser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		currentElement = elementName
		currentAttributes = attributeDict
		currentCharacters.removeAll()
		
		switch elementName {
			case RSS.Enclosure.tagName:
				let enclosureMapper = EnclosureMapper()
				liveItem?.enclosure = try? enclosureMapper.mapToEnclosure(from: attributeDict)
			case Podcasting.AlternateEnclosure.tagName:
				let alternateEnclosureParser = AlternateEnclosureParser(rootXMLDelegate: self, rootParser: rootXMLParser)
				alternateEnclosureParser.delegate = self
				alternateEnclosureParser.didStartParseElement(withAttributes: currentAttributes)
				
				nestedXMLDelegate = alternateEnclosureParser
				parser.delegate = alternateEnclosureParser
			default:
				break
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		switch elementName {
			case Podcasting.LiveItem.title:
				liveItem?.title = currentCharacters
			case Podcasting.LiveItem.description:
				liveItem?.description = currentCharacters
			case Podcasting.LiveItem.link:
				liveItem?.link = URL(string: currentCharacters)
			case RSS.GUID.tagName:
				let guidMapper = GUIDMapper()
				let guid = try? guidMapper.mapToGUID(from: currentAttributes, urlContent: currentCharacters)
				liveItem?.guid = guid
			case Podcasting.ContentLink.tagName:
				let contentLinkMapper = ContentLinkMapper()
				let contentLink = try? contentLinkMapper.mapToContenLink(from: currentAttributes, content: currentCharacters)
				
				appendContentLink(contentLink)
			case Podcasting.LiveItem.tagName:
				if let liveItem {
					delegate?.parser(self, didFinishParse: liveItem)
					restoreParserDelegate()
				}
			default:
				break
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		currentCharacters.append(string)
	}
}

extension LiveItemParser: AlternateEnclosureParserDelegate {
	func parser(_ parser: AlternateEnclosureParser, didFinishParse alternateEnclosure: AlternateEnclosure) {
		if liveItem?.alternateEnclosures == nil {
			liveItem?.alternateEnclosures = [AlternateEnclosure]()
		}
		
		liveItem?.alternateEnclosures?.append(alternateEnclosure)
	}
	
	func parser(_ parser: AlternateEnclosureParser, didFailWithError error: SyndicationFeedError) {
		print(error)
	}
}
