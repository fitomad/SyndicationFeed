//
//  PodroolParser.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

protocol PodrollParserDelegate: AnyObject {
	func parser(_ parser: PodrollParser, didFinishParse podroll: Podroll)
	func parser(_ parser: PodrollParser, didFinishWithError error: SyndicationFeedError)
}

final class PodrollParser: NSObject {
	var remoteItems = [Podroll.RemoteItem]()
	weak var delegate: PodrollParserDelegate?
}

extension PodrollParser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		if elementName == Podcasting.RemoteItem.tagName {
			let mapper = RemoteItemParser()
			
			do {
				let remoteItem = try mapper.mapToRemoteItem(from: attributeDict)
				remoteItems.append(remoteItem)
			} catch {
				delegate?.parser(self, didFinishWithError: .malformedContent)
			}
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == Podcasting.Podroll.tagName {
			let podroll = Podroll(remoteItems: remoteItems)
			delegate?.parser(self, didFinishParse: podroll)
		}
	}
}
