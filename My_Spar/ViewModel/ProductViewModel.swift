//
//  ProductViewModel.swift
//  My_Spar
//
//  Created by Yaroslav Zagumennikov on 03.02.2024.
//

import Foundation

class ProductViewModel : ObservableObject {
    @Published var product : Product
    
    @Published var rev : Double = 0
    
    init() {
        self.product = Product(
            name: "Добавка \"Липа\" к чаю 200 г",
            image: "https://s.alicdn.com/@sc01/kf/U7f0dfcc5fb22436cabf2adce768a249fH.jpg",
            country: "🇪🇸 Испания, Риоха",
            description: "Флавоноиды липового цвета, обладают противовоспалительным действием, способствуют укреплению стенки сосудов.",
            characteristics: [
                MainFeatures(key: "Производство", value: "Россия, Краснодарский край"),
                MainFeatures(key: "Энергетическая ценность, ккал/100г", value: "25 ккал, 105 кДж"),
                MainFeatures(key: "Жиры/100г", value: "0,1 г"),
                MainFeatures(key: "Белки/100г", value: "1,3 г"),
                MainFeatures(key: "Углеводы/100г", value: "3,3 г"),
            ],
            reviews: [
                Review(name: "Александр В.", date: Date(), review: 4, reviewDescription: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими"),
                Review(name: "Александр П.", date: Date(), review: 3, reviewDescription: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими"),
                Review(name: "Александр Г.", date: Date(), review: 5, reviewDescription: "Хорошая добавка, мне очень понравилась! Хочу, чтобы все добавки были такими")
            ]
        )
    }    
}

