//
//  SocialMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct SocialInteractMapper {
	func mapToSocialInteract(from attributes: [String : String]) throws(SyndicationFeedError) -> SocialInteract {
		let protocolKey = Podcasting.SocialInteract.AttributeKeys.protocol.rawValue
		let uriKey = Podcasting.SocialInteract.AttributeKeys.uri.rawValue
		
		guard let protocolContent = attributes[protocolKey] else {
			throw SyndicationFeedError.unavailableAttribute(protocolKey,
																  inTag: Podcasting.SocialInteract.tagName)
		}
		
		guard let uriContent = attributes[uriKey] else {
			throw SyndicationFeedError.unavailableAttribute(uriKey,
																  inTag: Podcasting.SocialInteract.tagName)
		}
		
		guard let protocolValue = SocialInteract.NetworkProtocol(rawValue: protocolContent),
			  let uriValue = URL(string: uriContent)
		else
		{
			throw SyndicationFeedError.malformedContent
		}
		
		var socialInteract = SocialInteract(protocol: protocolValue,
											url: uriValue)
		
		let accountIDKey = Podcasting.SocialInteract.AttributeKeys.accountId.rawValue
		let accountURLKey = Podcasting.SocialInteract.AttributeKeys.accountUrl.rawValue
		let priorityKey = Podcasting.SocialInteract.AttributeKeys.priority.rawValue
		
		
		if let accountID = attributes[accountIDKey] {
			socialInteract.accountID = accountID
		}
		
		if let accountURLContent = attributes[accountURLKey],
		   let accountURL = URL(string: accountURLContent)
		{
			socialInteract.accountURL = accountURL
		}
		
		if let priorityContent = attributes[priorityKey],
		   let priorityValue = Int(priorityContent)
		{
			socialInteract.priority = priorityValue
		}
		
		return socialInteract
	}
}
