//
//  DetailsViewModel.swift
//  Kino
//
//  Created by Viktoriya Polozova on 27/08/2024.
//

import UIKit

class DetailsViewModel {
    let model: MovieDetailedInfo
    
    var actors: [Actor] = [
        Actor(fullName: "Noah Hathaway", imageName: "actor"),
        Actor(fullName: "Kaiserin Tami Stronach", imageName: "actor2"),
        Actor(fullName: "Barret Oliver", imageName: "actor3"),
        Actor(fullName: "Moses Gunn", imageName: "actor4")
        ]
    
    init(model: MovieDetailedInfo) {
        self.model = model
    }
    
    func didTapList() {
        
    }
    
    func didTapBack() {
        
    }
    
    func didTapPlayTrailer() {
        
    }
    
    func didTapSeeMore() {
        
    }
}
