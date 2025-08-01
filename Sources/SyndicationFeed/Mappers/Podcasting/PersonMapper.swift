//
//  PersonMapper.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

struct PersonMapper {
	func mapToPerson(from attributes: [String : String], name: String) -> Person {
		var person = Person(name: name)
		
		if let role = attributes[Podcasting.Person.AttributeKeys.role.rawValue] {
			person.role = role
		}
		
		if let group = attributes[Podcasting.Person.AttributeKeys.group.rawValue] {
			person.group = group
		}
		
		if let imageURLContent = attributes[Podcasting.Person.AttributeKeys.img.rawValue],
		   let imageURL = URL(string: imageURLContent)
		{
			person.avatarURL = imageURL
		}
		
		if let linkContent = attributes[Podcasting.Person.AttributeKeys.href.rawValue],
		   let linkURL = URL(string: linkContent)
		{
			person.link = linkURL
		}
		
		return person
	}
}
