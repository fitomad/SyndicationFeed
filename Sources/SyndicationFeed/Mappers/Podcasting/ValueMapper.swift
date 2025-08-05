//
//  ValueMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 27/7/25.
//

import Foundation

struct ValueMapper {
	func mapToValue(from attributes: [String : String]) throws(SyndicationFeedError) -> PodcastValue {
		guard let valueType = attributes[Podcasting.Value.AttributeKeys.type.rawValue] else {
			throw SyndicationFeedError.unavailableAttribute(Podcasting.Value.AttributeKeys.type.rawValue,
																  inTag: Podcasting.Value.tagName)
		}
		
		guard let valueMethod = attributes[Podcasting.Value.AttributeKeys.method.rawValue] else {
			throw SyndicationFeedError.unavailableAttribute(Podcasting.Value.AttributeKeys.type.rawValue,
																  inTag: Podcasting.Value.tagName)
		}
		
		var amount = 0.0
		
		if let amountString = attributes[Podcasting.Value.AttributeKeys.suggested.rawValue],
		   let amountValue = Double(amountString)
		{
			amount = amountValue
		}
		
		return PodcastValue(kind: valueType,
							method: valueMethod,
							suggestedAmmount: amount)
	}
	
	func mapToValueRecipient(from attributes: [String : String]) throws -> PodcastValue.Recipient? {
		let typeKey = Podcasting.ValueRecipient.AttributeKeys.type.rawValue
		let addressKey = Podcasting.ValueRecipient.AttributeKeys.address.rawValue
		let splitKey = Podcasting.ValueRecipient.AttributeKeys.split.rawValue
		
		guard let typeContent = attributes[typeKey] else {
			throw SyndicationFeedError.unavailableAttribute(typeKey,
																  inTag: Podcasting.ValueRecipient.tagName)
		}
		
		guard let addressContent = attributes[addressKey] else {
			throw SyndicationFeedError.unavailableAttribute(addressKey,
																  inTag: Podcasting.ValueRecipient.tagName)
		}
		
		guard let splitContent = attributes[splitKey] else {
			throw SyndicationFeedError.unavailableAttribute(splitKey,
																  inTag: Podcasting.ValueRecipient.tagName)
		
		}
		
		guard let splitValue = Int(splitContent) else {
			throw SyndicationFeedError.malformedContent
		}
		
		var recipient = PodcastValue.Recipient(type: typeContent,
											   address: addressContent,
											   splitValue: splitValue)
		
		recipient.name = attributes[Podcasting.ValueRecipient.AttributeKeys.name.rawValue]
		recipient.customKey = attributes[Podcasting.ValueRecipient.AttributeKeys.customKey.rawValue]
		recipient.customValue = attributes[Podcasting.ValueRecipient.AttributeKeys.customValue.rawValue]
		
		if let feeContent = attributes[Podcasting.ValueRecipient.AttributeKeys.fee.rawValue] {
			recipient.isFee = feeContent.lowercased() == "true"
		}
		
		return recipient
	}
}
