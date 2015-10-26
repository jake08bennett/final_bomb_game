require 'gosu'
require_relative "player"
require_relative "z_order"
require_relative "star"
require_relative "bomb"
require_relative "laser"

class GameWindow < Gosu::Window
	def initialize
		super 640, 480
		@font = Gosu::Font.new(20)
		@background_image = Gosu::Image.new("media/space.jpg", :tileable => true)
		@player = Player.new
		@player.warp(320, 240)
		@star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
		@stars = Array.new
		@bombs = Array.new
		@lasers = Array.new
	end

	def update
		if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
			@player.accelerate
		end
		if Gosu::button_down? Gosu::KbSpace
			@lasers.push(@player.shoot_laser)
		end
		if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
			@player.turn_left
		end  
		if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
			@player.turn_right
		end


		@player.move
		@player.collect_stars(@stars)
		@player.damage_by_bomb(@bombs)


		if rand(100) < 4 and @stars.size < 25 then
			@stars.push(Star.new(@star_anim))
		end
		if rand(300) < 4 and @bombs.size < 10
			@bombs.push(Bomb.new(@player , self))
		end




		 @bombs.each { |bomb|
		 	 bomb.hit_by_laser?(@lasers)  	
		 }
		 @lasers.each { |laser|
		 	laser.move
		 }
		
		 @bombs.each { |bomb|
		 	if bomb.exploded_drawn? == true 
		 		@bombs.delete(bomb)
		 	end
		 }
	end

	def draw
		@bombs.each { |bomb| bomb.draw}
		@lasers.each {|laser| laser.draw}
		@font.draw("Score: #{@player.score}", 20, 20, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
		@player.draw
		@background_image.draw(0,0,0)
		@stars.each { |star| star.draw}
	end
end

window = GameWindow.new
window.show