file_contents   = File.read(Rails.root.join("sample_files/www.softwareishard.com.chrome.har"))
SAMPLE_RAW_DATA = JSON.parse(file_contents).with_indifferent_access.freeze

SAMPLE_RAW_DATA_TITLE         = SAMPLE_RAW_DATA.fetch(:log).fetch(:pages).first.fetch(:title)
SAMPLE_RAW_DATA_LOAD_TIMING   = SAMPLE_RAW_DATA.fetch(:log).fetch(:pages).first.fetch(:pageTimings).fetch(:onLoad)
SAMPLE_RAW_DATA_ENTRIES_COUNT = SAMPLE_RAW_DATA.fetch(:log).fetch(:entries).size
