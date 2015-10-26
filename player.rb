class Player
	def initialize
		@image = Gosu::Image.new("media/trooper.png")
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
	end
	
	def warp(x , y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= 4.5
	end

	def score
		@score
	end

	def turn_right
		@angle += 4.5
	end

	def accelerate
		@vel_x += Gosu::offset_x(@angle, 0.5)
		@vel_y += Gosu::offset_y(@angle, 0.5)
	end

	def move
		@x += @vel_x
		@y += @vel_y
		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
		
	end

	def draw
		@image.draw_rot(@x, @y, 1, @angle)
	end

 def collect_stars(stars)
   stars.reject! do |star|
     if Gosu::distance(@x, @y, star.x, star.y) < 30 then
       @score += 25
       true
     else
       false
     end
  end

  def shoot_laser
  	return Laser.new(@x, @y, @angle)
  end

  def damage_by_bomb(explosive)
   explosive.reject! do |bomb|
   	 if Gosu::distance(@x, @y, bomb.x, bomb.y) < 99 && bomb.exploded_drawn? then
        true
      else
        false
      end
  end
end
end
end
