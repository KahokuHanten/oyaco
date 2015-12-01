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
        link_to raw('<i class="fa fa-phone"></i>&nbsp; 電話する'), 'tel:' + @tel
      end
    elsif @tel.blank?
      content_tag :li, id: 'tel', class: 'disabled', 'data-toggle': "tooltip", 'data-placement': "auto", title: "電話番号が設定されていません" do
        link_to raw('<i class="fa fa-phone"></i>&nbsp; 電話する'), 'javascript:void(0)'
      end
    elsif !smartphone?
      content_tag :li, id: 'tel', class: 'disabled', 'data-toggle': "tooltip", 'data-placement': "auto", title: "スマートフォンの場合に有効になります" do
        link_to raw('<i class="fa fa-phone"></i>&nbsp; 電話する'), 'javascript:void(0)'
      end
    end
  end

  def li_link_to_input_event
    if user_signed_in?
      content_tag :li do
        link_to raw('<i class="fa fa-calendar-plus-o fa-lg"></i>&nbsp; 記念日を追加'), "#input-event", 'data-toggle': "modal"
      end
    else
      content_tag :li, class: 'disabled', 'data-toggle': "tooltip", 'data-placement': "auto", title: "ユーザー登録が必要です" do
        link_to raw('<i class="fa fa-calendar-plus-o fa-lg"></i>&nbsp; 記念日を追加'), 'javascript:void(0)'
      end
    end
  end

  def li_link_to_push
    if push_support?
      menu_text = current_user.subscription_id.blank? ? 'イベント通知登録' : 'イベント通知解除'
      content_tag :li do
        link_to raw('<i class="fa fa-bell fa-fw"></i>&nbsp; ' + menu_text), 'javascript:void(0)', class: 'js-push-button'
      end
    else
      content_tag :li, class: 'disabled', 'data-toggle': "tooltip", 'data-placement': "auto", title: "お使いのブラウザは対応していません" do
        link_to raw('<i class="fa fa-bell fa-fw"></i>&nbsp; イベント通知登録'), 'javascript:void(0)'
      end
    end
  end

  def pref_code2name(code)
    pref = JpPrefecture::Prefecture.find code
    pref.name
  end

  def pref_name2code(name)
    pref = JpPrefecture::Prefecture.find(name: name)
    pref.code.to_s
  end

  def format_date(date)
    return '' unless date
    format = '%Y年%-m月%e日'
    date.strftime(format)
  end
end
