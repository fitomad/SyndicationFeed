//
//  ItemPodcastingHandler.swift
//  SyndicationFeed
//
//  Created by Adolfo Vera Blasco on 28/7/25.
//

import Foundation

final class ItemPodcastingHandler: TagHandler {
	var details = Item.Podcasting()
	var nextHandler: (any TagHandler)?
	
	func processTag(_ tagName: String, text: String, withAttributes attributesDict: [String : String]) {
		switch tagName {
			case Podcasting.Images.tagName:
				let mapper = ImageSetMapper()
				let imageSet = try? mapper.mapToImages(from: attributesDict)
				details.imagesSet = imageSet
			case Podcasting.Image.tagName:
				let mapper = PodcastImageMapper()
				let podcastImage = try? mapper.mapToPodcastImage(from: attributesDict)
				addImage(podcastImage)
			case Podcasting.Season.tagName:
				let mapper = SeasonMapper()
				if let season = try? mapper.mapToSeason(from: attributesDict, seasonValue: text) {
					details.season = season
				}
			case Podcasting.Episode.tagName:
				let mapper = EpisodeMapper()
				if let itemEpisode = try? mapper.mapToEpisode(from: attributesDict, episodeValue: text) {
					details.episode = itemEpisode
				}
			case Podcasting.Chapters.tagName:
				let mapper = ChaptersMapper()
				if let chapters = try? mapper.mapToChapter(from: attributesDict) {
					details.chapters = chapters
				}
			case Podcasting.Soundbite.tagName:
				let mapper = SoundbiteMapper()
				let soundbite = try? mapper.mapToSoundbite(from: attributesDict, title: text)
				addSoundbite(soundbite)
			case Podcasting.Transcript.tagName:
				let mapper = TranscriptMapper()
				let transcript = try? mapper.mapToTranscript(from: attributesDict)
				addTranscript(transcript)
			case Podcasting.Person.tagName:
				let mapper = PersonMapper()
				let person = mapper.mapToPerson(from: attributesDict, name: text)
				addPerson(person)
			case Podcasting.SocialInteract.tagName:
				let mapper = SocialInteractMapper()
				let socialInteract = try? mapper.mapToSocialInteract(from: attributesDict)
				addSocialInteract(socialInteract)
			default:
				nextHandler?.processTag(tagName, text: text, withAttributes: attributesDict)
		}
	}
	
	private func addImage(_ image: PodcastImage?) {
		if details.images == nil {
			details.images = [PodcastImage]()
		}
		
		if let image {
			details.images?.append(image)
		}
	}
	
	private func addSoundbite(_ soundbite: Soundbite?) {
		if details.soundbites == nil {
			details.soundbites = [Soundbite]()
		}
		
		if let soundbite {
			details.soundbites?.append(soundbite)
		}
	}
	
	private func addTranscript(_ transcript: Transcript?) {
		if details.transcripts == nil {
			details.transcripts = [Transcript]()
		}
		
		if let transcript {
			details.transcripts?.append(transcript)
		}
	}
	
	private func addPerson(_ person: Person) {
		if details.personas == nil {
			details.personas = [Person]()
		}
		
		details.personas?.append(person)
	}
	
	private func addSocialInteract(_ interact: SocialInteract?) {
		if details.socialProfiles == nil {
			details.socialProfiles = [SocialInteract]()
		}
		
		if let interact {
			details.socialProfiles?.append(interact)
		}
	}
}

extension ItemPodcastingHandler: ItemTagHandler {
	func applyChanges(to item: inout Item) {
		item.podcasting = details
	}
}
