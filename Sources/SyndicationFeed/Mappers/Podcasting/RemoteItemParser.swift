//
//  RemoteItemParser.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//


import Foundation

private typealias Keys = Podcasting.RemoteItem.AttributeKeys

struct RemoteItemParser {
	func mapToRemoteItem(from attributes: [String : String]) throws(SyndicationFeedError) -> Podroll.RemoteItem {
		guard let feedUUIDValue = attributes[Keys.feedGUID.rawValue] else {
			throw .unavailableAttribute(Keys.feedGUID.rawValue, inTag: Podcasting.RemoteItem.tagName)
		}
		
		guard let uuid = UUID(uuidString: feedUUIDValue) else {
			throw .malformedAttributeValue(feedUUIDValue, attribute:
											Keys.feedGUID.rawValue, tag:
											Podcasting.RemoteItem.tagName)
		}
		
		var medium: Medium?
		
		if let mediumString = attributes[Keys.medium.rawValue],
		   let mediumValue = Medium(rawValue: mediumString)
		{
			medium = mediumValue
		}
		
		var feedURL: URL?
		
		if let urlString = attributes[Keys.feedURL.rawValue],
		   let urlValue = URL(string: urlString)
		{
			feedURL = urlValue
		}
		
		let remoteItem = Podroll.RemoteItem(feedGUID: uuid,
											feedURL: feedURL,
											itemGUID: attributes[Keys.itemGUID.rawValue],
											medium: medium,
											title: attributes[Keys.title.rawValue])
		
		return remoteItem
	}
}
