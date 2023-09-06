//
//  ModelData.swift
//  Nestup
//
//  Created by Aaron Arellano on 2023-08-08.
//

import Foundation

var users: [User] = loadJson("userData.json")
var posts: [Post] = loadJson("postData.json")
var commonWords: [String] = loadTxt("commonWords") ?? []
var specialChars: [String] = loadTxt("specialChars") ?? []

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print(error.localizedDescription)
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func loadTxt(_ filename: String) -> [String]? {
    if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            let words = data.components(separatedBy: .newlines)
            return words
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    } else {
        fatalError("Couldn't load \(filename) from main bundle.")
    }
}
