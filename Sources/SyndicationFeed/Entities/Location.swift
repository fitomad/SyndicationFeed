//
//  Location.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

public struct Location: Sendable {
	public enum Relative: String, Sendable {
		case subject
		case creator
	}
	
	public struct Coordinates: Equatable, Sendable {
		public var latitude: Double
		public var longitude: Double
	}
	
	public let name: String
	public internal(set) var relativeTo: Location.Relative?
	public internal(set) var coordinates: Location.Coordinates?
	public internal(set) var openStreetMapId: String?
	public internal(set) var country: String?
	
	init(named name: String, relativeTo: Location.Relative? = nil, openStreetMapId: String? = nil, country: String? = nil, in coordinates: String? = nil) {
		self.name = name
		self.relativeTo = relativeTo
		self.openStreetMapId = openStreetMapId
		self.country = country
		
		if let coordinates {
			let coordinatesValues = coordinates.split(separator: ",")
			
			if let latitude = Double(String(coordinatesValues[0].trimmingCharacters(in: .whitespaces))),
			   let longitude = Double((String(coordinatesValues[1].trimmingCharacters(in: .whitespaces))))
			{
				self.coordinates = .init(latitude: latitude, longitude: longitude)
			} else {
				self.coordinates = nil
			}
		} else {
			self.coordinates = nil
		}
	}
}
