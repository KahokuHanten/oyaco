module HomeHelper
  def timeline_pos(index)
    index.even? ? "pos-left" : "pos-right"
  end
end
