module ApplicationHelper
  def smartphone?
    ua = request.user_agent
    return true if ua.match(/iPhone/i)
    return true if ua.match(/Android/i) && ua.match(/Mobile/i)
    false
  end

  def tel_link
    if !(@tel.blank?) && smartphone?
      content_tag :li, id: 'tel' do
        link_to raw('<i class="fa fa-phone"></i> 電話する'), 'tel:' + @tel
      end
    else
      content_tag :li, id: 'tel', class: 'disabled' do
        link_to raw('<i class="fa fa-phone"></i> 電話する'), '#'
      end
    end
  end
end
