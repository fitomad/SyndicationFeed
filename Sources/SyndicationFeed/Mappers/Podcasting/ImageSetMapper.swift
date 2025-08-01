//
//  ImagesMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 26/7/25.
//

import Foundation

struct ImageSetMapper {
	func mapToImages(from attributes: [String : String]) throws(SyndicationFeedError) -> ImageSet {
		let srcsetKey = Podcasting.Images.AttributeKeys.srcset.rawValue
		guard let sourceSet = attributes[srcsetKey] else {
			throw .unavailableAttribute(srcsetKey,
										inTag: Podcasting.Images.tagName)
		}
		
		let images = sourceSet.split(separator: ",")
			.compactMap { imageSource -> ImageSet.Image? in
				let imageInformation = imageSource.split(separator: " ")
				
				guard let url = URL(string: String(imageInformation[0])) else {
					return nil
				}
				
				var sizeString = String(imageInformation[1])
				sizeString.replace("w", with: "")
				
				guard let width = Int(sizeString) else {
					return nil
				}
				
				return ImageSet.Image(url: url, with: width)
			}
		
		return ImageSet(images: images)
	}
}
