require "sinatra/redis"

class Room
  
  ROOM_NAME = "open_rooms"
  
  
  def initialize
    @redis = Redis.new
  end
  
  
  def join
    if @redis.llen(ROOM_NAME) > 0
      @redis.lpop ROOM_NAME
    else
      new_room
    end
  end
  
  
  def leave!(room)
    @redis.rrem ROOM_NAME, 0, room
  end
  
  
  def new_room
    room = Random.new.rand(0...999)
    @redis.rpush ROOM_NAME, room
    room
  end
  
  
end