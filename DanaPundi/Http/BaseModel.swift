//
//  BaseModel.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/4.
//

class BaseModel: Codable {
    var peaceent: String?
    var cubage: String?
    var anyably: anyablyModel?
    
    enum CodingKeys: String, CodingKey {
        case peaceent, cubage, anyably
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let intValue = try? container.decode(Int.self, forKey: .peaceent) {
            peaceent = String(intValue)
        } else {
            peaceent = try? container.decode(String.self, forKey: .peaceent)
        }
        cubage = try? container.decode(String.self, forKey: .cubage)
        anyably = try? container.decode(anyablyModel.self, forKey: .anyably)
    }
}

class anyablyModel: Codable {
    var controlety: String?
    var radiwise: String?
    var pacho: String?
    var pharmacivity: [pharmacivityModel]?
    var ruspay: [ruspayModel]?
}

class pharmacivityModel: Codable {
    var canfy: String?
    var val: String?
    var discuss: String?
}

class ruspayModel: Codable {
    var stenics: String?
    var appear: [appearModel]?
}

class appearModel: Codable {
    var tinacithroughling: Int?
    var jugespecially: String?
    var potamosion: String?
    var fraterbedform: String?
    var urous: String?
    var tornation: String?
    var federalesque: String?
    var parthenose: String?
    var overitor: String?
    var base: String?
}
