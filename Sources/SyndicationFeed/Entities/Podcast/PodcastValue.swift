//
//  PodcastValue.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/10/24.
//

import Foundation

public struct PodcastValue: Sendable {
	public struct Recipient: Sendable {
		public let type: String
		public let address: String
		public let splitValue: Int
		
		public internal(set) var name: String?
		public internal(set) var customKey: String?
		public internal(set) var customValue: String?
		public internal(set) var isFee: Bool = false
	}
	
	var kind: String
	var method: String
	var suggestedAmmount: Double
	var recipients = [PodcastValue.Recipient]()
}
