//
//  RealmService.swift
//  WeatherInfo
//
//  Created by Лаборатория on 09.12.2023.
//

import Foundation
import RealmSwift

class RealmService {

    static let shared = RealmService()
    private let dataBase = try! Realm()

    private init() { }

    func createObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.add(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }
//
//    func updateObject<T>(oldObject: T, newObject: T) {
//        if let oldObject = oldObject as? WeatherData, let newObject = newObject as? WeatherData {
//            do {
//                try dataBase.write {
//                    oldObject.name = newObject.name
//                    oldObject.ratio = newObject.ratio
//                    oldObject.isWeight = newObject.isWeight
//                }
//            } catch {
//                print("Неисправность базы данных")
//            }
//        }
//        if let oldObject = oldObject as? Product, let newObject = newObject as? Product {
//            do {
//                try dataBase.write {
//                    oldObject.name = newObject.name
//                    oldObject.density = newObject.density
//                }
//            } catch {
//                print("Неисправность базы данных")
//            }
//        }
//        if let oldObject = oldObject as? Recipe, let newObject = newObject as? Recipe {
//            do {
//                try dataBase.write() {
//                    oldObject.name = newObject.name
//                    oldObject.Image = newObject.Image
//                    oldObject.ingredients = newObject.ingredients
//                    oldObject.cookingMethod = newObject.cookingMethod
//                    oldObject.dish = newObject.dish
//                }
//            } catch {
//                print("Неисправность базы данных")
//            }
//        }
//        if let oldObject = oldObject as? Dish, let newObject = newObject as? Dish {
//            do {
//                try dataBase.write {
//                    oldObject.name = newObject.name
//                }
//            } catch {
//                print("Неисправность базы данных")
//            }
//        }
//    }

    func deleteObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.delete(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }
}
