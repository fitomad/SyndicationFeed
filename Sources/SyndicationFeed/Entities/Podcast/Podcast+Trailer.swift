//
//  Trailer.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

public struct Trailer: Sendable {
	var title: String
	var publishedAt: Date
	var link: URL
	var length: Int?
	var type: String?
	var season: Int?
}
