//
//  ChannelParser.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

typealias ChannelHanler = TagHandler & ChannelTagHandler

final class ChannelParser: NSObject {
	private let parser: XMLParser
	weak var delegate: (any ChannelParserDelegate)?
	private var nestedXMLDelegate: (any XMLParserDelegate)?
	
	private var currentTag = ""
	private var currentAttributes = [String : String]()
	private var currentCharacters = ""
	
	private var handlers: [any ChannelHanler]
	
	private var parseFailures = [SyndicationFeedError]()
	
	private var channel = Channel()
	private var liveItems = [Channel.LiveItem]()
	private var podroll: Podroll?
	private var values = [PodcastValue]()
	
	init(data: Data) {
		self.parser = XMLParser(data: data)
		
		handlers = [
			ChannelRSSHandler(),
			ChannelPodcastingHandler(),
			ChannelApplePodcastHandler()
		]
		
		super.init()
		
		createChain()
				
		self.parser.delegate = self
	}
	
	deinit {
		nestedXMLDelegate = nil
	}
	
	func start() {
		self.parser.parse()
	}
	
	private func createChain() {
		for index in 0 ..< (handlers.count - 1) {
			handlers[index].nextHandler = handlers[index + 1]
		}
	}
}

extension ChannelParser: XMLParserDelegate {
	public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		currentAttributes = attributeDict
		currentCharacters.removeAll()
		currentTag = elementName
		
		if elementName == Podcasting.LiveItem.tagName {
			let liveItemParser = LiveItemParser(rootXMLDelegate: self, rootParser: parser)
			liveItemParser.delegate = self
			liveItemParser.didStartParseElement(withAttributes: attributeDict)
			
			parser.delegate = liveItemParser
			nestedXMLDelegate = liveItemParser
		}
		
		if elementName == Podcasting.Podroll.tagName {
			let podrollParser = PodrollParser(rootXMLDelegate: self, rootParser: parser)
			podrollParser.delegate = self
			
			parser.delegate = podrollParser
			nestedXMLDelegate = podrollParser
		}
		
		if elementName == Podcasting.Value.tagName {
			let valueParser = ValueParser(rootXMLDelegate: self, rootParser: parser)
			valueParser.delegate = self
			valueParser.didStartParseElement(withAttributes: attributeDict)
			
			parser.delegate = valueParser
			nestedXMLDelegate = valueParser
		}
		
		if elementName == RSS.Image.tagName {
			let imageParser = ImageParser(rootXMLDelegate: self, rootParser: parser)
			imageParser.delegate = self
			
			parser.delegate = imageParser
			nestedXMLDelegate = imageParser
		}
		
		if elementName == RSS.Item.tagName {
			let itemParser = ItemParser(rootXMLDelegate: self, rootParser: parser)
			itemParser.delegate = self
			
			parser.delegate = itemParser
			nestedXMLDelegate = itemParser
		}
	}
	
	public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == RSS.Channel.tagName {
			parser.abortParsing()
			
			handlers.forEach { $0.applyChanges(to: &channel) }
			channel.podcasting?.liveItems = liveItems.isEmpty ? nil : liveItems
			channel.podcasting?.podroll = podroll
			channel.podcasting?.values = values
			
			handlers.removeAll()
			
			delegate?.channelParser(self, didFinishParse: channel, withParsingErrorsFound: parseFailures)
		} else {
			do {
				try handlers.first?.processTag(elementName, text: currentCharacters, withAttributes: currentAttributes)
			} catch {
				parseFailures.append(error)
			}
		}
	}
	
	public func parser(_ parser: XMLParser, foundCharacters string: String) {
		let elementString = string.trimmingCharacters(in: .whitespacesAndNewlines)
		
		if elementString.count > 0 {
			currentCharacters.append(string)
		}
	}
	
	public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
		guard var string = String(data: CDATABlock, encoding: .utf8) else {
			return
		}
		
		string = string.trimmingCharacters(in: .whitespacesAndNewlines)
		
		if string.count > 0 {
			currentCharacters.append(string)
		}
	}
	
	public func parser(_ parser: XMLParser, parseErrorOccurred parseError: any Error) {
		
	}
}

extension ChannelParser: ImageParserDelegate {
	func imageParser(_ parser: ImageParser, didFinishParse image: RSSImage) {
		channel.image = image
	}
	
	func imageParser(_ parser: ImageParser, didFailWithError error: SyndicationFeedError) {
		parseFailures.append(error)
	}
}

extension ChannelParser: LiveItemParserDelegate {
	func parser(_ parser: LiveItemParser, didFinishParse liveItem: Channel.LiveItem) {
		liveItems.append(liveItem)
	}
	
	func parser(_ parser: LiveItemParser, didFailWithError error: SyndicationFeedError) {
		parseFailures.append(error)
	}
}

extension ChannelParser: PodrollParserDelegate {
	func parser(_ parser: PodrollParser, didFinishParse podroll: Podroll) {
		self.podroll = podroll
	}
	
	func parser(_ parser: PodrollParser, didFinishWithError error: SyndicationFeedError) {
		parseFailures.append(error)
	}
}

extension ChannelParser: ValueParserDelegate {
	func parser(_ parser: ValueParser, didFinishParse value: PodcastValue) {
		values.append(value)
	}
	
	func parser(_ parser: ValueParser, didFailWithError error: SyndicationFeedError) {
		parseFailures.append(error)
	}
}

extension ChannelParser: ItemParserDelegate {
	func parser(_ parser: ItemParser, didFinishParse item: Item, withErrors errors: [SyndicationFeedError]) {
		if !errors.isEmpty {
			parseFailures.append(contentsOf: errors)
		}
		
		channel.items.append(item)
	}
}
