json.array!(@questions) do |question|
  json.extract! question, :questiontype, :name, :body, :noticewrong, :noticeright, :notice, :topic_id
  json.url question_url(question, format: :json)
end
