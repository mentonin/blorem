#import "/src/lib.typ": lorem

#let hdr = std.lorem(17).slice(0, -1)

#for n in (17, 42, 1234) {
  let max-int = 9223372036854775807 // 2^63 - 1
  // equivalent to std
  assert(lorem(n) == std.lorem(n))
  // header: true works
  assert(lorem(n, header: true, seed: 42).slice(0, hdr.len()) == hdr)
  // header: false works
  assert(lorem(n, header: false).slice(0, hdr.len()) != hdr)
  // header: auto is false with manual seed
  assert(lorem(n, seed: 42).slice(0, hdr.len()) != hdr)
  assert(lorem(n, seed: 97).slice(0, hdr.len()) != hdr)
  // default seed == 97
  assert(lorem(n, seed: 97, header: true) == lorem(n, header: true))
  assert(lorem(n, seed: 97, header: false) == lorem(n, header: false))
  // seed matters
  assert(lorem(n, seed: 42) != lorem(n))
  assert(lorem(n, seed: 42, header: false) != lorem(n, header: false))
  assert(lorem(n, seed: 42) != lorem(n, seed: 123))
  assert(lorem(n, seed: 42, header: false) != lorem(n, seed: 123, header: false))
  // deterministic
  assert(lorem(n, seed: 42) == lorem(n, seed: 42))
  assert(lorem(n, seed: 42, header: false) == lorem(n, seed: 42, header: false))
  // seed can use full int range, n is respected
  assert(lorem(n, seed: -1).split().len() == n)
  assert(lorem(n, seed: -1, header: false).split().len() == n)
  assert(lorem(n, seed: 0).split().len() == n)
  assert(lorem(n, seed: 0, header: false).split().len() == n)
  assert(lorem(n, seed: max-int).split().len() == n)
  assert(lorem(n, seed: max-int, header: false).split().len() == n)
  assert(lorem(n, seed: -max-int - 1).split().len() == n)
  assert(lorem(n, seed: -max-int - 1, header: false).split().len() == n)
}
