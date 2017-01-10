json.time Time.now
json.environment Rails.env

json.version do
  json.name QingDiet::VERNAME
  json.number QingDiet::VERSION
  json.updated_at QingDiet::VERTIME
end
