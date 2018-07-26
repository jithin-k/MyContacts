//
//  ContactsController.swift
//  MyContacts
//
//  Created by jithin on 24/07/18.
//  Copyright © 2018 jithin. All rights reserved.
//

import Foundation

class ContactsController {
    
    class func fetchCountriesList(){
        
        guard let request = Networking.urlRequest(endpoint: .allCountries, requestDict: nil, method: .get) else { return }
        
        Networking.execute(request: request) { (result) in
            switch result{
            case .Success(let data):
                self.saveCountriesData(data)
                
            case .Failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    class func saveCountriesData(_ data: Data) {
        let filename = getDocumentsDirectory().appendingPathComponent("countries")
        
        do {
            try data.write(to: filename, options: .atomic)
            Logger.log("data count: \(data.count)")
            
        }catch let error{
            Logger.log(error.localizedDescription)
        }
    }
    
    class func countriesList() -> [Country]?{
        let filepath = getDocumentsDirectory().appendingPathComponent("countries")
        
        do {
            let data = try Data(contentsOf: filepath)
            let decoder = JSONDecoder()
            do{
                let countries = try decoder.decode([Country].self, from: data)
                return countries
            }
            catch {
                return nil
            }
        }
        catch {
            return nil
        }
    }
    
    
}
