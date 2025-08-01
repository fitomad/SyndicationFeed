//
//  ChannelParser.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

typealias ChannelHanler = TagHandler & ChannelTagHandler

final class ChannelParser: NSObject {
	private let parser: XMLParser
	weak var delegate: (any ChannelParserDelegate)?
	
	private var currentTag = ""
	private var currentAttributes = [String : String]()
	private var currentCharacters = ""
	
	private var nestedXmlDelegate: XMLParserDelegate?
	
	var handlers: [any ChannelHanler]
	
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
	
	func start() {
		self.parser.parse()
	}
	
	private func createChain() {
		for index in 0 ..< (handlers.count - 1) {
			handlers[index].nextHandler = handlers[index + 1]
		}
	}
}

extension ChannelParser: Restorable {
	func restoreParserDelegate() {
		self.parser.delegate = self
		nestedXmlDelegate = nil
	}
}

extension ChannelParser: XMLParserDelegate {
	public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		currentAttributes = attributeDict
		currentCharacters.removeAll()
		currentTag = elementName
		
		if elementName == Podcasting.LiveItem.tagName {
			let liveItemParser = LiveItemParser(attributes: attributeDict, usingRootParser: self.parser)
			liveItemParser.delegate = self
			
			parser.delegate = liveItemParser
			nestedXmlDelegate = liveItemParser
		}
		
		if elementName == Podcasting.Podroll.tagName {
			let podrollParser = PodrollParser()
			podrollParser.delegate = self
			
			parser.delegate = podrollParser
			nestedXmlDelegate = podrollParser
		}
		
		if elementName == Podcasting.Value.tagName {
			let valueParser = ValueParser(attributes: attributeDict)
			valueParser.delegate = self
			
			parser.delegate = valueParser
			nestedXmlDelegate = valueParser
		}
		
		if elementName == RSS.Image.tagName {
			let imageParser = ImageParser()
			imageParser.delegate = self
			
			parser.delegate = imageParser
			nestedXmlDelegate = imageParser
		}
		
		
		
		if elementName == RSS.Item.tagName {
			let itemParser = ItemParser(rootXMLParser: self.parser)
			itemParser.delegate = self
			
			parser.delegate = itemParser
			nestedXmlDelegate = itemParser
		}
	}
	
	public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == RSS.Channel.tagName {
			parser.abortParsing()
			
			handlers.forEach { $0.applyChanges(to: &channel) }
			channel.podcasting?.liveItems = liveItems.isEmpty ? nil : liveItems
			channel.podcasting?.podroll = podroll
			channel.podcasting?.values = values
			
			delegate?.channelParser(self, didFinishParse: channel)
		} else {
			handlers.first?.processTag(elementName, text: currentCharacters, withAttributes: currentAttributes)
		}
	}
	
	public func parser(_ parser: XMLParser, foundCharacters string: String) {
		currentCharacters.append(string)
	}
	
	public func parser(_ parser: XMLParser, parseErrorOccurred parseError: any Error) {
		print("🚨 \(parseError)")
	}
}

extension ChannelParser: ImageParserDelegate {
	func imageParser(_ parser: ImageParser, didFinishParse image: RSSImage) {
		channel.image = image
		restoreParserDelegate()
	}
	
	func imageParser(_ parser: ImageParser, didFailWithError error: ImageParser.Failure) {
		restoreParserDelegate()
	}
}

extension ChannelParser: LiveItemParserDelegate {
	func parser(_ parser: LiveItemParser, didFinishParse liveItem: Channel.LiveItem) {
		liveItems.append(liveItem)
		restoreParserDelegate()
	}
	
	func parser(_ parser: LiveItemParser, didFailWithError error: SyndicationFeedError) {
		restoreParserDelegate()
	}
}

extension ChannelParser: PodrollParserDelegate {
	func parser(_ parser: PodrollParser, didFinishParse podroll: Podroll) {
		self.podroll = podroll
		restoreParserDelegate()
	}
	
	func parser(_ parser: PodrollParser, didFinishWithError error: SyndicationFeedError) {
		restoreParserDelegate()
	}
}

extension ChannelParser: ValueParserDelegate {
	func parser(_ parser: ValueParser, didFinishParse value: PodcastValue) {
		values.append(value)
		restoreParserDelegate()
	}
	
	func parser(_ parser: ValueParser, didFailWithError error: SyndicationFeedError) {
		restoreParserDelegate()
	}
}

extension ChannelParser: ItemParserDelegate {
	func parser(_ parser: ItemParser, didFinishParse item: Item) {
		channel.items.append(item)
		restoreParserDelegate()
	}
}
