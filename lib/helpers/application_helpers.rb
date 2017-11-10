require 'json'

module ApplicationHelpers
  def parse(body)
    JSON.parse body
  end
  def not_found(msg=nil)
    halt 404, msg || "Not Found"
  end
  def bad_request(msg=nil)
    halt 400, msg || "bad request"
  end
end
