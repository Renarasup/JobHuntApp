//
//  HTMLExtension.swift
//  Job Hunt
//
//  Created by Raphael on 2/19/18.
//  Copyright © 2018 ghearly. All rights reserved.
//

import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("Error:", error.localizedDescription)
            return nil
        }
    }
}
