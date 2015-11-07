module ApplicationHelper
  def smartphone?
    ua = request.user_agent
    return true if ua.match(/iPhone/i)
    return true if ua.match(/Android/i) && ua.match(/Mobile/i)
    false
  end

  def push_support?
    ua = request.user_agent
    return true if ua.match(/Chrome/i) # FIXME: これは厳密ではない
    false
  end

  def li_link_to_tel
    if !(@tel.blank?) && smartphone?
      content_tag :li, id: 'tel' do
        link_to raw('<i class="fa fa-phone"></i> 電話する'), 'tel:' + @tel
      end
    elsif @tel.blank?
      content_tag :li, id: 'tel', class: 'disabled', 'data-toggle': "tooltip", 'data-placement': "bottom", title: "電話番号が未設定です" do
        link_to raw('<i class="fa fa-phone"></i> 電話する'), '#'
      end
    elsif !smartphone?
      content_tag :li, id: 'tel', class: 'disabled', 'data-toggle': "tooltip", 'data-placement': "bottom", title: "スマートフォンの場合に有効になります" do
        link_to raw('<i class="fa fa-phone"></i> 電話する'), '#'
      end
    end
  end

  def li_link_to_push
    if push_support?
      menu_text = current_user.subscription_id.blank? ? 'イベント通知登録' : 'イベント通知解除'
      content_tag :li do
        link_to raw('<i class="fa fa-bell"></i>' + menu_text), 'javascript:void(0)', class: 'js-push-button'
      end
    else
      content_tag :li, class: 'disabled', 'data-toggle': "tooltip", 'data-placement': "left", title: "お使いのブラウザは対応していません" do
        link_to raw('<i class="fa fa-bell"></i> イベント通知登録'), 'javascript:void(0)', class: 'js-push-button'
      end
    end
  end
end
