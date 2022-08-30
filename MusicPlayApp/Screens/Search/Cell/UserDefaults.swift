//
//  UserDefaults.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 27.08.2022.
//

import Foundation


extension UserDefaults {
    
    static let favoriteTrackKey = "favoriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        
        guard let savedTracks = defaults.object(forKey: UserDefaults.favoriteTrackKey) as? Data else  { return [] }
        
        guard let decodedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? [SearchViewModel.Cell] else { return [] }
        return decodedTracks
    }
}
