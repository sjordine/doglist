//
//  DogServices.swift
//  DogBreeds
//
//  Created by SERGIO J RAFAEL ORDINE on 23/08/21.
//


import Foundation

/// Define dog services API business logic
struct DogServices {
    
    let dogAPIURL = "https://api.thedogapi.com/v1"
    let dataManager = DataRequestManager()
    
    
    /// Get the list of available dog breeds
    /// - Parameter completion: completion handler for the resulting breed list
    /// -    Parameter result: List of available breeds or an error
    func breeds(completion:@escaping (_ result: Result<[DogBreed], Error>) -> Void) {
        let url = dogAPIURL + "/breeds"
        
        dataManager.get(url: url) { result in
            switch result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode([DogBreed].self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(DogErrors.invalidData))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
    
    /// Get the list of available dog breeds separated by its groups
    /// - Parameter completion: completion handler for the resulting breed groups
    /// -    Parameter result: List of available breed groups or an error
    func breedGroups(completion: @escaping (_ result: Result<[String:[DogBreed]], Error>) -> Void)  {
        breeds { result in
            switch result {
            case .success(let breeds):
                let breedGroups = Dictionary(grouping: breeds) { breed in
                    breed.group ?? ""
                }
                completion(.success(breedGroups))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    

}
