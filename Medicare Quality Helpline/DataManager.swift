//
//  DataManager.swift
//  Medicare Quality Helpline
//
//  Created by Brad Collins on 1/16/18.
//  Copyright © 2018 livanta. All rights reserved.
//

import Foundation

public final class DataManager {
    public static func getJSONFromURL(_ resource:String, completion:@escaping (_ data:Data?, _ error:Error?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let filePath = Bundle.main.path(forResource: resource, ofType: "json")
            let url = URL(fileURLWithPath: filePath!)
            let data = try! Data(contentsOf: url, options: .uncached)
            completion(data, nil)
        }
        
    }
}
