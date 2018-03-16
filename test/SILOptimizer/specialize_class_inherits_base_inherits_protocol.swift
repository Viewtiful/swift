// RUN: %target-swift-frontend -emit-sil -O %s | %FileCheck %s

protocol P { func p() -> Any.Type }
protocol Q: P { }

@inline(never) func sink<T>(_ x: T) {}

func p<T: Q>(_ x: T) { sink(x.p()) }

class Foo<T>: Q { func p() -> Any.Type { return T.self } }
class Bar<T>: Foo<T> {}

// CHECK-LABEL: sil @$S031specialize_class_inherits_base_C9_protocol3fooyyF
public func foo() {
  // CHECK: function_ref @$S031specialize_class_inherits_base_C9_protocol4sinkyyxlFypXp_Tg5Tf4d_n
  p(Bar<Int>())
}

