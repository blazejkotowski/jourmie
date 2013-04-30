class PrettyJson
  def self.dump(object)
    JSON.pretty_generate(object, {:indent => "  "})
  end
end

Rabl.configure do |config|
  config.include_json_root = false
  config.include_child_root = false
  config.json_engine = PrettyJson if Rails.env.development?
end
