//
//  AppleDurationMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

struct AppleDurationMapper {
	func mapToDuration(from string: String) throws(SyndicationFeedError) -> Int {
		if let seconds = Int(string) {
			return seconds
		}
		
		if string.contains(":") {
			let timeparts = string.split(separator: ":")
			
			guard timeparts.count == 2,
				  let minutes = Int(timeparts[0]),
				  let seconds = Int(timeparts[1])
			else
			{
				throw .malformedContent
			}
			
			return (minutes * 60) + seconds
		}
		
		throw .malformedContent
	}
}
