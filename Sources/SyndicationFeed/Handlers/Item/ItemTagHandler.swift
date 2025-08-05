//
//  ItemTagHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

protocol ItemTagHandler {
	func applyChanges(to Item: inout Item)
}
