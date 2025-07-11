use sysinfo::System;

pub struct SystemInfo {
    pub os:       String,
    pub kernel:   String,
    pub uptime:   String,
    pub hostname: String,
}

impl SystemInfo {
    pub fn new() -> Self {
        let os = System::name().unwrap_or_else(|| "Unknown OS".to_string());
        let kernel = System::kernel_version().unwrap_or_else(|| "Unknown Kernel".to_string());
        let uptime = format_uptime(System::uptime());
        let hostname = System::host_name().unwrap_or_else(|| "Unknown Hostname".to_string());

        SystemInfo { os, kernel, uptime, hostname }
    }
}

fn format_uptime(secs: u64) -> String {
    let days = secs / (24 * 3600);
    let hours = (secs % (24 * 3600)) / 3600;
    let minutes = (secs % 3600) / 60;

    let mut uptime_str = String::new();
    if days > 0 {
        uptime_str.push_str(&format!("{days}d "));
    }
    if hours > 0 {
        uptime_str.push_str(&format!("{hours}h "));
    }
    if minutes > 0 {
        uptime_str.push_str(&format!("{minutes}m"));
    }

    if uptime_str.is_empty() { "0m".to_string() } else { uptime_str.trim().to_string() }
}
