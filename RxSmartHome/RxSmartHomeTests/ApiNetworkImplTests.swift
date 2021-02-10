//  ApiNetworkImplTests.swift
//  RxSmartHomeTests
//  Created by Eddy R on 09/02/2021.

// Arrange init [expected]
// Act : execute la function [actual]
// Assert  actual † expected


import XCTest

class ApiNetworkImplTests: XCTestCase {
    
    
}
/** url
 got url
 got error
 got data
 got parse
 got obj data
 */
/**  //!\ ◼︎◼︎◼︎ Important ◼︎◼︎◼︎ /!\\ identify difficult Dependency explication
 
 Quand tu fetch des Datas tu utilises URLSession... dans ta methode.
 les test unitaires sont très dure a procedé.
 la solution pour les rendres facile :
 - Extraire le morceau de code voulu URLSession par example.
 - l'injecter dans un protol personnalisé qui implement la fonctionnalité de base
 protocol URLSessionCustom { }
 extension URLSession : URLSessionCustom {  }
 - ajouter dans le protocol la fonction desiré et que tu veux tester,
 Ceci et une bonne methode pour découpler
 */
