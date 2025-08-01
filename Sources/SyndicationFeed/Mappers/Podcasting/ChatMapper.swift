//
//  ChatMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

private typealias Keys = Podcasting.Chat.AttributeKeys

struct ChatMapper {
	func mapToChat(using attributes: [String : String]) throws(SyndicationFeedError) -> Chat {
		guard let server = attributes[Keys.server.rawValue] else {
			throw .unavailableAttribute(Keys.server.rawValue, inTag: Podcasting.Chat.tagName)
		}
		
		guard let networkProtocol = attributes[Keys.networkProtocol.rawValue] else {
			throw .unavailableAttribute(Keys.networkProtocol.rawValue, inTag: Podcasting.Chat.tagName)
		}
		
		
		let chat = Chat(server: server,
						networkProtocol: networkProtocol,
						accountID: attributes[Keys.accountID.rawValue],
						space: attributes[Keys.space.rawValue])
		
		return chat
	}
}
