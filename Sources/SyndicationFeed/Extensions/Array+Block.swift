//
//  Array+Block.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/8/25.
//

import Foundation

extension Array where Element == Block {
	public var isGenerallyBlocked: Bool {
		let generalBlock = self.filter { $0.service == nil }
							   .filter { $0.isBlocked == true }
							   .first
		
		return generalBlock != nil
	}
	
	public func isChannelBlockedFor(service: PodcastService) -> Bool? {
		let block = self.filter { $0.service == service }
						.first
		
		guard let block else { return nil }
		
		return block.isBlocked
	}
}
