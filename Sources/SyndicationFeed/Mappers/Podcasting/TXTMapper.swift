//
//  TXTMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 1/8/25.
//

import Foundation

private typealias Keys = Podcasting.TXT.AttributeKeys

struct TXTMapper {
	func mapToTXT(from attributes: [String : String], text: String) -> TXT {
		TXT(value: text,
			purpose: attributes[Keys.purpose.rawValue])
	}
}
