//
//  BlockMapper.swift
//  PodcastFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

struct BlockMapper {
	func mapToBlock(using attributes: [String : String], status: String) -> Block {
		var serviceBlocked: PodcastService?
		
		if let serviceID = attributes[Podcasting.Block.AttributeKeys.id.rawValue],
		   let service = PodcastService(rawValue: serviceID)
		{
			serviceBlocked = service
		}
		 
		return Block(value: status, service: serviceBlocked)
	}
}
