file_contents = File.read(Rails.root.join("sample_files/www.softwareishard.com.chrome.har"))
SAMPLE_RAW_ENTRY = JSON.parse(file_contents).with_indifferent_access.freeze
