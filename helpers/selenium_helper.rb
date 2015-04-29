#Methods that make it easier to use Selenium/Watir/PageObject
require_relative 'default_watir'

class SeleniumHelper

  #Retreives the distance between two elements in x,y coordinates
  #<br>second_element - first_element
  # *Parameters:*
  # * +first_element+ - The first element of interest
  # * +element_to_move_to+ - The second element of interest
  # *Returns:*
  # * Hash with keys:
  # * *x_distance
  # * *y_distance
  def self.get_pixels_to_move(first_element, second_element)
    first_element_position = first_element.element.wd.location
    first_element_x_position = first_element_position[0]
    first_element_y_position = first_element_position[1]

    second_element_position = second_element.element.wd.location
    second_element_x_position = second_element_position[0]
    second_element_y_position = second_element_position[1]


    x_distance = second_element_x_position - first_element_x_position
    y_distance  = second_element_y_position - first_element_y_position

    return {x_distance: x_distance, y_distance: y_distance}
  end
end
