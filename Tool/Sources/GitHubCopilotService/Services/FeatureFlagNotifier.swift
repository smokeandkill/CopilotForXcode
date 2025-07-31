import Combine
import SwiftUI

public extension Notification.Name {
    static let gitHubCopilotFeatureFlagsDidChange = Notification
        .Name("com.github.CopilotForXcode.CopilotFeatureFlagsDidChange")
}

public enum ExperimentValue: Hashable, Codable {
    case string(String)
    case number(Double)
    case boolean(Bool)
    case stringArray([String])
}

public typealias ActiveExperimentForFeatureFlags = [String: ExperimentValue]

public struct FeatureFlags: Hashable, Codable {
    public var rt: Bool
    public var sn: Bool
    public var chat: Bool
    public var ic: Bool
    public var pc: Bool
    public var xc: Bool?
    public var ae: ActiveExperimentForFeatureFlags
    public var agent_mode: Bool?
}

public protocol FeatureFlagNotifier {
    var featureFlags: FeatureFlags { get }
    var featureFlagsDidChange: PassthroughSubject<FeatureFlags, Never> { get }
    func handleFeatureFlagNotification(_ featureFlags: FeatureFlags)
}

public class FeatureFlagNotifierImpl: FeatureFlagNotifier {
    public var featureFlags: FeatureFlags
    public static let shared = FeatureFlagNotifierImpl()
    public var featureFlagsDidChange: PassthroughSubject<FeatureFlags, Never>
    
    init(featureFlags: FeatureFlags = FeatureFlags(rt: false, sn: false, chat: true, ic: true, pc: true, ae: [:]),
         featureFlagsDidChange: PassthroughSubject<FeatureFlags, Never> = PassthroughSubject<FeatureFlags, Never>()) {
        self.featureFlags = featureFlags
        self.featureFlagsDidChange = featureFlagsDidChange
    }

    public func handleFeatureFlagNotification(_ featureFlags: FeatureFlags) {
        self.featureFlags = featureFlags
        self.featureFlags.chat = featureFlags.chat == true && featureFlags.xc == true
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.featureFlagsDidChange.send(self.featureFlags)
            DistributedNotificationCenter.default().post(name: .gitHubCopilotFeatureFlagsDidChange, object: nil)
        }
    }
}
