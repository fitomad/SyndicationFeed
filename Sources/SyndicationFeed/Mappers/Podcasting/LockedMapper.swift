//
//  LockedMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

struct LockedMapper {
	func mapToLocked(using attributes: [String : String], locked value: String) -> Channel.Locked {
		return Channel.Locked(value: value,
							  owner: attributes[Podcasting.Locked.AttributeKeys.owner.rawValue])
	}
}
