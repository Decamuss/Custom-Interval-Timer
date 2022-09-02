import Foundation

class PresetTimerService {
    static var getAllObjects: [PresetTimerModel] {
          if let objects = UserDefaults.standard.value(forKey: "preset_timers") as? Data {
             let decoder = JSONDecoder()
             if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [PresetTimerModel] {
                return objectsDecoded
             } else {
                return []
             }
          } else {
             return []
          }
       }

     static func saveAllObjects(allObjects: [PresetTimerModel]) {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(allObjects){
             UserDefaults.standard.set(encoded, forKey: "preset_timers")
          }
     }
    
    static var presetSelected: PresetTimerModel? {
          if let object = UserDefaults.standard.value(forKey: "preset_timer_selected") as? Data {
             let decoder = JSONDecoder()
             if let objectsDecoded = try? decoder.decode(PresetTimerModel.self, from: object) as PresetTimerModel {
                return objectsDecoded
             } else {
                return nil
             }
          } else {
             return nil
          }
       }
    
    static func savePresetSelected(preset: PresetTimerModel) {
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(preset){
            UserDefaults.standard.set(encoded, forKey: "preset_timer_selected")
         }
    }
    
    static func removePresetSelected() {
        UserDefaults.standard.removeObject(forKey: "preset_timer_selected")
    }
}
