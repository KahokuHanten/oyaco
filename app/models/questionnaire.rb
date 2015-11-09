class Questionnaire
  include ActiveModel::Model

  attr_accessor :dad, :mom
  #取り敢えず誕生日のみ
  #, :pref_id, :tel, :hobby, :hobby2, :hobby3

  #年月日
  def assign_attributes(params)
    begin
      dad_year = params["dad(1i)"].to_i
      dad_month = params["dad(2i)"].to_i
      dad_day = params["dad(3i)"].to_i

      self.dad = Date.new(dad_year, dad_month, dad_day)
    rescue ArgumentError
      self.dad = Oyaco::Application.config.default_birthday
    end

    begin
      mom_year = params["mom(1i)"].to_i
      mom_month = params["mom(2i)"].to_i
      mom_day = params["mom(3i)"].to_i

      self.mom = Date.new(mom_year, mom_month, mom_day)
    rescue ArgumentError
      self.mom = Oyaco::Application.config.default_birthday
    end
  end

  #クッキー　きれいでない
  def restore_attributes_from_cookies(cookies)
    if cookies.signed[:dad]
      begin
        self.dad = Date.parse(cookies.signed[:dad])
      rescue ArgumentError
        self.dad = Oyaco::Application.config.default_birthday
      end
    else
      self.dad = Oyaco::Application.config.default_birthday
    end

    if cookies.signed[:mom]
      begin
        self.mom = Date.parse(cookies.signed[:mom])
      rescue ArgumentError
        self.mom = Oyaco::Application.config.default_birthday
      end
    else
      self.mom = Oyaco::Application.config.default_birthday
    end
  end
end
