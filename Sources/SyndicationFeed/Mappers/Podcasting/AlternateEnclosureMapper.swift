//
//  AlternateEnclosureMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 12/7/25.
//

import Foundation

struct AlternateEnclosureMapper {
	func mapToAlternateEnclosure(from attributtes: [String : String]) throws(SyndicationFeedError) -> AlternateEnclosure? {
		let typeKey = Podcasting.AlternateEnclosure.AttributeKeys.type.rawValue
		let lengthKey = Podcasting.AlternateEnclosure.AttributeKeys.length.rawValue
		let bitrateKey = Podcasting.AlternateEnclosure.AttributeKeys.bitrate.rawValue
		let heightKey = Podcasting.AlternateEnclosure.AttributeKeys.height.rawValue
		let langKey = Podcasting.AlternateEnclosure.AttributeKeys.lang.rawValue
		let titleKey = Podcasting.AlternateEnclosure.AttributeKeys.title.rawValue
		let relKey = Podcasting.AlternateEnclosure.AttributeKeys.rel.rawValue
		let codecsKey = Podcasting.AlternateEnclosure.AttributeKeys.codecs.rawValue
		let defaultKey = Podcasting.AlternateEnclosure.AttributeKeys.isDefault.rawValue
		
		guard let type = attributtes[typeKey] else {
			throw .unavailableAttribute(typeKey,
																  inTag: Podcasting.AlternateEnclosure.tagName)
		}
		
		var alternateEnclosure = AlternateEnclosure(type: type)
		alternateEnclosure.title = attributtes[titleKey]
		alternateEnclosure.language = attributtes[langKey]
		alternateEnclosure.codecs = attributtes[codecsKey]
		
		if let bitrateContent = attributtes[bitrateKey],
		   let bitrare = Double(bitrateContent)
		{
			alternateEnclosure.bitrate = bitrare
		}
		
		if let heightContent = attributtes[heightKey],
		   let height = Int(heightContent)
		{
			alternateEnclosure.height = height
		}
		
		if let lengthContent = attributtes[lengthKey],
		   let length = Int(lengthContent)
		{
			alternateEnclosure.length = length
		}
		
		if let relContent = attributtes[relKey] {
			alternateEnclosure.rel = relContent
		}
		
		if let isDefault = attributtes[defaultKey] {
			alternateEnclosure.isDefault = (isDefault == "true")
		}
		
		return alternateEnclosure
	}
	
	func mapToSource(from attributtes: [String : String]) throws(SyndicationFeedError) -> AlternateEnclosure.Source {
		let uriKey = Podcasting.Source.AttributeKeys.uri.rawValue
		let contentTypeKey = Podcasting.Source.AttributeKeys.contentType.rawValue
		
		guard let urlContent = attributtes[uriKey],
			  let url = URL(string: urlContent)
		else
		{
			throw .malformedContent
		}
		
		return AlternateEnclosure.Source(url: url, contentType: attributtes[contentTypeKey])
	}
	
	func mapToIntegrity(from attributes: [String : String]) throws(SyndicationFeedError) -> AlternateEnclosure.Integrity {
		let typeKey = Podcasting.Integrity.AttributeKeys.type.rawValue
		let valueKey = Podcasting.Integrity.AttributeKeys.value.rawValue
		
		guard let typeContent = attributes[typeKey] else {
			throw .unavailableAttribute(typeKey,
										inTag: Podcasting.Integrity.tagName)
		}
		
		guard let valueContent = attributes[valueKey] else {
			throw .unavailableAttribute(valueKey,
										inTag: Podcasting.Integrity.tagName)
		}
		
		return AlternateEnclosure.Integrity(type: typeContent, value: valueContent)
	}
}
