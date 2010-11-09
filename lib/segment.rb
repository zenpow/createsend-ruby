require 'createsend'
require 'json'

class Segment
  attr_reader :segment_id

  def initialize(segment_id)
    @segment_id = segment_id
  end

  def subscribers(date, page=1, page_size=1000, order_field="email", order_direction="asc")
    options = { :query => {
      :date => date,
      :page => page,
      :pagesize => page_size,
      :orderfield => order_field,
      :orderdirection => order_direction } }
    response = get "active", options
    Hashie::Mash.new(response)
  end

  def delete
    response = CreateSend.delete "/segments/#{segment_id}.json", {}
  end
  
  private

  def get(action, options = {})
    CreateSend.get uri_for(action), options
  end

  def post(action, options = {})
    CreateSend.post uri_for(action), options
  end

  def put(action, options = {})
    CreateSend.put uri_for(action), options
  end

  def uri_for(action)
    "/segments/#{segment_id}/#{action}.json"
  end

end