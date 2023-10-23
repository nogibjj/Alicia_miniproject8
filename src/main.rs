mod lib; // Import the lib module
use csv::ReaderBuilder;
use std::error::Error;
use std::fs::File;
use std::process::Command;
use std::time::Instant;

fn main() -> Result<(), Box<dyn Error>> {
    let start_time = Instant::now();
    // 1. Read the cars.csv file
    let file = File::open("full_data.csv")?;

    // Create the CSV reader with the specified delimiter
    let mut rdr = ReaderBuilder::new()
        .delimiter(b';') // Set the delimiter to ;
        .has_headers(true)
        .from_reader(file);

    // Find the index of first
    let headers = rdr.headers()?;
    let age_index = headers
        .iter()
        .position(|h| h == "age")
        .ok_or("age column not found")?;

    // 2. Extract the "Weight" column from the CSV data
    let mut ages: Vec<f64> = Vec::new();
    for result in rdr.records() {
        let record = result?;
        if let Some(age_str) = record.get(age_index) {
            if let Ok(age) = age_str.parse::<f64>() {
                ages.push(age);
            }
        }
    }

    // 3. Compute the statistics
    let stats = lib::compute_statistics(&ages);
    println!("Mean: {}", stats.mean);
    println!("Median: {}", stats.median);
    println!("Standard Deviation: {}", stats.std);
    println!("Size: {}", stats.size);
    let end_time = Instant::now();

    // Calculate the elapsed time and resource usage
    let elapsed_time = end_time.duration_since(start_time);
    println!("Total execution time: {:?}", elapsed_time); // Print the elapsed time
                                                          // Memory usage
    let mem_info = sys_info::mem_info().unwrap();
    println!(
        "Memory Usage: {}%",
        (mem_info.total - mem_info.avail) as f32 / mem_info.total as f32 * 100.0
    );
    // CPU calculation
    let output = Command::new("ps")
        .arg("-o")
        .arg("%cpu")
        .arg("-p")
        .arg(format!("{}", std::process::id()))
        .output()
        .expect("Failed to execute ps command");

    // Convert the output to a string
    let usage = String::from_utf8_lossy(&output.stdout);
    let lines: Vec<&str> = usage.split('\n').collect();

    // Parse the CPU usage from the output
    if lines.len() >= 2 {
        let usage_str = lines[1].trim();
        let usage_float: Result<f32, _> = usage_str.parse();
        match usage_float {
            Ok(usage) => println!("CPU Usage: {:.2}%", usage),
            Err(_) => println!("Failed to parse CPU usage"),
        }
    } else {
        println!("Failed to get CPU usage");
    }
    Ok(())
}
