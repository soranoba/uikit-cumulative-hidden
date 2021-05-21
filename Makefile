
init:
	bundle install
	bundle exec pod install

test:
	xcodebuild -workspace Sample.xcworkspace -scheme Sample -disable-concurrent-destination-testing \
		-destination-timeout 300 \
		-destination 'platform=iOS Simulator,name=iPhone 11,OS=14.4' \
		clean test \
		FROM_XCODEBUILD=FROM_XCODE_BUILD
