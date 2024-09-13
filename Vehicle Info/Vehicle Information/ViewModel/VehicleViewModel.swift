//
//  VehicleViewModel.swift
//  Vehicle Information
//
//  Created by Venkat on 12/09/24.
//

import Foundation

// MARK: - VehicleViewModel
/// ViewModel to manage the vehicle information fetched from an API.
class VehicleViewModel {
    
    // MARK: - Properties
    var vehicle: VehicleInfo?
    
    // MARK: - API Call
    /// Fetches the vehicle information from the server and returns a `Result` via completion handler.
    func getVehicleInfo(completion: @escaping (Result<VehicleInfo, Error>) -> Void) {
        
        let sourceURL = Constants.APIs.BaseUrl + Constants.APIs.VehicleInfo
        
        var urlRequest = URLRequest(url: URL(string: sourceURL)!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        // MARK: - Request Body
        let bodyString = [
            "clientid": 11,
            "enterprise_code": 1007,
            "mno": "9889897789",
            "passcode": 3476
        ] as [String : Any]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyString, options: [])
        urlRequest.httpBody = bodyData
        
        // MARK: - Data Task
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let vehicleInfo = try JSONDecoder().decode(VehicleInfo.self, from: data)
                completion(.success(vehicleInfo))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
}
