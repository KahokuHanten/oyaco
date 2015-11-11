# -*- coding: utf-8 -*-
class Questionnaire
  include ActiveModel::Model

  attr_accessor :dad, :mom, :pref_id, :tel, :hobby, :hobby2, :hobby3

  DEFAULT_BIRTHDAY = Date.new(1960, 10, 10)
  #年月日
  def assign_attributes(params)
    begin
      if params.has_key?("dad(1i)") && params.has_key?("dad(2i)") && params.has_key?("dad(3i)") then
        dad_year = params["dad(1i)"].to_i
        dad_month = params["dad(2i)"].to_i
        dad_day = params["dad(3i)"].to_i
        self.dad = Date.new(dad_year, dad_month, dad_day)
      end
    rescue ArgumentError
      self.dad = DEFAULT_BIRTHDAY
    end

    begin
      if params.has_key?("mom(1i)") && params.has_key?("mom(2i)") && params.has_key?("mom(3i)") then
      mom_year = params["mom(1i)"].to_i
      mom_month = params["mom(2i)"].to_i
      mom_day = params["mom(3i)"].to_i
      self.mom = Date.new(mom_year, mom_month, mom_day)
      end
    rescue ArgumentError
      self.mom = DEFAULT_BIRTHDAY
    end
  end

  #クッキー　きれいでない
  def restore_attributes_from_cookies(cookies)
    if cookies.signed[:dad]
      begin
        self.dad = Date.parse(cookies.signed[:dad])
      rescue ArgumentError
        self.dad = DEFAULT_BIRTHDAY
      end
    else
      self.dad = DEFAULT_BIRTHDAY
    end
    if cookies.signed[:mom]
      begin
        self.mom = Date.parse(cookies.signed[:mom])
      rescue ArgumentError
        self.mom = DEFAULT_BIRTHDAY
      end
    else
      self.mom = DEFAULT_BIRTHDAY
    end
    if cookies.signed[:pref_id]
      begin
        self.pref_id = cookies.signed[:pref_id]
      rescue ArgumentError
      end
    end
    if cookies.signed[:tel]
      begin
        self.tel = cookies.signed[:tel]
      rescue ArgumentError
      end
    end
    if cookies.signed[:hobby]
      begin
        self.tel = cookies.signed[:hobby]
      rescue ArgumentError
      end
    end
    if cookies.signed[:hobby2]
      begin
        self.tel = cookies.signed[:hobby2]
      rescue ArgumentError
      end
    end
    if cookies.signed[:hobby3]
      begin
        self.tel = cookies.signed[:hobby3]
      rescue ArgumentError
      end
    end
  end
end
