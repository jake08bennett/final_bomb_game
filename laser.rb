
class Laser

	SPEED = 10
	attr_reader :x, :y

    def initialize(x,y,angle)
		@image = Gosu::Image.new("media/laser.png")
        @x = x
        @y = y
		@angle = angle
	end

	def draw
		@image.draw_rot(@x,@y, 1, @angle)
	end

	def move
		@x += Gosu::offset_x(@angle, SPEED)
		@y += Gosu::offset_y(@angle, SPEED)
	end

end




