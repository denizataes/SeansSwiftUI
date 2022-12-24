// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   var MovieDetail = try? newJSONDecoder().decode(MovieDetail.self, from: jsonData)

import Foundation


// MARK: - MovieDetail
struct MovieDetail {
    var adult: Bool?
    var backdropPath: String?
  //  var belongsToCollection: JSONNull?
    var budget: Int?
   // var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var imdbID: String?
    var originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
 //   var productionCompanies: [ProductionCompany]?
//    var productionCountries: [ProductionCountry]?
    var releaseDate: String?
    var revenue, runtime: Int?
//    var spokenLanguages: [SpokenLanguage]?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Double?

}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    var id: Int?
    var logoPath: String?
    var name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    var iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    var englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}


