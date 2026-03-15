//
//  HomeViewModel.swift
//  DraftKingsPick6_Practice
//
//  Created by Antonio Gargiulo on 3/13/26.
//

import Foundation
import SwiftUI


class HomeViewModel : ObservableObject {
    
    
    @Published var sports: [SportModel] = SportModelDataService.sportArray

    @Published var bannerAds: [UIImage] = []
    
    /*
    https://juzarraga.com/wp-content/uploads/2012/01/mcd_mcbites.jpg
    https://www.toyotadrummondville.com/images/ckfinder/TD-toyota,%20marque-gagnante-08-EN-B.jpg
    https://mediaproxy.tvtropes.org/width/1200/https://static.tvtropes.org/pmwiki/pub/images/limuemuanddouglibertymutual.jpeg
     */
    
    init() {
        
    }
    
    
    
    
}
