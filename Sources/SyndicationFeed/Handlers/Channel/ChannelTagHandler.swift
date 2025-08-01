//
//  ChannelTagHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

protocol ChannelTagHandler {
	func applyChanges(to channel: inout Channel)
}
