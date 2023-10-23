pub struct Statistics {
    pub mean: f64,
    pub median: f64,
    pub std: f64,
    pub size: usize,
}

pub fn compute_statistics(data: &Vec<f64>) -> Statistics {
    let size = data.len();
    let sum: f64 = data.iter().sum();
    let mean = sum / size as f64;

    let mut sorted_data = data.clone();
    sorted_data.sort_by(|a, b| a.partial_cmp(b).unwrap());

    let median = if size % 2 == 1 {
        sorted_data[size / 2]
    } else {
        (sorted_data[size / 2 - 1] + sorted_data[size / 2]) / 2.0
    };

    let variance: f64 = data.iter().map(|&x| (x - mean).powi(2)).sum::<f64>() / size as f64;
    let std = variance.sqrt();

    Statistics {
        mean,
        median,
        std,
        size,
    }
}
