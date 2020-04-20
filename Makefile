install:
	pod install

mock:
	mockolo -s StudyMockolo -d StudyMockoloTests/OutputMocks.swift -i StudyMockolo

test:
	xcodebuild -workspace StudyMockolo.xcworkspace -scheme StudyMockolo -destination "platform=iOS Simulator,OS=13.0,name=iPhone 11 Pro Max" clean test
