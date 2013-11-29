json.array!(@imports) do |import|
  json.extract! import, :useless
  json.url import_url(import, format: :json)
end
