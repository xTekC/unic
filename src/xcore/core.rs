/******************************
 *  Copyright (c) xTekC.      *
 *  Licensed under MPL-2.0.   *
 *  See LICENSE for details.  *
 *                            *
 ******************************/

pub fn core_main(input: &str) -> String {
    input
        .chars()
        .map(|c| {
            if c.is_whitespace() {
                match c {
                    '\n' => "\n".to_string(),
                    '\t' => keys_to_unicode(&c.to_string()).join(""),
                    _ => " ".to_string(),
                }
            } else if c.is_numeric() {
                numbers_to_unicode(&c.to_string()).join("")
            } else if c.is_alphabetic() {
                letters_to_unicode(&c.to_string()).join("")
            } else {
                symbols_to_unicode(&c.to_string()).join("")
            }
        })
        .collect()
}

fn numbers_to_unicode(s: &str) -> Vec<String> {
    s.chars()
        .filter(|c| c.is_numeric())
        .map(|c| format!("U+{:04X}", c as u32))
        .collect()
}

fn letters_to_unicode(s: &str) -> Vec<String> {
    s.chars()
        .filter(|c| c.is_alphabetic())
        .map(|c| format!("U+{:04X}", c as u32))
        .collect()
}

fn symbols_to_unicode(s: &str) -> Vec<String> {
    s.chars()
        .filter(|c| !c.is_alphanumeric() && !c.is_whitespace())
        .map(|c| format!("U+{:04X}", c as u32))
        .collect()
}

fn keys_to_unicode(s: &str) -> Vec<String> {
    s.chars()
        .filter(|c| *c == ' ' || *c == '\t')
        .map(|c| format!("U+{:04X}", c as u32))
        .collect()
}
