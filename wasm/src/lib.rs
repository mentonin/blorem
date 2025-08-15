use ciborium::{de::from_reader, ser::into_writer};
use rand_chacha::{ChaCha20Rng, rand_core::SeedableRng};
use wasm_minimal_protocol::*;

initiate_protocol!();

fn _seeded_lipsum(n: usize, seed: u64) -> String {
    let rng = ChaCha20Rng::seed_from_u64(seed);
    lipsum::lipsum_with_rng(rng, n)
}

fn _seeded_lipsum_words(n: usize, seed: u64) -> String {
    let rng = ChaCha20Rng::seed_from_u64(seed);
    lipsum::lipsum_words_with_rng(rng, n)
}

#[wasm_func]
pub fn seeded_lipsum(arg: &[u8]) -> Vec<u8> {
    let (n, seed, header): (usize, i64, bool) = from_reader(arg).unwrap();
    let seed = seed as u64;

    let ret = if header {
        _seeded_lipsum(n, seed)
    } else {
        _seeded_lipsum_words(n, seed)
    };

    let ret = ret.replace("--", "–");

    let mut out = Vec::new();
    into_writer(&ret, &mut out).unwrap();
    out
}
