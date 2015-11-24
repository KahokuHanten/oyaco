# -*- coding: utf-8 -*-
class Questionnaire
  include ActiveModel::Model

  attr_accessor :dad, :mom, :pref_code, :tel, :hobby, :hobby2, :hobby3

  def save # to pass render_wizard @questionnaire
    true
  end

  def assign_attributes(params)
    return if params.blank?
    begin
      if params.key?('dad(1i)') && params.key?('dad(2i)') && params.key?('dad(3i)')
        dad_year = params['dad(1i)'].to_i
        dad_month = params['dad(2i)'].to_i
        dad_day = params['dad(3i)'].to_i
        self.dad = Date.new(dad_year, dad_month, dad_day)
      end
    rescue ArgumentError
      self.dad = Oyaco::Application.config.default_birthday
    end

    begin
      if params.key?('mom(1i)') && params.key?('mom(2i)') && params.key?('mom(3i)')
        mom_year = params['mom(1i)'].to_i
        mom_month = params['mom(2i)'].to_i
        mom_day = params['mom(3i)'].to_i
        self.mom = Date.new(mom_year, mom_month, mom_day)
      end
    rescue ArgumentError
      self.mom = Oyaco::Application.config.default_birthday
    end

    self.pref_code = params[:pref_code] if params[:pref_code]
    self.tel = params[:tel] if params[:tel]
    self.hobby = params[:hobby] if params[:hobby]
    self.hobby2 = params[:hobby2] if params[:hobby2]
    self.hobby3 = params[:hobby3] if params[:hobby3]
  end

  def restore_attributes_from_cookies(cookies)
    if cookies.signed[:dad]
      self.dad = Date.parse(cookies.signed[:dad])
    end

    if cookies.signed[:mom]
      self.mom = Date.parse(cookies.signed[:mom])
    end

    self.pref_code = cookies.signed[:pref_code] || '1'
    self.tel = cookies.signed[:tel] || ''
    self.hobby = cookies.signed[:hobby] || '温泉旅行'
    self.hobby2 = cookies.signed[:hobby2] || 'ゴルフ'
    self.hobby3 = cookies.signed[:hobby3] || '落語'
  end
end
