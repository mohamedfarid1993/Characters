//
//  ImageProviderTests.swift
//  CharactersTests
//
//  Created by Mohamed Farid on 31/05/2024.
//

import XCTest
import UIKit

@testable import Characters

class ImageProviderTests: XCTestCase {
    
    // MARK: Configuration
    
    func testConfiguration() {
        let size = CGSize(width: 16, height: 9)
        let customConfiguration = ImageProvider.Configuration(placeholder: UIImage(systemName: "person.crop.circle"), size: size)
        let defaultConfiguration = ImageProvider.Configuration.default
        
        XCTAssertNil(defaultConfiguration.placeholder)
        XCTAssertNil(defaultConfiguration.size)
        
        XCTAssertNotNil(customConfiguration.placeholder)
        XCTAssertTrue(customConfiguration.placeholder?.isSymbolImage == true)
        XCTAssertEqual(customConfiguration.size, size)
    }
    
    func testGettingResizingProcessor() {
        
        let size = CGSize(width: 16, height: 9)
        let customConfiguration = ImageProvider.Configuration(placeholder: nil, size: size)
        let defaultConfiguration = ImageProvider.Configuration.default
        
        let defaultConfigurationResizingProcessor = ImageProvider.getResizingProcessor(using: defaultConfiguration)
        let customConfigurationResizingProcessor = ImageProvider.getResizingProcessor(using: customConfiguration)
        
        XCTAssertNil(defaultConfigurationResizingProcessor)
        XCTAssertEqual(customConfigurationResizingProcessor?.size.width, size.width * UIScreen.main.scale)
        XCTAssertEqual(customConfigurationResizingProcessor?.size.height, size.height * UIScreen.main.scale)
    }
}
