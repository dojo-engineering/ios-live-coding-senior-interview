import Testing
@testable import FeatureFlags

struct LegacyFlagsClientTests {

    @Test func isEnabled_returnsConfiguredValue() {
        let client = LegacyFlagsClient(values: ["some_flag": true])
        #expect(client.isEnabled("some_flag") == true)
    }

    @Test func isEnabled_defaultsToFalseForUnknownKey() {
        let client = LegacyFlagsClient(values: [:])
        #expect(client.isEnabled("unknown_flag") == false)
    }
}

struct NewFlagsClientTests {

    @Test func fetchFlag_returnsConfiguredValue() async throws {
        let client = NewFlagsClient(
            remoteValues: ["some-flag": .bool(true)],
            simulatedLatency: .zero,
            failureRate: 0
        )
        let value = try await client.fetchFlag(key: "some-flag")
        #expect(value == .bool(true))
    }

    @Test func fetchFlag_throwsForUnknownKey() async {
        let client = NewFlagsClient(remoteValues: [:], simulatedLatency: .zero, failureRate: 0)

        await #expect(throws: RemoteFlagsError.unknownKey) {
            _ = try await client.fetchFlag(key: "unknown-flag")
        }
    }

    @Test func fetchFlag_throwsOnSimulatedFailure() async {
        let client = NewFlagsClient(
            remoteValues: ["some-flag": .bool(true)],
            simulatedLatency: .zero,
            failureRate: 1
        )

        await #expect(throws: RemoteFlagsError.network) {
            _ = try await client.fetchFlag(key: "some-flag")
        }
    }
}
