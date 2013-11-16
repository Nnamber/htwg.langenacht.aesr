json.array!(@answers) do |answer|
  json.extract! answer, :notice, :body, :correct, :pattern, :question_id
  json.url answer_url(answer, format: :json)
end
