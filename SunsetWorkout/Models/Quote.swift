//
//  Quote.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//

struct Quote: Codable {
    let author: String
    let content: String
    let tags: [String]

    func getTagsFormatted() -> String {
        let tagsString = tags.joined(separator: ",")

        return tagsString.prefix(1).uppercased() + tagsString.dropFirst()
    }
}
