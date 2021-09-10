//
//  weather.swift
//  Le Baluchon
//
//  Created by ROUX Maxime on 31/08/2021.
//

import Foundation

struct Meteo: Decodable {
    let cnt: Int
    let list: [List]

    struct List: Decodable {
        let coord: Coord
        let sys: Sys
        let weather: [Weather]
        let main: Main
        let visibility: Int
        let wind: Wind
        let clouds: Clouds
        let dt, id: Int
        let name: String

        // MARK: - Clouds
        struct Clouds: Decodable {
            let all: Int
        }

        // MARK: - Coord
        struct Coord: Decodable {
            let lon, lat: Double
        }

        // MARK: - Main
        struct Main: Decodable {
            let temp, feelsLike, tempMin, tempMax: Double
            let pressure, humidity: Int

            enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure, humidity
            }
        }

        // MARK: - Sys
        struct Sys: Decodable {
            let country: String
            let timezone, sunrise, sunset: Int
        }

        // MARK: - Weather
        struct Weather: Decodable {
            let id: Int
            let main, weatherDescription, icon: String

            enum CodingKeys: String, CodingKey {
                case id, main
                case weatherDescription = "description"
                case icon
            }
        }

        // MARK: - Wind
        struct Wind: Decodable {
            let speed: Double
            let deg: Int
        }
    }
}
