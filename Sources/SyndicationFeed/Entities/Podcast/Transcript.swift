//
//  Transcript.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

public struct Transcript: Sendable {
	public let link: URL
	public let mimeType: String
	public let language: String?
	public let relativeTo: String?
}
