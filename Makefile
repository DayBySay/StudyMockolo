install:
	pod install

mock:
	mockolo -s StudyMockolo -d StudyMockoloTests/OutputMocks.swift -i StudyMockolo

test:
	xcodebuild -sdk iphonesimulator \
		-configuration Debug\
		-workspace StudyMockolo.xcworkspace\
		-scheme StudyMockolo\
		clean test
