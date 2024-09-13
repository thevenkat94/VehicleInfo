//
//  VehicleModel.swift
//  Vehicle Information
//
//  Created by Venkat on 12/09/24.
//

import Foundation

// MARK: - VehicleInfof
/// Represents vehicle information and conforms to Codable.
struct VehicleInfo: Codable {
    
    let status : Int?
    let message : String?
    let vehicle_type : [VehicleType]?
    let vehicle_capacity : [VehicleCapacity]?
    let vehicle_make : [VehicleMake]?
    let manufacture_year : [ManufactureYear]?
    let fuel_type : [FuelType]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case vehicle_type = "vehicle_type"
        case vehicle_capacity = "vehicle_capacity"
        case vehicle_make = "vehicle_make"
        case manufacture_year = "manufacture_year"
        case fuel_type = "fuel_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        vehicle_type = try values.decodeIfPresent([VehicleType].self, forKey: .vehicle_type)
        vehicle_capacity = try values.decodeIfPresent([VehicleCapacity].self, forKey: .vehicle_capacity)
        vehicle_make = try values.decodeIfPresent([VehicleMake].self, forKey: .vehicle_make)
        manufacture_year = try values.decodeIfPresent([ManufactureYear].self, forKey: .manufacture_year)
        fuel_type = try values.decodeIfPresent([FuelType].self, forKey: .fuel_type)
    }
}

// MARK: - FuelType
/// Represents vehicle fuel type and conforms to Codable.
struct FuelType : Codable {
    
    let text : String?
    let value : Int?
    let images : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "text"
        case value = "value"
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        images = try values.decodeIfPresent(String.self, forKey: .images)
    }
    
}

// MARK: - ManufactureYear
/// Represents vehicle manufacture year and conforms to Codable.
struct ManufactureYear : Codable {
    
    let text : String?
    let value : Int?
    let images : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "text"
        case value = "value"
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        images = try values.decodeIfPresent(String.self, forKey: .images)
    }
}

// MARK: - VehicleCapacity
/// Represents vehicle capacity and conforms to Codable.
struct VehicleCapacity : Codable {
    
    let text : String?
    let value : Int?
    let images : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "text"
        case value = "value"
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        images = try values.decodeIfPresent(String.self, forKey: .images)
    }
    
}

// MARK: - VehicleMake
/// Represents vehicle make and conforms to Codable.
struct VehicleMake : Codable {
    
    let text : String?
    let value : Int?
    let images : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "text"
        case value = "value"
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        images = try values.decodeIfPresent(String.self, forKey: .images)
    }
}

// MARK: - VehicleType
/// Represents vehicle type and conforms to Codable.
struct VehicleType : Codable {
    
    let text : String?
    let value : Int?
    let images : String?
    
    enum CodingKeys: String, CodingKey {
        
        case text = "text"
        case value = "value"
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        images = try values.decodeIfPresent(String.self, forKey: .images)
    }
    
}
