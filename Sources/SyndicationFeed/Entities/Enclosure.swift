//
//  Enclosure.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/10/24.
//

import Foundation

public struct Enclosure: Sendable {
	var url: URL
	var length: Int
	var type: String
}
