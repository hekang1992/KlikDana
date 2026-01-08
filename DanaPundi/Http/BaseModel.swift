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
    var ruspay: [olModel]?
    var semaair: String?
    var recentable: recentableModel?
    var amor: [amorModel]?
    var cortwhiteible: amorModel?
    var abilityfaction: cardiitudeModel?
    var cardiitude: cardiitudeModel?
    var bank: String?
    var catchtic: String?
    var hemeror: String?
    var cochlia: String?
    var simplyule: String?
    var protostrongty: String?
    var ol: [olModel]?
    var octon: octonModel?
}

class octonModel: Codable {
    var ruspay: [olModel]?
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

class plicierModel: Codable {
    var catchtic: String?
    var peaceent: String?
    var plicier: [plicierModel]?
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

class discussenModel: Codable {
    var catchtic: String?
    var stenics: String?
    
    enum CodingKeys: String, CodingKey {
        case catchtic, stenics
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let stringValue = try? container.decode(String.self, forKey: .stenics) {
            stenics = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .stenics) {
            stenics = String(intValue)
        } else {
            stenics = nil
        }
        
        catchtic = try? container.decode(String.self, forKey: .catchtic)
    }
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
    var gestspecial: String?
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
        
        if let stringValue = try? container.decode(String.self, forKey: .gestspecial) {
            gestspecial = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .gestspecial) {
            gestspecial = String(intValue)
        } else {
            gestspecial = nil
        }
        
        jugespecially = try? container.decode(String.self, forKey: .jugespecially)
        allelist = try? container.decode(String.self, forKey: .allelist)
        tinacithroughling = try? container.decode(String.self, forKey: .tinacithroughling)
        potamosion = try? container.decode(String.self, forKey: .potamosion)
        designetic = try? container.decode(String.self, forKey: .designetic)
        tergward = try? container.decode(Int.self, forKey: .tergward)
        plas = try? container.decode(String.self, forKey: .plas)
        fraterbedform = try? container.decode(String.self, forKey: .fraterbedform)
    }
}

class olModel: Codable {
    var canfy: String?
    var actship: String?
    var peaceent: String?
    var eitherency: String?
    var hiblaughdom: String?
    var stenics: String?
    var aristition: String?
    var discussen: [discussenModel]?
    var appear: [appearModel]?
    var catchtic: String?
    var plicier: [plicierModel]?
    var itinerling: [discussenModel]?
    var tendade: String?
    var an: String?
    var problemel: String?
    var defenseule: String?
    var pageorium: String?
    var thoughance: String?
    var tactad: String?
    var thankia: String?
    
    enum CodingKeys: String, CodingKey {
        case canfy
        case actship
        case peaceent
        case eitherency
        case hiblaughdom
        case stenics
        case aristition
        case discussen
        case appear
        case catchtic
        case plicier
        case itinerling
        case tendade
        case an
        case problemel
        case defenseule
        case pageorium
        case thoughance
        case tactad
        case thankia
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let stringValue = try? container.decode(String.self, forKey: .aristition) {
            aristition = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .aristition) {
            aristition = String(intValue)
        } else {
            aristition = nil
        }
        
        canfy = try? container.decode(String.self, forKey: .canfy)
        actship = try? container.decode(String.self, forKey: .actship)
        peaceent = try? container.decode(String.self, forKey: .peaceent)
        eitherency = try? container.decode(String.self, forKey: .eitherency)
        hiblaughdom = try? container.decode(String.self, forKey: .hiblaughdom)
        stenics = try? container.decode(String.self, forKey: .stenics)
        discussen = try? container.decode([discussenModel].self, forKey: .discussen)
        appear = try? container.decode([appearModel].self, forKey: .appear)
        catchtic = try? container.decode(String.self, forKey: .catchtic)
        plicier = try? container.decode([plicierModel].self, forKey: .plicier)
        itinerling = try? container.decode([discussenModel].self, forKey: .itinerling)
        tendade = try? container.decode(String.self, forKey: .tendade)
        an = try? container.decode(String.self, forKey: .an)
        problemel = try? container.decode(String.self, forKey: .problemel)
        defenseule = try? container.decode(String.self, forKey: .defenseule)
        pageorium = try? container.decode(String.self, forKey: .pageorium)
        thoughance = try? container.decode(String.self, forKey: .thoughance)
        tactad = try? container.decode(String.self, forKey: .tactad)
        thankia = try? container.decode(String.self, forKey: .thankia)
    }
    
}
