module IframeHelpers
  def find_in_frame(selector, input, values)
    frame = find(selector)
    within_frame(frame) do
      values.to_s.chars.each do |piece|
        find_field(input).send_keys(piece)
      end
    end
  end
end
