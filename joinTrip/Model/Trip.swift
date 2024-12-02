//
//  Trip.swift
//  joinTrip
//
//  Created by Michelle Swastika on 08/11/24.
//

import Foundation

struct Trip: Encodable {
    let name: String
    let currency: String
    let trip_code: String
    let total: Double
    let start_date: String
    let end_date: String
}
