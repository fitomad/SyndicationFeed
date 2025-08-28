//
//  TreilerMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

private typealias Keys = Podcasting.Trailer.AttributeKeys

struct TrailerMapper {
	func mapToTrailer(from attributes: [String : String], title: String) throws(SyndicationFeedError) -> Trailer {
		guard let urlString = attributes[Keys.url.rawValue] else {
			throw .unavailableAttribute(Keys.url.rawValue, inTag: Podcasting.Trailer.tagName)
		}
		
		guard let urlValue = URL(string: urlString) else {
			throw .malformedAttributeValue(urlString,
										   attribute: Keys.url.rawValue,
										   tag: Podcasting.Trailer.tagName)
		}
		
		guard let dateString = attributes[Keys.pubdate.rawValue] else {
			throw .unavailableAttribute(Keys.pubdate.rawValue, inTag: Podcasting.Trailer.tagName)
		}
		
		guard let publicationDate = DateFormatter.publicationDateFormatter.date(from: dateString) else {
			throw .malformedAttributeValue(dateString,
										   attribute: Keys.pubdate.rawValue,
										   tag: Podcasting.Trailer.tagName)
		}
		
		var fileLenght: Int?
		
		if let fileLenghtString = attributes[Keys.length.rawValue],
		   let lenght = Int(fileLenghtString)
		{
			fileLenght = lenght
		}
		
		var seasonNumber: Int?
		
		if let seasonNumberString = attributes[Keys.season.rawValue],
		   let seasonNumberValue = Int(seasonNumberString)
		{
			seasonNumber = seasonNumberValue
		}
		
		let trailer = Trailer(title: title,
							  publishedAt: publicationDate,
							  link: urlValue,
							  length: fileLenght,
							  type: attributes[Keys.type.rawValue],
							  season: seasonNumber)
		
		return trailer
	}
}
