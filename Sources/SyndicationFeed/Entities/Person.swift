//
//  Person.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 11/7/25.
//

import Foundation

public struct Person: Sendable {
	public var role = "host"
	public var group = "cast"
	public var avatarURL: URL?
	public var link: URL?
	public var name: String
}
