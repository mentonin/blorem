
/// Generate deterministic blind text with settable seed
///
/// - n (int): number of words to generate
/// - seed (int): seed to the default number generator.
///   Defaults to same as `std.lorem`
/// - header (bool): whether to always start with same 17 words (Lorem ipsum...)
///
/// -> str
#let lorem(n, seed: auto, header: auto) = {
  if header == auto {
    header = seed == auto
  }
  if seed == auto {
    seed = 97
  }
  assert(
    type(n) == int and n >= 0,
    message: "`n` must be a non-negative integer",
  )
  assert(
    type(seed) == int,
    message: "`seed` must be an integer",
  )
  assert(type(header) == bool, message: "`header` must be a boolean or auto")

  let plg = plugin("typst_blorem.wasm")

  let args = cbor.encode((n, seed, header))
  let ret = cbor(plg.seeded_lipsum(args))

  ret
}
