//
//  AlertHelper.swift
//  ChatTableView
//
//  Created by Vamsi on 12/09/24.
//

import UIKit
import Foundation

func isNetworkReachable() -> Bool
{
    if Reachability.isConnectedToNetwork()
    {
        return true
        
    } else {
        
        return false
    }
}

// MARK : Alert
protocol ShowAlert {}

extension ShowAlert where Self: UIViewController
{
    
    func showAlertWithActions(_ message:String) {
        
        let alertController = UIAlertController(title: "Vehicle", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            
            _ = self.navigationController?.popViewController(animated: true)

        })
        present(alertController, animated: true, completion:nil)
    }
}
