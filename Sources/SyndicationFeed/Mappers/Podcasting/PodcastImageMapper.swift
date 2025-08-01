//
//  PodcastImageMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct PodcastImageMapper {
	func mapToPodcastImage(from attributes: [String : String]) throws(SyndicationFeedError) -> PodcastImage {
		guard let urlString = attributes[Podcasting.Image.AttributeKeys.href.rawValue],
			  let imageURL = URL(string: urlString)
		else
		{
			throw SyndicationFeedError.unavailableAttribute(Podcasting.Image.AttributeKeys.href.rawValue,
																  inTag: Podcasting.Image.tagName)
		}
		
		var imageSize: PodcastImage.Size?
		
		if let widthString = attributes[Podcasting.Image.AttributeKeys.width.rawValue],
		   let heightString = attributes[Podcasting.Image.AttributeKeys.height.rawValue],
		   let imageWidth = Int(widthString),
		   let imageHeight = Int(heightString)
		{
			imageSize = PodcastImage.Size(width: imageWidth, height: imageHeight)
		}
		
		var imagePurpose: PodcastImage.Purpose?
		
		if let purposeString = attributes[Podcasting.Image.AttributeKeys.purpose.rawValue] {
			switch purposeString.lowercased() {
				case "artwork": imagePurpose = .artwork
				case "social": imagePurpose = .social
				case "canvas": imagePurpose = .canvas
				case "banner": imagePurpose = .banner
				case "publisher": imagePurpose = .publisher
				case "circular": imagePurpose = .circular
				default: imagePurpose = .custom(purposeString)
			}
		}
		
		return PodcastImage(url: imageURL,
							alternateText: attributes[Podcasting.Image.AttributeKeys.alt.rawValue],
							aspectRatio: attributes[Podcasting.Image.AttributeKeys.aspectRatio.rawValue],
							size: imageSize,
							mimeType: attributes[Podcasting.Image.AttributeKeys.type.rawValue],
							purpose: imagePurpose)
	}
}
