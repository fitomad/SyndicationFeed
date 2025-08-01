//
//  LocationMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

struct LocationMapper {
	func mapToLocation(from attributes: [String : String], place name: String) -> Location {
		var location = Location(named: name)
		
		if let relativeContent = attributes[Podcasting.Location.AttributeKeys.rel.rawValue],
		   let relative = Location.Relative(rawValue: relativeContent)
		{
			location.relativeTo = relative
		}
		
		if let coordinatesContent = attributes[Podcasting.Location.AttributeKeys.geo.rawValue] {
			let coordinates = coordinatesContent.split(separator: ",")
			
			if let latitude = Double(coordinates[0]),
			   let longitude = Double(coordinates[1])
			{
				location.coordinates = Location.Coordinates(latitude: latitude, longitude: longitude)
			}
		}
		
		if let openStreetMapId = attributes[Podcasting.Location.AttributeKeys.osm.rawValue] {
			location.openStreetMapId = openStreetMapId
		}
		
		if let countryCode = attributes[Podcasting.Location.AttributeKeys.country.rawValue] {
			location.country = countryCode
		}
		
		return location
	}
}
