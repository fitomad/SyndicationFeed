//
//  PodpingMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

private typealias Keys = Podcasting.Podping.AttributeKeys

struct PodpingMapper {
	func mapToBool(using attributes: [String : String]) -> Bool {
		guard let value = attributes[Keys.usesPodping.rawValue] else {
			return false
		}
		
		return value.lowercased() == "true"
	}
}
