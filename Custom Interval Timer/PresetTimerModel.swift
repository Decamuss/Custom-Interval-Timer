import UIKit

struct PresetTimerModel: Codable {
    var timerId: Int
    var interval: Int
    var rest: Int
    var reps: Int
    var name: String
}
