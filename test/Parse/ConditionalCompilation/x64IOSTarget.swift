// RUN: %swift -typecheck %s -verify -D FOO -D BAR -target x86_64-apple-ios7.0 -D FOO -parse-stdlib
// RUN: %swift-ide-test -test-input-complete -source-filename=%s -target x86_64-apple-ios7.0

#if os(tvOS) || os(watchOS)
// This block should not parse.
// os(tvOS) or os(watchOS) does not imply os(iOS).
let i: Int = "Hello"
#endif

#if arch(x86_64) && os(iOS) && _runtime(_ObjC) && _endian(little)
class C {}
var x = C()
#endif
var y = x
