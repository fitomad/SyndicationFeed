//
//  CloudMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 29/7/25.
//

import Foundation

struct CloudMapper {
	func mapToCloud(from attributes: [String : String]) throws(SyndicationFeedError) -> Cloud {
		let domainKey = RSS.Cloud.AttributeKeys.domain.rawValue
		let portKey = RSS.Cloud.AttributeKeys.port.rawValue
		let pathKey = RSS.Cloud.AttributeKeys.path.rawValue
		let registerProcedureKey = RSS.Cloud.AttributeKeys.registerProcedure.rawValue
		let protocolKey = RSS.Cloud.AttributeKeys.networkProtocol.rawValue
		
		guard let domainContent = attributes[domainKey] else {
			throw .unavailableAttribute(domainKey,
										inTag: RSS.Cloud.tagName)
		}
		
		guard let portContent = attributes[portKey] else {
			throw .unavailableAttribute(portKey,
										inTag: RSS.Cloud.tagName)
		}
		
		guard let pathContent = attributes[pathKey] else {
			throw .unavailableAttribute(pathKey,
										inTag: RSS.Cloud.tagName)
		}
		
		guard let registerProcedureContent = attributes[registerProcedureKey] else {
			throw .unavailableAttribute(registerProcedureKey,
										inTag: RSS.Cloud.tagName)
		}
		
		guard let protocolContent = attributes[protocolKey] else {
			throw .unavailableAttribute(protocolKey,
										inTag: RSS.Cloud.tagName)
		}
		
		guard let portValue = Int(portContent) else {
			throw .malformedAttributeValue(portContent,
										   attribute: portKey,
										   tag: RSS.Cloud.tagName)
		}
		
		return Cloud(domain: domainContent,
					 port: portValue,
					 path: pathContent,
					 registerProcedure: registerProcedureContent,
					 networkProtocol: protocolContent)
	}
}
