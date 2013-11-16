json.array!(@courses) do |course|
  json.extract! course, :topic, :description
  json.url course_url(course, format: :json)
end
