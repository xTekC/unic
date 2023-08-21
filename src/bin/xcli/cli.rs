/******************************
 *  Copyright (c) xTekC.      *
 *  Licensed under MPL-2.0.   *
 *  See LICENSE for details.  *
 *                            *
 ******************************/

use clap::Parser;
use std::fs;
use std::path::Path;
use unic::xcore::core::core_main;

#[derive(Parser)]
struct Opts {
    #[arg()]
    input_file: String,
}

pub async fn cli_main() {
    let opts: Opts = Opts::parse();
    let content = fs::read_to_string(&opts.input_file).expect("Failed to read the file");

    let result = core_main(&content);

    let output_path = format!("uni.{}", Path::new(&opts.input_file).display());
    fs::write(&output_path, result).expect("Unable to write to file");
    println!("Output saved as: {}", output_path);
}
