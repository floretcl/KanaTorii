//
//  ModelData.swift
//  Kana Torii
//
//  Created by Clément FLORET on 01/01/2021.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    var kanasForList: [KanaForList] = load("kanaForListData.json")
    @Published var kanas: [Kana] = load("kanaData.json")
    var lessons: [LessonForList] = load("lessonData.json")
}
func load<T: Decodable>(_ filename: String) -> T {
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
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
