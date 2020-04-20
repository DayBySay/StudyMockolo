install:
	pod install

mock:
	mockolo -s StudyMockolo -d StudyMockoloTests/OutputMocks.swift -i StudyMockolo
