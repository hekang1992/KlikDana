//
//  CitysArrayModel.swift
//  DanaPundi
//
//  Created by hekang on 2026/1/7.
//

import BRPickerView

class CitysArrayModel {
    static let shared = CitysArrayModel()
    private init() {}
    var modelArray: [ruspayModel]?
}

extension CitysArrayModel {
    static func getAddressModelArray(dataSourceArr: [ruspayModel]) -> [BRTextModel] {
        return dataSourceArr.enumerated().map { provinceIndex, provinceDic in
            let provinceModel = BRTextModel()
            provinceModel.code = provinceDic.peaceent ?? ""
            provinceModel.text = provinceDic.catchtic
            provinceModel.index = provinceIndex
            
            let cityList = provinceDic.plicier ?? []
            provinceModel.children = cityList.enumerated().map { cityIndex, cityDic in
                let cityModel = BRTextModel()
                cityModel.code = cityDic.peaceent ?? ""
                cityModel.text = cityDic.catchtic
                cityModel.index = cityIndex
                
                let areaList = cityDic.plicier ?? []
                cityModel.children = areaList.enumerated().map { areaIndex, areaDic in
                    let areaModel = BRTextModel()
                    areaModel.code = areaDic.peaceent ?? ""
                    areaModel.text = areaDic.catchtic
                    areaModel.index = areaIndex
                    return areaModel
                }
                
                return cityModel
            }
            
            return provinceModel
        }
    }
}
