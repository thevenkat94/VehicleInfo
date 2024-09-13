//
//  Constants.swift
//  Vehicle Information
//
//  Created by Venkat on 12/09/24.
//

import Foundation

//MARK:- Constant URL's
struct Constants {
    
    //MARK:- API Services List
    struct APIs {
        
        static let BaseUrl = "http://103.123.173.50:8090/jhsmobileapi/mobile"
        static let VehicleInfo = "/configure/v1/task"
    }
}


/// Contains static constants used in the application.
enum Scanner {
    
    static let alertTitle = "Scanning is not supported"
    static let alertMessage = "Your device does not support scanning a code from an item. Please use a device with a camera."
    static let alertButtonTitle = "OK"
}

/// Represents different menu types.
enum MenuType: Int {
    
    case type = 1
    case capacity
    case make
    case manufactureYear
    case fuelType
}
