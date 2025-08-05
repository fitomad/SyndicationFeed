//
//  LicenseMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 15/7/25.
//

import Foundation

struct LicenseMapper {
	func mapToLicense(using attributes: [String : String], titled licenseName: String) -> License {
		let urlValue = attributes[Podcasting.License.AttributeKeys.url.rawValue] ?? ""
		let url = URL(string: urlValue)
		
		return License(title: licenseName, link: url)
	}
}
