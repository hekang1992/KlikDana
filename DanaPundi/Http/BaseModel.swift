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
    var semaair: String?
    var recentable: recentableModel?
    var amor: [amorModel]?
    var cortwhiteible: amorModel?
    var abilityfaction: cardiitudeModel?
    var cardiitude: cardiitudeModel?
}

class cardiitudeModel: Codable {
    var pleasphone: pleasphoneModel?
    var byly: Int?
    var semaair: String?
}

class pleasphoneModel: Codable {
    var catchtic: String?
    var bank: String?
    var hemeror: String?
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

class amorModel: Codable {
    var canfy: String?
    var actship: String?
    var byly: Int?
    var mostess: String?
    var greg: String?
    var stenics: Int?
}

class recentableModel: Codable {
    var vadant: String?
    var jugespecially: String?
    var fraterbedform: String?
    var allelist: String?
    var tinacithroughling: String?
    var potamosion: String?
    var designetic: String?
    var tergward: Int?
    var gestspecial: Int?
    var plas: String?

    enum CodingKeys: String, CodingKey {
        case vadant
        case jugespecially
        case allelist
        case tinacithroughling
        case potamosion
        case designetic
        case tergward
        case gestspecial
        case plas
        case fraterbedform
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let stringValue = try? container.decode(String.self, forKey: .vadant) {
            vadant = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .vadant) {
            vadant = String(intValue)
        } else {
            vadant = nil
        }

        jugespecially = try? container.decode(String.self, forKey: .jugespecially)
        allelist = try? container.decode(String.self, forKey: .allelist)
        tinacithroughling = try? container.decode(String.self, forKey: .tinacithroughling)
        potamosion = try? container.decode(String.self, forKey: .potamosion)
        designetic = try? container.decode(String.self, forKey: .designetic)
        tergward = try? container.decode(Int.self, forKey: .tergward)
        gestspecial = try? container.decode(Int.self, forKey: .gestspecial)
        plas = try? container.decode(String.self, forKey: .plas)
        fraterbedform = try? container.decode(String.self, forKey: .fraterbedform)
    }
}

