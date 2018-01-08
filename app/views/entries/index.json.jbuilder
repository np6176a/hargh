json.entries do
  json.partial! "entry", collection: @entries, as: :entry
end
