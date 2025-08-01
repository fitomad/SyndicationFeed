//
//  SocialInteract.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

public struct SocialInteract {
	public enum NetworkProtocol: String {
		case disabled
		case activitypub
		case twitter
		case lightning
		case atproto
		case hive
		case matrix
		case nostr
	}
	
	public let `protocol`: NetworkProtocol
	public let url: URL
	public internal(set) var accountID: String?
	public internal(set) var accountURL: URL?
	public internal(set) var priority: Int?
	
}
